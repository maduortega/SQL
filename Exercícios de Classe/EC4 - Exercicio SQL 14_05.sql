use carloca;

-- Exercicio 1)

Select Cd_func, Nm_func, vl_salario
  from loc_funcionario;
  
-- Exercício 11)

Select *
  from loc_cidade c
  where nm_cidade like '% %'
  order by c.cd_estado;
  
-- Exercício 31)

Select upper(nm_func), lower(nm_func), substr(nm_func, 3, 6) 
  from loc_funcionario;
  
-- Exercício 41)

Select nr_placa, nr_chassis, km_atual, desc_cor
  from loc_veiculo lv
  inner join loc_cor lc
    on lv.cd_cor = lc.cd_Cor
  where desc_cor like '%l%';
  
-- Exercício 51)

Select nr_placa, nm_modelo, nm_fabricante
  from loc_veiculo lv
  inner join loc_modelo lm
    on lv.cd_modelo = lm.cd_modelo
  inner join loc_fabricante lf
    on lm.cd_fabricante = lf.cd_Fabricante;

-- Exercício 71)

Select nm_depto, max(vl_salario)
  from loc_funcionario f
  inner join loc_depto d
    on d.cd_depto = f.cd_depto
  group by d.cd_depto;
  
-- Exercício 81)

Select max(vl_diaria), min(vl_diaria)
  from loc_item_locacao;
