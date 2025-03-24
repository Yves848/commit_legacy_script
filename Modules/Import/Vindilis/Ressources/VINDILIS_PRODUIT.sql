select 
  prd.serial,
  prd.libellearticle, 
  t.taux, 
  prd.gestionstock, 
  ac.code, 
  l.code, 
  prd.prixachatht, 
  prd.prixventettc, 
  prd.baseremboursement,
  prd.commentaire, 
  prd.commentairecommande,
  ( SELECT max(v.datevente) AS dernierevente
           FROM lignevente lv
             JOIN vente v ON v.serial = lv.serialvente
          WHERE lv.serialarticle = prd.serial),
  stk.dateperemption, 
  stk.stockmini,
  stk.stockmaxi,
  stk.optimisation,
  stk.blocagecommande,
  (select modedecalcul from (
    select distinct on (serialarticle) serialarticle, modedecalcul, date from traceqteproposee trace where trace.serialarticle=prd.serial) as t)
from article prd
  inner join stock stk on stk.serialarticle = prd.serial
  inner join tva t on t.serial = prd.serialtva
  left join acte ac on ac.serial = prd.serialacte
  left join liste l on l.serial = prd.serialliste