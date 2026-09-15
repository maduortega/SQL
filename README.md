# SQL

Este repositório reúne exercícios, práticas e materiais de estudo em **SQL**, com foco em consultas, modelagem de dados, programação em banco de dados e construção de dimensões para análise.

Os arquivos foram desenvolvidos principalmente para uso com **MySQL** e **MySQL Workbench**, abordando desde comandos básicos até procedures, funções, cursores, agrupamentos e subqueries.

As práticas utilizam principalmente os bancos de dados **Carloca** e **StoreMundi**.

## Conteúdos Abordados

- Consultas SQL
- Modelagem de banco de dados
- Normalização
- Funções em SQL
- Procedures
- Cursores
- Loops e estruturas condicionais
- Subqueries
- Agrupamento com `GROUP BY`
- Filtros com `HAVING`
- Joins
- Criação de tabelas dimensionais
- Introdução a processos de ETL em SQL

## Estrutura do Repositório

```text
.
├── Base Carloca/
├── Base StoreMundi/
├── Dimensões SQL/
├── Exercícios de Classe/
└── Programação em SQL/
```

## Descrição das Pastas

### Base Carloca

Contém os arquivos de criação, carga e modelagem do banco de dados **Carloca**.

Arquivos principais:

- `Cria_Carloca.txt`
- `Carrega_Carloca.txt`
- `Carloca_MySQL.mwb`
- `carloca.png`

Principais temas:

- Criação da estrutura do banco
- Carga de dados
- Modelo físico no MySQL Workbench
- Base utilizada em exercícios de consultas, agrupamentos, subqueries, funções, procedures e cursores

### Base StoreMundi

Contém os arquivos de criação/modelagem da base **StoreMundi**, utilizada principalmente nos scripts de construção de dimensões.

Arquivos principais:

- `Mundi.sql`
- `StoreMundi.mwb`

Principais temas:

- Script SQL da base StoreMundi
- Modelo do banco no MySQL Workbench
- Base de origem para tabelas dimensionais

### Dimensões SQL

Contém scripts voltados à criação de tabelas dimensionais para o banco **StoreMundi**.

Os scripts utilizam procedures e cursores para construir dimensões a partir de tabelas de origem.

Arquivos principais:

- `Dim_Cliente StoreMundi.sql`
- `Dim_Modo StoreMundi.sql`
- `Dim_Produto StoreMundi.sql`

Principais temas:

- Criação de tabelas dimensionais
- Chaves substitutas com `AUTO_INCREMENT`
- Procedures de carga
- Cursores
- Inserção de dados tratados
- Consulta de dimensões finais

### Exercícios de Classe

Reúne atividades práticas de banco de dados desenvolvidas em aula.

A pasta contém scripts SQL, arquivos de modelagem do MySQL Workbench e material de normalização.

Arquivos incluídos:

- `EC1 - Banco_de_dados_barbearia.mwb`
- `EC2.mwb`
- `EC3.sql`
- `EC4 - Exercicio SQL 14_05.sql`
- `EC5 - NORMALIZAÇÃO.docx`
- `EC6 - Subquery e agrupamento SQL.sql`

Principais temas:

- Modelagem de banco de dados
- Exercícios com consultas SQL
- Normalização
- Subqueries
- Agrupamentos
- Uso de `COUNT`, `AVG` e filtros com `HAVING`
- Joins entre tabelas

### Programação em SQL

Contém scripts e materiais voltados à programação dentro do banco de dados.

Arquivos principais:

- `Aula 02 - SQL - Funções e Elementos Básicos.sql`
- `Aula 03 - SQL - Loops Básicos.sql`
- `Aula 05 - SQL - Cursores Básicos.sql`
- `EC1.sql`
- `P1 - Tipo 1.sql`
- `P1 - Tipo 3.sql`
- `Manual SQL (baseado em Py).txt`
- `Procedures e Cursores SQL.docx`

Principais temas:

- Criação de funções
- Uso de `DELIMITER`
- Estruturas condicionais com `IF`
- Laços com `LOOP` e `WHILE`
- Procedures com parâmetros de saída
- Cursores para percorrer registros
- Comparação entre conceitos de Python e SQL

## Tecnologias Utilizadas

- **SQL**
- **MySQL**
- **MySQL Workbench**
- **Procedures**
- **Functions**
- **Cursors**
- **Modelagem de Dados**

## Como Utilizar os Arquivos

Para executar os scripts:

1. Abra o **MySQL Workbench**.
2. Conecte-se ao banco de dados desejado.
3. Abra o arquivo `.sql`.
4. Verifique se o comando `USE nome_do_banco;` está apontando para o banco correto.
5. Execute o script por partes ou por completo, conforme a necessidade.

Arquivos `.mwb` devem ser abertos diretamente no MySQL Workbench, pois representam modelos de banco de dados.

Arquivos `.docx` e `.txt` são materiais de apoio e documentação das aulas.

## Observação

Alguns scripts dependem de bancos de dados específicos, como `storemundi` ou `carloca`. Antes de executar, confirme se as tabelas de origem existem no ambiente local.

Para este repositório, os bancos utilizados são:

- `carloca`
- `storemundi`

## Objetivo do Repositório

Este repositório tem como objetivo organizar estudos e práticas de SQL, registrando a evolução em consultas, modelagem, normalização e programação em banco de dados com MySQL.

## Autoria

Desenvolvido como parte dos estudos de Banco de Dados e Programação em SQL.
