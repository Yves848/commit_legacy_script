select 
fal.attpro_num_attente_pk,
fal.attpro_num_ordreproduit_pk,
fal.attpro_num_produit_fk,
fal.attpro_num_quantite,
fal.attpro_num_prixunitremise,
p.pro_mnt_prixcatalogueht,
a.act_cde_code
from tbl_attente_detail_produit fal
left join tbl_produit p on p.pro_num_id = fal.attpro_num_produit_fk
left join tbl_acte a on a.act_num_id = p.pro_num_acte_fk