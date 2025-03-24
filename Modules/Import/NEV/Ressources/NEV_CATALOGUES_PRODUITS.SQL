select 
ctanolabo,
ctanogamme,
ctanocip,
1,--type correspond au fichier dans lequel on prend les donnees 1LP ou 2PS
cta_lp_pxachat,
0,
0,
null
from aff81lp
where ctanogamme<>0 

union 

select 
ctanolabo,
ctanogamme,
ctanocip,
2,
0,
cta_ps_pxremise,
cta_ps_derqte,
updated_at
from aff82ps
where ctanogamme<>0 
