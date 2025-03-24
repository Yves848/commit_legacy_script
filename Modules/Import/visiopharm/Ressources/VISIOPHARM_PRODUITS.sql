select
prd.codeuv,
prd.codeproduit,
prd.cip,
prd.ean_13, 
prd.gtin,
prd.intitulecompletuv,
prd.prixachatofficine,
prd.remise,
prd.prixpublic,
tva.tva,
prd.baseremboursement ,
prd.coderegimess,
case
when ((prd.liste is null) or (prd.liste = ''))  then '0'
when (prd.liste= 'S')  then '3'
else prd.liste end,
prd.stock_maxi,
prd.stock_mini,
prd.qte_stock,
prd.qte_reserve ,
prd.peremption,
prd.code_casier,
prd.blocage,
prd.derniere_vente,
prd.code_labo, 
coalesce(prd.codeacteb2,'PHN'),
prd.codeinventorex,
prd.notes,
prd.blocmin,
prd.prixachatcat,
prd.mini_rayon,
prd.maxi_rayon,
prd.blocmax  ,
prd.code_fournisseur,
prd.fabricant 

from prodeco prd
left join taux tva on tva.code = prd.codetva
where prd.derniere_vente is not null or qte_stock<>0 or codeuv in (select codeuv from factlign 
group by codeuv)