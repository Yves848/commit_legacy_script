set sql dialect 3;
/*********************************************************************************************** */
create or alter procedure ps_supprimer_donnees_pha(
  ATypeSuppression smallint)
as
begin
  if (ATypeSuppression = 0) then
  begin
    --delete from t_parametre;
  end
  else
    if (ATypeSuppression = 1) then --grille praticiens
    begin
      delete from t_medecin;
    end
    else
      if (ATypeSuppression = 2) then -- organisme
      begin
		delete from T_ORGANISMECPAS;
      end
      else
        if (ATypeSuppression = 3) then --grille clients
        begin
			delete from T_PROFILREMISE;
			delete from T_PROFILREMISESUPPL;
			delete from T_CLIENT;
			delete from t_compte;
			delete from T_CARTERIST;
			delete from T_TRANSACTIONRIST;
			delete from T_ATTESTATION;
			delete from t_patient_pathologie;
			delete from t_patient_allergie_atc;	
        end
        else
          if (ATypeSuppression = 4) then	 --produits
          begin
            delete from t_zonegeo;
            delete from T_TARIFPDT;
            delete from t_histovente;
			delete from t_historique_achat;
            delete from t_produit;
            delete from T_STOCK;
            delete from t_depot;
			delete from t_fournisseur;
			delete from t_repartiteur;
            delete from T_FICHEANALYSE;
            delete from T_CODEBARRE;
			delete from T_MAGISTRALE_FORMULAIRE;
			delete from T_MAGISTRALE_FORMULE;
			delete from T_MAGISTRALE_FORMULE_LIGNE;
			delete from t_sch_medication_produit;
			delete from T_SCH_MEDICATION_PRISE;
			delete from T_SOLDE_TUH_PATIENT;
			delete from T_SOLDE_TUH_BOITE;
          end
          else
            if (ATypeSuppression = 5) then --encours
            begin
              delete from t_deldif;
              delete from T_CREDIT;
              delete from T_LITIGE;
            end
            else
              if (ATypeSuppression = 8) then -- autre
              begin
                delete from t_parametres;
                delete from T_HISTODELDETAILS;
                delete from T_HISTODELGENERAL;
                delete from T_HISTODELMAGISTRALE;
              end
				else
				if (exists(select *
						 from rdb$procedures
						 where rdb$procedure_name = 'PS_SUPPRIMER_DONNEES_MODULES')) then
				execute statement 'execute procedure PS_SUPPRIMER_DONNEES_MODULES(' || '''' || ATypeSuppression || '''' || ')';
end;

/*
        C_INDEX_PAGE_PRATICIENS : TraiterDonnees(wzDonnees.ActivePage, grdPraticiens, lBoolReset, TPIList<Integer>.Create([Ord(suppPraticiens)]), TraiterDonneesPraticiens);
        C_INDEX_PAGE_ORGANISMES : TraiterDonnees(wzDonnees.ActivePage, grdOrganismes, lBoolReset, TPIList<Integer>.Create([Ord(suppOrganismes)]), TraiterDonneesOrganismes);
        C_INDEX_PAGE_CLIENTS : TraiterDonnees(wzDonnees.ActivePage, grdClients, lBoolReset, TPIList<Integer>.Create([Ord(suppEnCours), Ord(SuppCarteFidelite), Ord(suppHistoriques), Ord(suppClients)]), TraiterDonneesClients);
        C_INDEX_PAGE_PRODUITS : TraiterDonnees(wzDonnees.ActivePage, grdProduits, lBoolReset, TPIList<Integer>.Create([Ord(suppEnCours), Ord(SuppCarteFidelite), Ord(suppHistoriques), Ord(suppProduits)]), TraiterDonneesProduits);
        C_INDEX_PAGE_ENCOURS : TraiterDonnees(wzDonnees.ActivePage, grdEnCours, lBoolReset, TPIList<Integer>.Create([Ord(suppEnCours)]), TraiterDonneesEnCours);
        C_INDEX_PAGE_AUTRES_DONNEES : TraiterDonnees(wzDonnees.ActivePage, grdAutresDonnees, lBoolReset, TPIList<Integer>.Create([Ord(suppParametre), Ord(SuppCarteFidelite), Ord(suppHistoriques)]), TraiterAutresDonnees);


     TSuppression = (suppParametre, suppPraticiens, suppOrganismes, suppClients, suppProduits, suppEnCours, suppCarteFidelite, suppLocation, suppHistoriques);
  TSuppressions = set of TSuppression;


  donc suppparametres = 1 pour la proc PHA
  */
