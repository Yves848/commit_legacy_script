select t_aad_debiteur_id, max(dateecriture), sum(aencaisser) + sum(deja_percu)
from
  (select
    e.t_aad_debiteur_id,
    ass.nom || ' ' || ass.prenom nom,
    ass.numeroinsee,
    sum(decode(e.type_ecriture, 'D', e.montant,0)) aencaisser,
    sum(decode(e.type_ecriture, 'C', e.montant,0)) deja_percu,
    decode(e.valide_releve, 1, e.date_releve, e.dateecriture) dateecriture,
    e.nb_relance as nbrelance
   from 
    erp.t_encaissement e
    inner join erp.t_modereglement mr on mr.t_modereglement_id = e.t_modereglement_id
    inner join erp.t_acte a on a.t_acte_id = e.t_acte_id
    inner join erp.t_assureayantdroit ass on ass.t_aad_id = e.t_aad_debiteur_id
    inner join erp.t_qualite q on q.t_qualite_id = ass.t_qualite_id  
   where 
    a.termine = '1' and 
    e.lettre = '0' and 
    mr.type = 5 and 
    (e.soumisareleve = '0' or (e.soumisareleve = '1' and e.num_releve > 0))
   group by 
    a.typeacte,
    e.t_aad_debiteur_id,
    ass.nom,
    ass.prenom,
    ass.numeroinsee,
    decode(e.valide_releve, 1, e.date_releve, e.dateecriture),
    e.nb_relance)
group by
  t_aad_debiteur_id
having sum(aencaisser) + sum(deja_percu) <> 0