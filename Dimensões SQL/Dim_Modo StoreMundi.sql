USE storemundi; -- O nome do meu banco é storemundi, não apenas mundi

-- -----------------------------------------------------
-- Table `storemundi`.`Dim_Modo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storemundi`.`Dim_Modo` ;

CREATE TABLE IF NOT EXISTS `storemundi`.`Dim_Modo` (
  `Sk_Modo` INT NOT NULL AUTO_INCREMENT,
  `Md_envio` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Sk_Modo`))
ENGINE = InnoDB;

DROP PROCEDURE IF EXISTS Construir_Dim_Modo;

DELIMITER //
CREATE PROCEDURE Construir_Dim_Modo()
BEGIN 
    -- Declaração de variáveis
    DECLARE existe_mais_linhas INT DEFAULT 0;

    -- Variáveis para os cursores / Aqui deve ter a mesma quantidade que estiver nos campos originais também (VARCHAR de nome_produto deve ser 150)
    DECLARE vModo_Envio VARCHAR(45); -- Tudo q é variável colocamos um v antes (técnica) vNome_Produto (não necessário)

    -- Declaração do cursor para a tabela mundi_modo
    DECLARE ModoCursor CURSOR FOR
        SELECT ModoEnvio -- Temos que usar os nomes originários do modelo (O nome da tabela original), não precisa ter os mesmos maíusculos e minúsculos
        FROM modo m;

    -- Tratamento para quando não houver mais linhas nos cursores
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET existe_mais_linhas = 1;

    -- Abrir o cursor
    OPEN ModoCursor;

    -- Loop para percorrer os dados do cursor
    ModoLoop: LOOP
        -- Buscar valores do cursor
        FETCH ModoCursor INTO vModo_Envio; -- Não precisa estar na ordem necessariamente, mas é bom

        -- Encerrar o loop se não houver mais linhas
        IF existe_mais_linhas = 1 THEN 
            LEAVE ModoLoop;
        END IF;

        -- Inserir os dados na tabela Dim_Modo
        INSERT INTO Dim_Modo (
            Md_envio -- Nome dos campos do nosso criar dim_cliente
        )
        VALUES (
            vModo_Envio -- Nome das variáveis
        );
    END LOOP ModoLoop;

    -- Fechar o cursor
    CLOSE ModoCursor;

END //
DELIMITER ;

-- Chamar o procedimento
CALL Construir_Dim_Modo();

-- Consultar a tabela final
SELECT * FROM Dim_Modo;
