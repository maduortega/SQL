use carloca;

-- Elabore função que receba dois números inteiros e apresente os ímpares que sejam menores que o dobro do segundo

-- Obs: a questão da como parâmetro de resposta os números "3 5 7 9 11" entre 2 e 25,
-- Mas a o dobro de 25 é 50, então os impares vão até 49 

DROP PROCEDURE IF EXISTS impares;

DELIMITER //

CREATE PROCEDURE impares(n1 INT,n2 INT)
BEGIN
    DECLARE i INT;
    DECLARE resultado TEXT DEFAULT '';
    DECLARE limite INT;

    SET limite = 2 * n2;
    SET i = n1;

    WHILE i < limite DO
		IF i <> 0 THEN -- Não permite que um valor 0 entre no cálculo
        IF MOD(i, 2) <> 0 THEN
            SET resultado = CONCAT(resultado, i, ' ');
        END IF;
        END IF;
        SET i = i + 1;
    END WHILE;

    SELECT resultado;
END //

DELIMITER ;

call impares(2, 25);






-- Função para apresentar a soma dos salários de cada um dos gerentes

Select Sum(g.Vl_Salario)
  from loc_funcionario f 
  inner join loc_funcionario g on f.cd_gerente = g.cd_func
  group by g.Nm_Func;

-- Teste para que eu entenda onde está o que

select *
  from loc_funcionario;

-- Cursor para Totalizar Salario dos gerentes
DROP PROCEDURE IF EXISTS Total_Salario_Gerente;

DELIMITER //
CREATE PROCEDURE Total_Salario_Gerente (OUT soma float(10,2)) -- Out é a saída
BEGIN

  DECLARE existe_mais_linhas INT DEFAULT 0;
  DECLARE Vl_salario FLOAT(10,2) DEFAULT 0;
  
  DECLARE Salario_Cursor CURSOR FOR 
  Select Sum(g.Vl_Salario)
  from loc_funcionario f 
  inner join loc_funcionario g on f.cd_gerente = g.cd_func
  group by g.Nm_Func;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET existe_mais_linhas=1;

  SET soma = 0;

  OPEN Salario_Cursor;


  SalarioLoop: LOOP
     FETCH Salario_Cursor INTO Vl_Salario;
     IF existe_mais_linhas = 1 THEN
        LEAVE SalarioLoop;
     END IF;

     SET soma = soma + Vl_Salario;

  END LOOP SalarioLoop;

  CLOSE Salario_Cursor;

  END //

  DELIMITER ;

  CALL Total_Salario_Gerente(@tempVl);
  select truncate(@tempVl, 2); -- deixando com 2 casas decimais
  
-- Obs: Está arredondando o valor (calculadora: 187.623,94 / Terminal: 187.624,01...)
