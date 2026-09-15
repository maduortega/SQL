-- Loop Acumular "n" números
DELIMITER //
CREATE PROCEDURE acumula (limite INT)
BEGIN
DECLARE contador INT DEFAULT 0;
DECLARE soma INT DEFAULT 0;
loop_teste: LOOP
    SET contador = contador + 1;
    SET soma = soma + contador;
    IF contador >= limite THEN
        LEAVE loop_teste;
    END IF;
END LOOP loop_teste;
SELECT soma;
END//
DELIMITER ;

-- Testando
CALL acumula(5);


DROP procedure IF EXISTS DOWHILE;

DELIMITER //
CREATE PROCEDURE dowhile(limite int)
BEGIN
  DECLARE v1 INT DEFAULT 0;
  DECLARE soma INT DEFAULT 0;
  WHILE v1 <= limite DO
    SET soma = soma + v1;
    SET v1 = v1 + 1;
  END WHILE;
Select Soma;  
END//
DELIMITER ;


CALL dowhile(5);


DROP procedure IF EXISTS Proc_Impares;

-- Ímpares entre 2 números
DELIMITER //
CREATE PROCEDURE Proc_impares (a INT, b INT)
BEGIN
DECLARE i INT DEFAULT a;
DECLARE Texto VARCHAR(80);
SET Texto = 'Ímpares ';
set i = a;
loop_impar: LOOP
	if mod(i,2) != 0 then
       set texto = Concat(texto,' - ',convert(i,char));
    end if;  
    set i = i + 1;
    if i > b then
       leave loop_impar;
    end if;   
END LOOP loop_impar;
SELECT texto;
END//
DELIMITER ;

Call Proc_Impares(10,20);


DROP function IF EXISTS Func_Impares;

-- Ímpares entre 2 números
DELIMITER //
CREATE Function Func_impares (a INT, b INT)
  RETURNS Varchar(80)
DETERMINISTIC  
BEGIN
DECLARE i INT DEFAULT a;
DECLARE Texto VARCHAR(80);
SET Texto = 'Ímpares ';
set i = a;
loop_impar: LOOP
	if mod(i,2) != 0 then
       set texto = Concat(texto,' - ',convert(i,char));
    end if;  
    set i = i + 1;
    if i > b then
       leave loop_impar;
    end if;   
END LOOP loop_impar;
RETURN texto;
END//
DELIMITER ;

Select Func_Impares(10,20);
