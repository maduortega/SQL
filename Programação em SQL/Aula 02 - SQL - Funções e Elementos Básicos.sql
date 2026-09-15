-- Interagindo com o MySQL através de um comando
Select 3 * 9;

Select 'Alô Mundo!!';

-- Interagindo com o MySQL através de uma função
DELIMITER //
CREATE FUNCTION Alo_Mundo(frase varchar(70))
RETURNS varchar(70) 
DETERMINISTIC 
BEGIN
   RETURN frase; 
END //
DELIMITER ;

Select Alo_Mundo('Alô Mundo!');

-- Interagindo com uma Função que insere "Olá <frase>!"
DELIMITER //
CREATE FUNCTION ola (frase_entrada CHAR(70)) 
RETURNS CHAR(70) 
DETERMINISTIC 
BEGIN
   RETURN CONCAT('Olá, ',frase_entrada,'!');  
END //
DELIMITER ;

SELECT ola('ESPM');

Select Nm_Func, Vl_Salario, 
       if(Vl_Salario<3000,'baixo',if(Vl_Salario< 8000,'médio','alto'))
  from loc_funcionario
  order by Vl_Salario;

-- Exiba o maior entre dois números distintos entre si
DROP FUNCTION IF EXISTS Maior;

DELIMITER //
CREATE FUNCTION Maior(n INT, m INT)
  RETURNS VARCHAR(20)
  
  DETERMINISTIC 
  BEGIN
    DECLARE maior int;
    DECLARE s varchar(20);

    IF n > m THEN SET maior = n;
    ELSE SET maior = m;
    END IF;
    
    set s = concat(maior,' é o maior!');
    
    RETURN s;
END //

DELIMITER ;

Select Maior(2,2);
Select Maior(4,7);
Select Maior(3,2);

-- Dado um Número, imprima o maior
DELIMITER //

-- Comparando dois números
CREATE FUNCTION Comparar(n INT, m INT)
  RETURNS VARCHAR(20)
  
  DETERMINISTIC 
  BEGIN
    DECLARE s VARCHAR(20);

    IF n > m THEN SET s = '>';
    ELSEIF n = m THEN SET s = '=';
    ELSE SET s = '<';
    END IF;

    SET s = CONCAT(n, ' ', s, ' ', m);

    RETURN s;
  END //

DELIMITER ;

Select Comparar(12,11);
Select Comparar(11,11);
Select Comparar(11,12);

-- Dados 3 números inteiros e distintos entre si, imprima o maior deles

DROP FUNCTION IF EXISTS Maior_de_3_Var_Aux;
-- Estratégia da Variável Auxiliar
DELIMITER //
CREATE FUNCTION Maior_de_3_Var_Aux(a INT, b INT, c INT)
  RETURNS VARCHAR(20)
  
  DETERMINISTIC 
  BEGIN
    DECLARE maior int;
    DECLARE s varchar(20);

    IF a > b THEN SET maior = a;
    ELSE SET maior = b;
    END IF;
    
    if c > maior then SET maior = c;
    END IF;
    
    set s = concat(maior,' é o maior!');
    
    RETURN s;
END //

DELIMITER ;

Select Maior_de_3_Var_Aux(1,2,3);
Select Maior_de_3_Var_Aux(3,2,1);
Select Maior_de_3_Var_Aux(1,3,2);


DROP FUNCTION IF EXISTS Maior_de_3_Ordenado;
-- Estratégia da Ordenação
DELIMITER //
CREATE FUNCTION Maior_de_3_Ordenado(a INT, b INT, c INT)
  RETURNS VARCHAR(20)
  
  DETERMINISTIC 
  BEGIN
    DECLARE d int;
    DECLARE s varchar(20);

    IF a > b THEN
       BEGIN 
          SET d = a;
          SET a = b;
          SET b = d;
       END;   
    END IF; 
	IF b > c THEN 
       BEGIN
         SET d = b;
         SET b = c;
         SET c = d;
       END;  
    END IF;   
              
    set s = concat(c,' é o maior!');
    
    RETURN s;
END //

DELIMITER ;

Select Maior_de_3_Ordenado(1,2,3);
Select Maior_de_3_Ordenado(3,2,1);
Select Maior_de_3_Ordenado(1,3,2);

DROP FUNCTION IF EXISTS Maior_de_3_Encadeado;
-- Estratégia de Encadeamento
DELIMITER //
CREATE FUNCTION Maior_de_3_Encadeado(a INT, b INT, c INT)
  RETURNS VARCHAR(20)
  
  DETERMINISTIC 
  BEGIN
    DECLARE s varchar(20);

    IF a > b THEN
       BEGIN 
       IF a > c THEN
          set s = concat(a,' é o maior!');
       ELSE   
          set s = concat(c,' é o maior!');
       END IF;   
       END;
    ELSE      
       BEGIN 
       IF b > c THEN
          set s = concat(b,' é o maior!');
       ELSE   
          set s = concat(c,' é o maior!');
       END IF;   
       END;       
    END IF;
    RETURN s;
END //

DELIMITER ;

Select Maior_de_3_Encadeado(1,2,3);
Select Maior_de_3_Encadeado(3,2,1);
Select Maior_de_3_Encadeado(1,3,2);



DROP FUNCTION IF EXISTS Maior_de_3_And;
-- Estratégia de Encadeamento
DELIMITER //
CREATE FUNCTION Maior_de_3_And(a INT, b INT, c INT)
  RETURNS VARCHAR(20)
  
  DETERMINISTIC 
  BEGIN
    DECLARE s varchar(20);

    IF a > b AND a > c THEN
       set s = concat(a,' é o maior!');
	ELSE   
       IF b > c THEN
          set s = concat(b,' é o maior!');
       ELSE
          set s = concat(c,' é o maior!');
       END IF;   
	END IF;
    RETURN s;
END //

DELIMITER ;

Select Maior_de_3_And(1,2,3);
Select Maior_de_3_And(3,2,1);
Select Maior_de_3_And(1,3,2);

DROP procedure IF EXISTS Selos;

DELIMITER //
CREATE PROCEDURE Selos(peso int)
BEGIN
  DECLARE v1 INT;
  DECLARE soma INT;
  DECLARE Tres INT;
  DECLARE Cinco INT;
  DECLARE QuocienteR FLOAT;
  DECLARE Quociente INT;
  DECLARE Resto INT;
  DECLARE Texto VARCHAR(80);
  if Peso < 8 then
     set Peso = 8;
  end if;
  
  SET QuocienteR = Peso / 5;
  SET Quociente = Truncate(quocienteR,0);
  -- Necessário converter para Inteiro, pois não há "meio" selo...
  set Resto = Mod(Peso,5);
  
  -- Para ver resultados intermediários tire esse comentário e comente a saída final 
  -- Select Concat('Peso ',convert(peso,char),'  QuocienteR ',convert(quocienter,char),'  Quociente: ',convert(Quociente,char),'  e Resto: ',convert(Resto,char));
  
  if Resto = 0 then
     SET Cinco = Quociente;
     SET Tres  = 0;
  else
     if Resto = 1 then
        SET Cinco = Quociente - 1;
        SET Tres  = 2;
     else   
        if Resto = 2 then
           SET Cinco = Quociente - 2;
           SET Tres  = 4;
        else   
           if Resto = 3 then
              SET Cinco = Quociente;
              SET Tres  = 1;
           else
              if Resto = 4 then
                 SET Cinco = Quociente - 1;
                 SET Tres  = 3;   
              end if;   
           end if;   
        end if;   
     end if;   
  end if;  
  
 Set Texto = Concat('Total de Selos de Cinco é ',convert(Cinco,char),' e o total de seles de Três é ',convert(Tres,char));
 Select Texto;    

END//
DELIMITER ;

Call Selos(13);  
