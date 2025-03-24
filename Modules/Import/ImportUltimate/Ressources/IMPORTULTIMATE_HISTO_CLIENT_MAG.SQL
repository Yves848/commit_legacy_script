--NEW magistrale classiques
select
  'FACT_' || l.t_lignevente_id,
  'FACT_' || f.t_facture_id,
  l.designation_fr,
  l.qtefacturee,
  mag.detail
from
  bel.t_lignevente l
  inner join bel.t_facture f on f.t_facture_id = l.t_facture_id
  inner join bel.t_acte ac on ac.t_acte_id = f.id_acte
  inner join bel.t_assureayantdroit a on a.t_aad_id = f.t_client_id
  inner join bel.t_magi_magistrale m on m.t_magi_magistrale_id = l.t_magi_magistrale_id 
  
  left join (select lm.t_magi_magistrale_id, 
                    LISTAGG(ch.cnk||' '||cd.denomination||' '||TRIM(TRAILING '.' FROM TRIM(TRAILING '0' FROM TO_CHAR(lm.quantiteprescrite, 'FM9999999990.00')))||' '||"F_decode_uniteQte"(lm.unitequantite), '<BR> ') WITHIN GROUP (ORDER BY lm.t_chim_denomination_id) detail
             from t_magi_ligne_magistrale lm
             left join t_chim_produit ch on lm.t_chim_produit_id = ch.t_chim_produit_id
             left join t_chim_denomination cd on cd.t_chim_denomination_id = lm.t_chim_denomination_id 
             group by lm.t_magi_magistrale_id ) MAG on MAG.t_magi_magistrale_id = l.t_magi_magistrale_id 

where
  f.t_client_id is not null 
  and l.t_magi_magistrale_id is not null
  and l.qtefacturee > 0 
  and (a.id_del is null or a.d_del is null) 
  and a.collectivite = '0' 
  and ac.termine = '1'  

UNION

--magistrale incorporee
select
  'FACT_' || l.t_lignevente_id,
  'FACT_' || f.t_facture_id, 
  l.designation_fr,
  l.qtefacturee,
  inc.detail
from
  bel.t_lignevente l
  inner join bel.t_facture f on f.t_facture_id = l.t_facture_id
  inner join bel.t_acte ac on ac.t_acte_id = f.id_acte
  inner join bel.t_assureayantdroit a on a.t_aad_id = f.t_client_id
  left join bel.t_magi_magistrale m on m.t_magi_magistrale_id = l.t_magi_magistrale_id 
  left join bel.t_magi_ligne_magistrale mlm on mlm.t_magi_magistrale_id = m.t_magi_magistrale_id
  inner join (-- MAGISTRALE INCORPOREE
            select 
             mli.t_magi_incorporee_id,
             LISTAGG(cp.cnk||' '||cd.denomination||' / '||TRIM(TRAILING '.' FROM TRIM(TRAILING '0' FROM TO_CHAR(mli.quantiteprescrite, 'FM9999999990.00')))||' '||"F_decode_uniteQte"(mli.unitequantite), '<BR>') WITHIN GROUP (ORDER BY mli.t_chim_denomination_id) detail
            from t_magi_ligne_incorporee mli
            left join t_chim_produit cp on cp.t_chim_produit_id = mli.t_chim_produit_id
            left join t_chim_denomination cd on cd.t_chim_denomination_id = mli.t_chim_denomination_id
            group by mli.t_magi_incorporee_id) INC on INC.t_magi_incorporee_id = mlm.t_magi_incorporee_id

where
  f.t_client_id is not null 
  and l.t_magi_magistrale_id is not null
  and l.qtefacturee > 0 
  and (a.id_del is null or a.d_del is null) 
  and a.collectivite = '0' 
  and ac.termine = '1'  

UNION

-- magistrale SPECIALITE
select
  'FACT_' || l.t_lignevente_id,
  'FACT_' || f.t_facture_id,
  l.designation_fr,
  l.qtefacturee,
  spe.detail
from
  bel.t_lignevente l
  inner join bel.t_facture f on f.t_facture_id = l.t_facture_id
  inner join bel.t_acte ac on ac.t_acte_id = f.id_acte
  inner join bel.t_assureayantdroit a on a.t_aad_id = f.t_client_id
  inner join bel.t_magi_magistrale m on m.t_magi_magistrale_id = l.t_magi_magistrale_id 
  inner join bel.t_magi_ligne_magistrale mlm on mlm.t_magi_magistrale_id = l.t_magi_magistrale_id 
  left join (select lm.t_magi_magistrale_id, 
                    LISTAGG(p.codecip||' '||p.designation||' '||TRIM(TRAILING '.' FROM TRIM(TRAILING '0' FROM TO_CHAR(lm.quantiteprescrite, 'FM9999999990.00')))||' '||"F_decode_uniteQte"(lm.unitequantite), '<BR> ') WITHIN GROUP (ORDER BY p.t_produit_id) detail
             from t_magi_ligne_magistrale lm
             left join t_produit p on lm.t_produit_id = p.t_produit_id
             group by lm.t_magi_magistrale_id ) SPE on SPE.t_magi_magistrale_id = l.t_magi_magistrale_id  

where
  mlm.t_produit_id is not null
  and f.t_client_id is not null 
  and l.t_magi_magistrale_id is not null
  and l.qtefacturee > 0 
  and (a.id_del is null or a.d_del is null) 
  and a.collectivite = '0' 
  and ac.termine = '1'  