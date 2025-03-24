select t_codif1_id,
       libelle,
       '1',
       null
from erp.t_codif1
union
select t_codif2_id,
       libelle,
       '2',
       null
from erp.t_codif2
union
select t_codif3_id,
       libelle,
       '3',
       null
from erp.t_codif3
union
select t_codif4_id,
       libelle,
       '4',
       null
from erp.t_codif4
union
select t_codif5_id,
       libelle,
       '5',
       null
from erp.t_codif5
union
select t_codif6_id,
       libelle,
       '6',
       null
from erp.t_codif6