select e.t_aad_id, 
       max(a.dateacte),
       sum(decode(e.soumisareleve, '0', e.montant, 0))  
from bel.t_encaissement e
inner join bel.t_modereglement mr on mr.t_modereglement_id = e.t_modereglement_id 
inner join bel.t_acte a on a.t_acte_id = e.t_acte_id 
left join bel.t_facture f on f.t_facture_id = e.t_facture_id 
where a.termine = '1'  
      and e.lettre = '0'
      and mr.type = 5
      and t_aad_id is not null
group by e.t_aad_id  

