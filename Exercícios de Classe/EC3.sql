-- Questão 1: Desenvolva uma instrução SQL que exiba os seguintes dados dos
funcionários: código, nome e salário. (Não utilize a cláusula *) na
instrução SELECT.

use carloca;

Select Cd_Func, Nm_Func, Vl_Salario
  from loc_funcionario;

-- Questão 2: Crie uma instrução SQL que exiba todos os dados da tabela de
Proprietários. Exiba essa consulta em ordem de nome de proprietário.

use carloca;

select * 
  from loc_proprietario
  order by Nm_Proprietario;

-- Questão 3: Crie uma instrução SQL que exiba todos os dados da tabela de Bancos.
Exiba essa consulta em ordem de nome de banco.

use carloca;

select *
  from loc_banco
  order by Nm_Banco;

-- Questão 6: Crie uma instrução SQL que exiba todos os dados da tabela de Clientes.
Exiba essa consulta em ordem de código de cliente.

use carloca;

select *
  from loc_cliente
  order by Cd_cliente;

-- Questão 7: Crie uma instrução SQL que exiba todos os dados da tabela de Clientes.
Exiba essa consulta em ordem de número de estrelas do cliente.

use carloca; 

select *
  from loc_cliente
  order by Nr_Estrelas;

