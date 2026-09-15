use carloca;

-- Questão 91

select Nr_Estrelas, Nm_Tp_Cliente, count(c.cd_cliente)
  from loc_cliente c
  inner join loc_tp_cliente t
    on c.Cd_Tp_Cliente = t.cd_Tp_Cliente
  group by nr_estrelas, Nm_Tp_Cliente;


-- Questão 95

select dt_locacao, count(nr_pedido)
  from loc_pedido_locacao
  group by dt_locacao
    having count(nr_pedido) > 3;

-- Questão 113

select nm_func, vl_salario
  from loc_funcionario
  where vl_salario > any (select avg(vl_salario)
							from loc_funcionario f
                            inner join loc_depto d
                              on d.cd_depto = f.cd_depto
                            group by nm_depto);


-- Questão 116

select *
  from loc_veiculo
  where vl_diaria > any (select avg(vl_diaria)
						   from loc_veiculo);
