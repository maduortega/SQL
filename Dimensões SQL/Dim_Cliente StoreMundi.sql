USE storemundi; -- O nome do meu banco é storemundi, não apenas mundi

-- -----------------------------------------------------
-- Table `storemundi`.`Dim_Cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storemundi`.`Dim_Cliente` ;

CREATE TABLE IF NOT EXISTS `storemundi`.`Dim_Cliente` (
  `Sk_Cliente` INT NOT NULL AUTO_INCREMENT,
  `Nm_cli` VARCHAR(45) NOT NULL, -- Se der erro de "Tamanho pequeno" aumentamos o tamanho do VARCHAR
  `Nm_seg` VARCHAR(45) NOT NULL, -- Recomendável colocar os VARCHAR e campos no mesmo valor da tabela original
  PRIMARY KEY (`Sk_Cliente`))
ENGINE = InnoDB;

DROP PROCEDURE IF EXISTS Construir_Dim_Cliente;

DELIMITER //
CREATE PROCEDURE Construir_Dim_Cliente()
BEGIN 
    -- Declaração de variáveis
    DECLARE existe_mais_linhas INT DEFAULT 0;

    -- Variáveis para os cursores / Aqui deve ter a mesma quantidade que estiver nos campos originais também (VARCHAR de nome_produto deve ser 150)
    DECLARE vNome_Cliente VARCHAR(45); -- Tudo q é variável colocamos um v antes (técnica) vNome_Produto (não necessário)
    DECLARE vNome_Segmento VARCHAR(45);

    -- Declaração do cursor para a tabela mundi_cliente
    DECLARE ClienteCursor CURSOR FOR
        SELECT c.NomeCliente, s.NomeSegmento -- Temos que usar os nomes originários do modelo (O nome da tabela original), não precisa ter os mesmos maíusculos e minúsculos
        FROM cliente c  
        INNER JOIN segmento s ON c.codSegmento = s.codSegmento;

    -- Tratamento para quando não houver mais linhas nos cursores
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET existe_mais_linhas = 1;

    -- Abrir o cursor
    OPEN ClienteCursor;

    -- Loop para percorrer os dados do cursor
    ClienteLoop: LOOP
        -- Buscar valores do cursor
        FETCH ClienteCursor INTO vNome_Cliente, vNome_Segmento; -- Não precisa estar na ordem necessariamente, mas é bom

        -- Encerrar o loop se não houver mais linhas
        IF existe_mais_linhas = 1 THEN 
            LEAVE ClienteLoop;
        END IF;

        -- Inserir os dados na tabela Dim_Produto
        INSERT INTO Dim_Cliente (
            Nm_cli, Nm_seg -- Nome dos campos do nosso criar dim_cliente
        )
        VALUES (
            vNome_Cliente, vNome_Segmento -- Nome das variáveis
        );
    END LOOP ClienteLoop;

    -- Fechar o cursor
    CLOSE ClienteCursor;

END //
DELIMITER ;

-- Chamar o procedimento
CALL Construir_Dim_Cliente();

-- Consultar a tabela final
SELECT * FROM Dim_Cliente;
