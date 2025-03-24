select
vte.ar_cip,
vte.ve_mois,
vte.ve_annee,
decode(prd.ta_code, 'B',  round(vte.ve_qte/ prd.AR_QTCMP ), vte.ve_qte )
from vente  vte
left join article prd on prd.ar_cip = vte.ar_cip
where ve_anmojo >= add_months(sysdate,-24)