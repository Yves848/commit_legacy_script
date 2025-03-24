select t.t_crist_transaction_id,
       t.t_crist_compte_id,
       t.num_carte,
       sum(t.montant_ristourne),
       t.type_transaction,
       tv.tauxtva,
       sum(t.total_ticket),
       max(t.date_ticket)
from bel.t_crist_transaction t
inner join bel.t_tva tv on t.t_tva_id=tv.t_tva_id
where t.t_crist_compte_id is not null
group by t.t_crist_transaction_id, 
         t.t_crist_compte_id,
         t.num_carte,
         t.type_transaction,
         tv.tauxtva 