       
       --  C EN COURS ( pas transmise ) NON
       --  T transmise NON
       --  L éclatée OUI
       --  A valorise et facture OUI
       --  D recue et valorisée OUI
       --  M transférée ( Annulée ?) NON 
       --  F recue et facturee OUI   
       --  D recue + valorise  + facture OUI   
       --  Q Valorisée OUI
       --  R recue OUI

-- commandes grossistes entetes
SELECT 'REP_'+cp_code,  -- numero commande 
	   re_code,  -- code repartiteur
	   '',       -- code fournisseur
	   trim(cast(cp_dtcre as varchar(10))), -- date creation
	   trim(cast(cp_dtcom as varchar(10))), -- date commande
	   trim(cast(cp_dtrec as varchar(10))), -- date reception prevue 
	   cp_qtcom, -- quantité commandée
	   cp_qtrec, -- quantité recue
	   cp_qtgra, -- gratuits
	   cp_bcom, -- montant brut
	   cp_pcom, -- montant net
	   cp_prem, -- remise
	   cp_etat  -- T transmise /R recue /V recue et valorisée 
FROM comartic
WHERE cp_dtcre >= add_months(sysdate,-36)
  AND cp_etat IN ( 'V', 'L', 'A', 'D', 'R', 'Q', 'F' ) 

UNION

-- commandes directes entetes
SELECT 'FOU_'+cd_code,  -- numero commande 
	   '',       -- code repartiteur
	   'FOU_'||la_code,  -- code fournisseur
	   trim(cast(cd_dtcre as varchar(10))), -- date creation
	   trim(cast(cd_dtcom as varchar(10))), -- date commande
	   trim(cast(cd_dtrec as varchar(10))), -- date reception prevue 
	   cd_qtcom, -- quantité commandée
	   cd_qtrec, -- quantité recue
	   cd_qtgra, -- gratuits
	   cd_bcom, -- montant brut
	   cd_pcom, -- montant net
	   cd_prem, -- remise
     cd_etat  -- T transmise /R recue /V recue et valorisée 
FROM comprod
WHERE cd_dtcre >= add_months(sysdate,-36)
  AND cd_etat IN ( 'V', 'L', 'A', 'D', 'R', 'Q', 'F' ) 

UNION

-- commandes groupement 
SELECT 'GRP_'+ch_code,   -- numero commande 
       '', 	             -- code repartiteur	
       'GRP_'||gr_code,  -- code fournisseur
       trim(cast(ch_dtcre as varchar(10))), -- date creation
       trim(cast(ch_dtcom as varchar(10))), -- date commande
       trim(cast(ch_dtrec as varchar(10))), -- date reception prevue 
       ch_qtcom, -- quantité commandée
       ch_qtrec, -- quantité recue
       ch_qtgra, -- gratuits
       ch_bcom, -- montant brut
       ch_pcom, -- montant net
       ch_prem, -- remise
       ch_etat  -- transmis/recu/ recu et valorisé 
FROM comech
WHERE ch_dtcre >= add_months(sysdate,-36)
  AND ch_etat IN ( 'V', 'L', 'A', 'D', 'R', 'Q', 'F' )  