select 
    com.id_commentaire,
    ass.id_entite,
    com.contenu,
    com.is_bloquant,
    com.is_global
from erp.t_commentaire com 
left join t_commentaire_association ass on ass.id_commentaire = com.id_commentaire
where type_entite = 0