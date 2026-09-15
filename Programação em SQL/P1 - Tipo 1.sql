use carloca;

-- Função que apresenta todos os divisores de um número

DROP PROCEDURE IF EXISTS divisores;

DELIMITER //
CREATE PROCEDURE divisores (limite INT)

BEGIN
    DECLARE i INT DEFAULT 1;
	DECLARE texto VARCHAR(999) DEFAULT ' ';
    
    WHILE i <= limite DO
		IF limite != 0 THEN
		IF limite % i = 0 THEN
        
			SET texto = concat(texto, ' ', i); -- Ou (i, ' ')
		
		END IF;
        END IF;
        
	SET i = i + 1;
	END WHILE;
    
select texto;

END //
DELIMITER ;

CALL divisores(12);




-- Função para apresentar a soma dos salários de todos os departamentos

	Select sum(Vl_Salario)
	from loc_funcionario f
	inner join loc_depto d on f.cd_depto = d.cd_depto
	group by Nm_Depto;

select *
from loc_depto;

-- Cursor para Totalizar Salario dos departamentos
DROP PROCEDURE IF EXISTS Total_Salario_Depto;

DELIMITER //
CREATE PROCEDURE Total_Salario_Depto (OUT soma float(10,2)) -- Out é a saída
BEGIN

  DECLARE existe_mais_linhas INT DEFAULT 0;
  DECLARE Vl_Salario_Total FLOAT(10,2) DEFAULT 0; -- Essa variável que será acessada não pode ter nome de campo
  
  DECLARE Salario_Cursor CURSOR FOR 
  Select sum(Vl_Salario)
	from loc_funcionario f
	inner join loc_depto d on f.cd_depto = d.cd_depto
	group by Nm_Depto;


  DECLARE CONTINUE HANDLER FOR NOT FOUND SET existe_mais_linhas=1;

  SET soma = 0;

  OPEN Salario_Cursor;


  SalarioLoop: LOOP
     FETCH Salario_Cursor INTO Vl_Salario_Total; -- A variável não pode ter o nome do campo (Vl_Salario)
     IF existe_mais_linhas = 1 THEN
        LEAVE SalarioLoop;
     END IF;

     SET soma = soma + Vl_Salario_Total; -- Agora o resultado não ficará zerado!

  END LOOP SalarioLoop;

  CLOSE Salario_Cursor;

  END //

  DELIMITER ;

  CALL Total_Salario_Depto(@tempVl);
  select truncate(@tempVl, 2); -- deixando com 2 casas decimais
