USE storemundi;

-- -----------------------------------------------------
-- Table `storemundi`.`Dim_Produto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storemundi`.`Dim_Produto` ; -- Arquivo exportado (1° Opção), marcamos os primeiros 2 quadrados, copiamos e colamos essa parte de criação apenas

CREATE TABLE IF NOT EXISTS `storemundi`.`Dim_Produto` (
  `Sk_Produto` INT NOT NULL AUTO_INCREMENT,
  `Nm_prod` VARCHAR(150) NOT NULL, -- Se der erro de "Tamanho pequeno" aumentamos o tamanho do VARCHAR
  `prod_categoria` VARCHAR(45) NOT NULL, -- Recomendável colocar os VARCHAR e campos no mesmo valor da tabela original
  `prod_subcategoria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Sk_Produto`))
ENGINE = InnoDB;

DROP PROCEDURE IF EXISTS Construir_Dim_Produto;

DELIMITER //
CREATE PROCEDURE Construir_Dim_Produto()
BEGIN 
    -- Declaração de variáveis
    DECLARE existe_mais_linhas INT DEFAULT 0;

    -- Variáveis para os cursores / Aqui deve ter a mesma quantidade que estiver nos campos originais também (VARCHAR de nome_produto deve ser 150)
    DECLARE vNome_Produto VARCHAR(150); -- Tudo q é variável colocamos um v antes (técnica) vNome_Produto (não necessário)
    DECLARE vNome_Categoria VARCHAR(45);
    DECLARE vNome_SubCategoria VARCHAR(45);

    -- Declaração do cursor para a tabela mundi_produto
    DECLARE ProdutoCursor CURSOR FOR
        SELECT P.NomeProduto, NomeCategoria, NomeSubCategoria -- Temos que usar os nomes originários do modelo (O nome da tabela original), não precisa ter os mesmos maíusculos e minúsculos
        FROM produto p  
        INNER JOIN SubCategoria s ON p.codSubCat = s.codSubCat
        INNER JOIN Categoria c ON s.IdCategoria = c.IdCategoria;

    -- Tratamento para quando não houver mais linhas nos cursores
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET existe_mais_linhas = 1;

    -- Abrir o cursor
    OPEN ProdutoCursor;

    -- Loop para percorrer os dados do cursor
    ProdutoLoop: LOOP
        -- Buscar valores do cursor
        FETCH ProdutoCursor INTO vNome_Produto, vNome_Categoria, vNome_SubCategoria; -- Não precisa estar na ordem necessariamente, mas é bom

        -- Encerrar o loop se não houver mais linhas
        IF existe_mais_linhas = 1 THEN 
            LEAVE ProdutoLoop;
        END IF;

        -- Inserir os dados na tabela Dim_Produto
        INSERT INTO Dim_Produto (
            Nm_prod, prod_categoria, prod_subcategoria -- Nome dos campos do nosso criar dim_produto
        )
        VALUES (
            vNome_Produto, vNome_Categoria, vNome_SubCategoria -- Nome das variáveis
        );
    END LOOP ProdutoLoop;

    -- Fechar o cursor
    CLOSE ProdutoCursor;

END //
DELIMITER ;

-- Chamar o procedimento
CALL Construir_Dim_Produto();

-- Consultar a tabela final
SELECT * FROM Dim_Produto;
