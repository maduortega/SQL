-- Cursor Kilometragem
Select sum(Km_Atual)
  from loc_veiculo;

DROP PROCEDURE IF EXISTS SomaKilometragem;

DELIMITER //
CREATE PROCEDURE SomaKilometragem (OUT resultado INT)
BEGIN

  -- Definição de variáveis utilizadas na Procedure
  DECLARE existe_mais_linhas INT DEFAULT 0;
  DECLARE kilometros INT DEFAULT 0;
  DECLARE total_de_kilometros INT DEFAULT 0;

  -- Definição do cursor, que irá acessar registro a registro, os valores de veículos.
  DECLARE kmCursor CURSOR FOR SELECT km_atual FROM loc_veiculo;

  -- Definição da variável de controle de looping do cursor
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET existe_mais_linhas=1;

  -- Abertura do cursor
  OPEN kmCursor;

  -- Looping de execução do cursor
  kmLoop: LOOP
  FETCH kmCursor INTO kilometros;

  -- Controle de existir mais registros na tabela. Em não existindo, sair do loop
  IF existe_mais_linhas = 1 THEN
     LEAVE kmLoop;
  END IF;

  -- Soma a kilometragem do registro atual com o total acumulado
  SET total_de_kilometros = total_de_kilometros + kilometros;

  -- Retorna para a primeira linha do loop
  END LOOP kmLoop;

  -- Setando a variável com o resultado final
  SET resultado = total_de_kilometros;
  Select resultado;

  -- Fechar Cursor
  CLOSE kmCursor;

  END //

  DELIMITER ;

  CALL SomaKilometragem(@tempkm);
  Select @tempkm;
  

-- Cursor para Totalizar Locações
DROP PROCEDURE IF EXISTS TotalLocacao;

DELIMITER //
CREATE PROCEDURE TotalLocacao (OUT soma float(10,2)) -- Out é a saída
BEGIN

  -- Definição de variáveis utilizadas na Procedure
  DECLARE existe_mais_linhas INT DEFAULT 0;
  DECLARE Val_Locacao, Tot_Locacao FLOAT(10,2) DEFAULT 0;
  
  -- Definição do cursor, que irá acessar registro a registro, os valores de veículos.
  DECLARE LocCursor CURSOR FOR SELECT Vl_Total FROM loc_pedido_locacao;

  -- Definição da variável de controle de looping do cursor
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET existe_mais_linhas=1;

  SET soma = 0;
  -- Abertura do cursor
  OPEN LocCursor;

  -- Looping de execução do cursor
  LocLoop: LOOP
     FETCH LocCursor INTO Val_Locacao;

     -- Controle de existir mais registros na tabela. Em não existindo, sair do loop
     IF existe_mais_linhas = 1 THEN
        LEAVE LocLoop;
     END IF;

     -- Soma a locacao do registro atual com o total acumulado
     SET soma = soma + Val_Locacao;

     -- Retorna para a primeira linha do loop
  END LOOP LocLoop;

  -- Setando a variável com o resultado final
  
  -- Fechar Cursor
  CLOSE LocCursor;

  END //

  DELIMITER ;

  CALL TotalLocacao(@temp);
  select @temp;

  


-- Cursor Atualiza Orçamento
DROP PROCEDURE IF EXISTS AtualizaOrcamento;

DELIMITER //
CREATE PROCEDURE AtualizaOrcamento ()
BEGIN

  -- Definição de variáveis utilizadas na Procedure
  DECLARE existe_mais_linhas INT DEFAULT 0;
  DECLARE Fun_Cod_Depto, Depto_Cod_Depto INT;
  DECLARE Val_Salario, Val_Orc, Tot_Orc FLOAT;

  -- Definição do cursor, que irá acessar registro a registro, departamentos onde o funcionário trabalha e seu salário
  --    e da tabela de departamentos, localizando o departamento e atualizando o valor do orçamento
  DECLARE FunCursor CURSOR FOR SELECT cd_depto, vl_salario FROM loc_funcionario;
  DECLARE DepCursor CURSOR FOR SELECT cd_depto, vl_Orc_Depto FROM loc_depto;

  -- Definição da variável de controle de looping do cursor
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET existe_mais_linhas=1;

  -- Abertura do cursor
  OPEN FunCursor;
  OPEN DepCursor;

  -- Looping de execução do cursor
  FunLoop: LOOP
     FETCH FunCursor INTO Fun_Cod_Depto, Val_Salario;

     -- Controle de existir mais registros na tabela. Em não existindo, sair do loop
     IF existe_mais_linhas = 1 THEN
        LEAVE FunLoop;
     END IF;

     -- Atualizando o valor do departamento
     Update Loc_Depto 
        Set Vl_Orc_Depto = Vl_Orc_Depto + Val_Salario
        Where cd_depto = Fun_Cod_Depto;

  -- Retorna para a primeira linha do loop
  END LOOP FunLoop;

  -- Setando a variável com o resultado final
  
  -- Fechar Cursor
  CLOSE FunCursor;

  END //

  DELIMITER ;
  
  Call AtualizaOrcamento();
  
  Select Vl_Orc_Depto from loc_depto;
  
  Update loc_depto set Vl_Orc_depto = 0 where cd_depto >= 0;
