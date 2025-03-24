select 
'FOU_'+la_code,
trim(la_nom),
trim(la_rue),
trim(la_cpor),
trim(la_ville),
trim(la_tel),
trim(la_fax),
trim(la_rnom),
trim(la_obs),
trim(la_mail),
trim(la_tport),
trim(la_trepo)

from LAB
union
select 
'GRP_'+gr_code,
trim(gr_nom),
trim(gr_rue),
trim(gr_cpor),
trim(gr_ville),
trim(gr_tel),
trim(gr_fax),
trim(gr_rnom),
trim(gr_obs),
trim(gr_mail),
trim(gr_tport),
trim(gr_trepo)

from groupe