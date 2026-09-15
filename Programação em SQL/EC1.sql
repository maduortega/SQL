use carloca;

-- Questão 1
-- Elabore usando while um programa que apresente os números impares entre dois números dados

DROP procedure IF EXISTS IMPAR;

DELIMITER //
CREATE PROCEDURE IMPAR(n INT, m int)

BEGIN
  DECLARE texto varchar(20) DEFAULT '';	

  IF mod(n, 2) = 0 THEN
	set n = n + 1;
  END IF;
  WHILE n <= m DO
	set texto = Concat(texto,'  ', n);
	set n = n + 2;
  END WHILE;

  select texto;
END//
DELIMITER ;

CALL IMPAR(1, 10);

-- Questão 2
--Elabore um programa que apresente a soma dos ímpares entre dois números dados

DROP procedure IF EXISTS IMPAR_SOMA;

DELIMITER //
CREATE PROCEDURE IMPAR_SOMA(n INT, m int)

BEGIN
  	
  DECLARE soma INT DEFAULT 0;
  IF mod(n, 2) = 0 THEN
	set n = n + 1;
  END IF;
  WHILE n <= m DO
    set soma = soma + n;
	set n = n + 2;
  END WHILE;

  select soma;
END//
DELIMITER ;

CALL IMPAR_SOMA(1, 10);

-- Questão 3
-- Elabore um programa que apresente os "n" primeiros termos de fibonacci (0 1 1 2 3 5 8 13 21 34...)

DROP procedure IF EXISTS F;

DELIMITER //
CREATE PROCEDURE F(x INT)

BEGIN
  	
  DECLARE a INT DEFAULT 1;
  DECLARE b INT DEFAULT 2;
  DECLARE cont INT DEFAULT 5;
  DECLARE texto varchar(200) DEFAULT '0  1  1  2';
  DECLARE aux INT DEFAULT x;
  
  WHILE cont <= aux DO
	set x = a + b;
    set texto = concat(texto, '  ', x);
    set a = b;
    set b = x;
    set cont = cont + 1;
  END WHILE;

  select texto;
END//
DELIMITER ;

CALL F(10);

-- Questão 4
-- Dados dois números indique seu Máximo Divisor Comum

DROP procedure IF EXISTS MDC;

DELIMITER //
CREATE PROCEDURE MDC(x INT, y INT)

BEGIN
  	
  DECLARE menor INT DEFAULT 0;
  DECLARE maior INT DEFAULT 0;
  DECLARE cont INT DEFAULT 1;
  DECLARE MDC INT;
  
  IF x < y THEN
	set menor = x;
  ELSE 
	set menor = y;
  END IF;

  WHILE cont <= menor DO
	IF mod(x, cont) = 0 and mod(y, cont) = 0 THEN
		set MDC = cont;
	END IF;
    set cont = cont + 1;
  END WHILE;

  select MDC;
END//
DELIMITER ;

CALL MDC(48, 18);

-- Questão 5
-- Elabore um programa que apresente números primos entre dois números dados

DROP procedure IF EXISTS primo;

DELIMITER //
CREATE PROCEDURE primo(x INT, y INT)

BEGIN
  	
  DECLARE D INT DEFAULT 0;
  DECLARE texto varchar(300) DEFAULT '';
  DECLARE i INT DEFAULT 1;
  
  IF x < y THEN
	IF mod(x, 2) = 0 THEN
		set x = x + 1;
	END IF;
    
    IF x <= 2 THEN
		set texto = concat(texto, ' ', 2);
	END IF;
    
    WHILE x <= y DO
		meu_loop: WHILE i <= sqrt(x) DO
			IF mod(x, i) = 0 THEN 
				set D = D + 1;
            END IF;
            
            IF D = 2 THEN
				LEAVE meu_loop;
            END IF;
            
            set i = i + 2;
            
        END WHILE;
        
        IF D = 1 and x <> 1 THEN
			set texto = concat(texto, ' ', x);
        END IF;
        
        set D = 0;
        set i = 1;
        set x = x + 2;
    END WHILE;

-- Y < X

  ELSE
	IF mod(y, 2) = 0 THEN
		set y = y + 1;
	END IF;
    
    IF y <= 2 THEN
		set texto = concat(texto, ' ', 2);
	END IF;
    
    WHILE y <= x DO
		meu_loop: WHILE i <= sqrt(y) DO
			IF mod(y, i) = 0 THEN 
				set D = D + 1;
            END IF;
            
            IF D = 2 THEN
				LEAVE meu_loop;
            END IF;
            
            set i = i + 2;
            
        END WHILE;
        
        IF D = 1 and y <> 1 THEN
			set texto = concat(texto, ' ', y);
        END IF;
        
        set D = 0;
        set i = 1;
        set y = y + 2;
    END WHILE;
  END IF;
  
  Select texto;
  
END//
DELIMITER ;

CALL primo(1, 10);
