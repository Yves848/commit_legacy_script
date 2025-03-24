select cp.cip, c_n.ti,
  if (c_n.parent_ti <> -1, c_n.libelle, '') libelle_n,
  if (c_n1.parent_ti <> -1, c_n1.libelle, '') libelle_n1, 
  if (c_n2.parent_ti <> -1, c_n2.libelle, '') libelle_n2, 
  if (c_n3.parent_ti <> -1, c_n3.libelle, '') libelle_n3, 
  if (c_n4.parent_ti <> -1, c_n4.libelle, '') libelle_n4
from catprod cp
inner join categor c_n on (c_n.ti = cp.ti)
left join categor c_n1 on (c_n1.ti = c_n.parent_ti)
left join categor c_n2 on (c_n2.ti = c_n1.parent_ti)
left join categor c_n3 on (c_n3.ti = c_n2.parent_ti)
left join categor c_n4 on (c_n4.ti = c_n3.parent_ti)
where c_n.parent_ti in (select ti from categor)