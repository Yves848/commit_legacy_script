create or alter procedure ps_inserer_ref_produit(
  ACode13 dm_varchar13,
  ACodeLpp dm_varchar13,
  ADesignation dm_varchar60, 
  ADesignation_CB dm_libelle, 
  ATauxTva dm_varchar20,
  AHomeo dm_varchar20,
  AEtat dm_varchar20,
  AListe dm_varchar20, 
  ACodePrestation char(3),
  APrixAchatHT dm_varchar20, 
  APrixVenteHT dm_varchar20,
  APrixVenteTTC dm_varchar20,
  ABaseRemboursement dm_varchar20
 )
as
declare variable lCodeCIP13 varchar(13);
declare variable lCodeEAN13 varchar(13);
declare variable lFtTauxTVA numeric(5,2);
declare variable lIntTVAID integer;
declare variable lIntPrestationID integer;
declare variable lListe char;
declare variable lHomeo char;
declare variable lPrixAchatHT dm_varchar20;  
declare variable lPrixVenteHT dm_varchar20;
declare variable lPrixVenteTTC dm_varchar20;
begin

  -- TVA
  lFtTauxTVA = replace(ATauxTva,'%','');
  execute procedure ps_renvoyer_id_tva(lFtTauxTVA) returning_values :lIntTVAID;

  -- Liste
  if (position('Pas' in AListe )>0) then
    lListe = '0';
  else
    if (position('1' in AListe )>0) then
      lListe = '1';
    else
      if (position('2' in AListe )>0) then
        lListe = '2';
      else
        if (position('3' in AListe )>0) then
          lListe = '3';
        else
          lListe = '0';

  -- Type Homeo, un seul type pour l instant
  lHomeo = '0';

  --  Prestation
  execute procedure ps_renvoyer_id_prestation(ACodePrestation) returning_values :lIntPrestationID;
  
  -- Prix 
  lPrixAchatHT = replace(:APrixAchatHT,',','.');
  lPrixVenteHT = replace(:APrixVenteHT,',','.');
  lPrixVenteTTC = replace(:APrixVenteTTC,',','.');


  lCodeCIP13 = null;
  lCodeEAN13 = null;
  --Création CIP 
  if (ACode13 similar to '340[01][[:DIGIT:]]{9}') then 
    lCodeCIP13 = :ACode13; 
  else 
    lCodeEAN13 = :ACode13;

  -- Produit
  if (not(exists(select null 
                 from t_code_ean13 
                 where code_ean13 = :lCodeEAN13))) then
  begin


    insert into t_produit(t_produit_id,
                          code_cip,
                          designation,
                          liste,
                          t_ref_prestation_id,
                          type_homeo,
                          prix_achat_catalogue,
                          prix_vente,
                          base_remboursement,
                          t_ref_tva_id,
                          prix_achat_remise,
                          pamp,
                          commentaire_vente,
                          profil_gs,
                          calcul_gs)
    values('REF_'||:ACode13,
           :lCodeCIP13, 
           :ADesignation_CB,
           :lListe,
           :lIntPrestationID,
           :lHomeo,
           :lPrixAchatHT,
           :lPrixVenteTTC,
           0,
           :lIntTVAID,
           :lPrixAchatHT,
           :lPrixAchatHT,
           'Création automatique',
           '0',
           '0');

    if (:lCodeEAN13 similar to '[[:DIGIT:]]{13}') then
          insert into t_code_ean13 (t_code_ean13_id,
                                    t_produit_id,
                                    code_ean13)
          values (next value for seq_code_ean13,
                  'REF_'||:ACode13,
                  trim(:lCodeEAN13));
  end 
  else 
     insert into t_fct_console values(next value for seq_fct_console,
                                     current_time,
           'REF_'||:ACode13||' Existe deja'
           ,
           1 
    );
end;


create or alter procedure ps_inserer_ref_produits
as
begin
-- à maintenir manuellement
	execute procedure ps_inserer_ref_produit('3760362430835','','TROD Angine non prescrit test +','TROD ANGINE NON PRESCRIT TEST +','0%','Hors homéo','Commercialisé','pas de liste','TRD','0','15','15','70%');
	execute procedure ps_inserer_ref_produit('3760362430842','','TROD Angine non prescrit test+ DOM','TROD ANGINE NON PRESCRIT TEST+ DOM','0%','Hors homéo','Commercialisé','pas de liste','TRD','0','15,7','15,7','70%');
	execute procedure ps_inserer_ref_produit('3760362430859','','TROD Angine prescrit ou test  - ','TROD ANGINE PRESCRIT OU TEST -','0%','Hors homéo','Commercialisé','pas de liste','TRD','0','10','10','70%');
	execute procedure ps_inserer_ref_produit('3760362430866','','TROD Angine prescrit ou test - DOM','TROD ANGINE PRESCRIT OU TEST - DOM','0%','Hors homéo','Commercialisé','pas de liste','TRD','0','10,5','10,5','70%');
	execute procedure ps_inserer_ref_produit('3760362430873','','TEST Cystite non prescrit test +','TEST CYSTITE NON PRESCRIT TEST +','0%','Hors homéo','Commercialisé','pas de liste','PEE','0','15','15','70%');
	execute procedure ps_inserer_ref_produit('3760362430880','','TEST Cystite sans ordo test + DOM','TEST CYSTITE NON PRESCRIT TEST+DOM','0%','Hors homéo','Commercialisé','pas de liste','PEE','0','15,7','15,7','70%');
	execute procedure ps_inserer_ref_produit('3760362430316','','TEST Cystite prescrit ou test -','TEST CYSTITE PRESCRIT OU TEST -','0%','Hors homéo','Commercialisé','pas de liste','PEE','0','10','10','70%');
	execute procedure ps_inserer_ref_produit('3760362430323','','TEST Cystite prescrit ou test - DOM','TEST CYSTITE PRESCRIT OU TEST- DOM','0%','Hors homéo','Commercialisé','pas de liste','PEE','0','10,5','10,5','70%');
	execute procedure ps_inserer_ref_produit('3760362430286','','RENDEZ-VOUS PREVENTION RDP','RENDEZ-VOUS PREVENTION RDP','0%','Hors homéo','Commercialisé','pas de liste','RDP','0','30','30','100%');
	execute procedure ps_inserer_ref_produit('3760362430279','','RENDEZ-VOUS PREVENTION RDP DOM','RENDEZ-VOUS PREVENTION RDP DOM','0%','Hors homéo','Commercialisé','pas de liste','RDP','0','31,5','31,5','100%');
	execute procedure ps_inserer_ref_produit('3760362430293','','KIT DEPISTAGE COLORECTAL RKD','KIT DEPISTAGE COLORECTAL RKD','0%','Hors homéo','Commercialisé','pas de liste','RKD','0','3','3','70%');
	execute procedure ps_inserer_ref_produit('3760362430309','','KIT DEPISTAGE COLORECTAL RKD DOM','KIT DEPISTAGE COLORECTAL RKD DOM','0%','Hors homéo','Commercialisé','pas de liste','RKD','0','3,15','3,15','70%');
	execute procedure ps_inserer_ref_produit('3760362430231','','RAPPEL VACCINATION PRESC+ADM','RAPPEL VACCINATION PRESC+ADM','0%','Hors homéo','Commercialisé','Liste 1','RVA','0','9,6','9,6','100%');
	execute procedure ps_inserer_ref_produit('3760362430248','','RAPPEL VACCINATION PRESC+ADM DOM','RAPPEL VACCINATION PRESC+ADM DOM','0%','Hors homéo','Commercialisé','Liste 1','RVA','0','10,08','10,08','100%');
	execute procedure ps_inserer_ref_produit('3760362430255','2299799','Supplément accompagnement Optique classe A (DOM)','SUPPL ACCOMP OPTIQUE CLASSE A DOM','20%','Hors homéo','Commercialisé','Pas de liste','SOA','0','42','42','60%');
	execute procedure ps_inserer_ref_produit('3760362430262','2299799','Supplément accompagnement Optique classe A','SUPPLEMENT ACCOMP OPTIQUE CLASSE A','20%','Hors homéo','Commercialisé','Pas de liste','SOA','0','42','42','60%');
	execute procedure ps_inserer_ref_produit('3760362430200','','Code traceur retour à domicile PRADO','CODE TRACEUR RETOUR DOMICILE PRADO','0%','Hors homéo','Commercialisé','Pas de liste','DDO','0','0,01','0,01','100%');
	execute procedure ps_inserer_ref_produit('3760362430217','','Réalisation Test antiGénique (par un pharmacien) DOM','REALISATION TEST ANTIGENIQUE DOM','0%','Hors homéo','Commercialisé','Pas de liste','RTG','0','12,08','12,08','70%');
	execute procedure ps_inserer_ref_produit('3760362430224','','Rappel Vaccination Adulte DOM','RAPPEL VACCINATION ADULTE DOM','0%','Hors homéo','Commercialisé','Liste 1','RVA','0','7,88','7,88','70%');
	execute procedure ps_inserer_ref_produit('3760362430095','','ENTRETIEN FEMME ENCEINTE  DOM','ENTRETIEN FEMME ENCEINTE DOM','0%','Hors homéo','Commercialisé','Pas de liste','EFE','0','5,25','5,25','70%');
	execute procedure ps_inserer_ref_produit('3760362430088','','ENTRETIEN FEMME ENCEINTE ','ENTRETIEN FEMME ENCEINTE','0%','Hors homéo','Commercialisé','Pas de liste','EFE','0','5','5','70%');
	execute procedure ps_inserer_ref_produit('3760362430064','','Délivrance autotests Enfant < 12 ans (en pharmacie)','DELIVRANCE AUTOTEST ENF MOINS12ANS','0%','Hors homéo','Commercialisé','Pas de liste','OTO','0','5,1','5,1','100%');
	execute procedure ps_inserer_ref_produit('3760362430071','','Délivrance Autotest Education Nationale (en pharmacie)','DELIVRANCE AUTOTEST EDUC NATIONALE','0%','Hors homéo','Commercialisé','Pas de liste','OTO','0','34,6','34,6','100%');
	execute procedure ps_inserer_ref_produit('3760362430019','','Rappel Vaccination Adulte (pour les pharmaciens)','RAPPEL VACCINATION ADULTE','0%','Hors homéo','Commercialisé','Liste 1','RVA','0','7,5','7,5','70%');
	execute procedure ps_inserer_ref_produit('3760362430026','','Délivrance Test antiGénique (en pharmacie)','DELIVRANCE TEST ANTIGENIQUE','0%','Hors homéo','Commercialisé','Pas de liste','DTG','0','5','5','70%');
	execute procedure ps_inserer_ref_produit('3760362430033','','Délivrance autotests (en pharmacie)','DELIVRANCE AUTOTEST','0%','Hors homéo','Commercialisé','Pas de liste','OTO','0','4,35','4,35','100%');
	execute procedure ps_inserer_ref_produit('3760362430040','','Réalisation Test antiGénique (par un pharmacien)','REALISATION TEST ANTIGENIQUE','0%','Hors homéo','Commercialisé','Pas de liste','RTG','0','11,5','11,5','70%');
	execute procedure ps_inserer_ref_produit('3760362430057','','Code traceur TPH Télésoins (pour les pharmaciens)','CODE TRACEUR TPH TELESOINS','0%','Hors homéo','Commercialisé','Pas de liste','TPH','0','0,01','0,01','100%');
end;