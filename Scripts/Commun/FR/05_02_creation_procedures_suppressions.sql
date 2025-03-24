set sql dialect 3;

/* ********************************************************************************************** */
create or alter procedure ps_supprimer_donnees_pha(
  ATypeSuppression smallint)
as
begin
  if (ATypeSuppression = 0) then
  begin
    delete from t_ponderation;
    delete from t_rotation;

    delete from t_parametre;
  end
  else
    if (ATypeSuppression = 1) then
    begin
      delete from t_praticien;
      delete from t_hopital;
    end
    else
      if (ATypeSuppression = 2) then
      begin
        delete from t_couverture_amo where t_organisme_amo_id is null;
        delete from t_couverture_amc where t_organisme_amc_id is null;
        delete from t_organisme;
        delete from t_destinataire;
      end
      else
        if (ATypeSuppression = 3) then
        begin
          delete from t_client;
          delete from t_compte;
          delete from t_profil_remise;
          delete from t_param_remise_fixe;
          delete from t_profil_edition;
          delete from t_commentaire where type_entite = 0;
        end
        else
          if (ATypeSuppression = 4) then
          begin    
            delete from t_article_remise;        
            delete from t_commande;
            delete from t_promotion_entete;
            delete from t_classification_fournisseur where t_classification_parent_id is not null;
            delete from t_classification_fournisseur;
            delete from t_catalogue;
            delete from t_produit;
            delete from t_fournisseur_direct;
            delete from t_repartiteur;
            delete from t_classification_interne;
            delete from t_codification;
            delete from t_zone_geographique;
          end
          else
            if (ATypeSuppression = 5) then
            begin
              delete from t_operateur;
              delete from t_facture_attente;
              delete from t_credit;
              delete from t_vignette_avancee;
              delete from t_produit_du;
              delete from t_commande where etat <> '3';
            end
            else
              if (ATypeSuppression = 6) then
              begin
                delete from t_programme_avantage_produit;
                delete from t_programme_avantage_client;
                delete from t_programme_avantage;
                delete from t_carte_programme_relationnel;
              end
              else
                if (ATypeSuppression = 8) then
                begin
                  delete from t_historique_client;
                  delete from t_commande where etat = '3';
                  delete from t_document;
                end
                else
                  if (exists(select *
                             from rdb$procedures
                             where rdb$procedure_name = 'PS_SUPPRIMER_DONNEES_MODULES')) then
                    execute statement 'execute procedure PS_SUPPRIMER_DONNEES_MODULES(' || '''' || ATypeSuppression || '''' || ')';
end;

/* ********************************************************************************************** */
create or alter procedure ps_supprimer_couv_amo_inutiles
as
declare variable strCouvertureAMO varchar(50);
begin
  for select t_couverture_amo_id
       from t_couverture_amo
       into :strCouvertureAMO do
  begin
    if (not(exists(select *
                   from t_couverture_amo_client
                   where t_couverture_amo_id = :strCouvertureAMO))) then
      delete from t_couverture_amo
      where t_couverture_amo_id = :strCouvertureAMO;
  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_supprimer_couv_amc_inutiles
as
declare variable strCouvertureAMC varchar(50);
begin
  for select t_couverture_amc_id
       from t_couverture_amc
       into :strCouvertureAMC do
  begin
    if (not(exists(select *
                   from t_client
                   where t_couverture_amc_id = :strCouvertureAMC))) then
      delete from t_couverture_amc
      where t_couverture_amc_id = :strCouvertureAMC;
  end
end;
