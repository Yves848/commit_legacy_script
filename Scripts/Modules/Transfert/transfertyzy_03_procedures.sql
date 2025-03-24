set sql dialect 3;


create or alter procedure ps_transfertyzy_praticien
returns (
    chaine varchar(2000)
)
as
declare variable s char;
declare variable t_praticien_id varchar(50);
declare variable type_praticien varchar(50);
declare variable nom varchar(50);
declare variable prenom varchar(50);
declare variable specialite char(2);
declare variable rue_1 varchar(50);
declare variable rue_2 varchar(50);
declare variable code_postal varchar(50);
declare variable nom_ville varchar(50);
declare variable tel_standard varchar(50);
declare variable tel_mobile varchar(50);
declare variable email varchar(100);
declare variable no_finess varchar(50);
declare variable num_rpps varchar(50);
declare variable date_dern_prescription date;
declare variable lDateDernPrescription varchar(50);
declare variable veterinaire varchar(50);

begin                                                         
    s = '|';
    chaine = 'idLgo|type|nom|prenom|specialite|rue1|rue2|codePostal|ville|telephone|mobile|email|finess|numeroAM|rpps|dateDernVente|veto'; 
    suspend;

    for select 
        trim(coalesce(prt.t_praticien_id,'')),
        trim(coalesce(prt.type_praticien,'')),
        trim(coalesce(prt.nom,'')),
        trim(coalesce(prt.prenom,'')),
        trim(coalesce(spe.code,'')),
        trim(coalesce(prt.rue_1,'')),
        trim(coalesce(prt.rue_2,'')),
        trim(coalesce(prt.code_postal,'')),
        trim(coalesce(prt.nom_ville,'')),
        trim(coalesce(prt.tel_standard,'')),
        trim(coalesce(prt.tel_mobile,'')),
        trim(coalesce(prt.email,'')),
        trim(coalesce(prt.no_finess,'')),
        trim(coalesce(prt.num_rpps,'')),
        prt.date_dern_prescription,  
        trim(coalesce(prt.veterinaire,''))
    from t_praticien prt
    left join t_ref_specialite spe on prt.t_ref_specialite_id = spe.t_ref_specialite_id
    into 
        :t_praticien_id,
        :type_praticien,
        :nom,
        :prenom,
        :specialite,
        :rue_1,
        :rue_2,
        :code_postal,
        :nom_ville,
        :tel_standard,
        :tel_mobile,
        :email,
        :no_finess,
        :num_rpps,
        :date_dern_prescription,
        :veterinaire 
    do 
    begin
        execute procedure ps_date_yzy(:date_dern_prescription) returning_values :lDateDernPrescription; 
        
        chaine = t_praticien_id || s ||
                 type_praticien || s ||
                 nom || s ||
                 prenom || s ||
                 specialite || s ||
                 rue_1 || s ||
                 rue_2 || s ||
                 code_postal || s ||
                 nom_ville || s ||
                 tel_standard || s ||
                 tel_mobile || s ||
                 email || s ||
                 no_finess || s ||
                 num_rpps || s ||
                 lDateDernPrescription || s ||  
                 veterinaire;
        
        suspend;
    end 
end;



create or alter procedure ps_transfertyzy_client
returns(
chaine varchar(2000)
  )
as
declare variable s char;
declare variable lDateNaissance varchar(20);
declare variable lDateValidPieceJustif varchar(20);
declare variable lDateCreation varchar(50);

declare variable t_client_id varchar(50);
declare variable numero_insee varchar(50);
declare variable nom varchar(50);
declare variable prenom varchar(50);
declare variable nom_jeune_fille varchar(50);
declare variable commentaire_global varchar(50);
declare variable commentaire_global_bloquant varchar(50);
declare variable commentaire_individuel varchar(50);
declare variable commentaire_individuel_bloquant varchar(50);
declare variable date_naissance varchar(50);
declare variable qualite varchar(50);
declare variable rang_gemellaire varchar(50);
declare variable nat_piece_justif_droit varchar(50);
declare variable date_validite_piece_justif varchar(50);
declare variable t_organisme_amo_id varchar(50);
declare variable t_organisme_at_id varchar(50);
declare variable t_organisme_a115_id varchar(50);
declare variable centre_gestionnaire varchar(50);
declare variable t_organisme_amc_id varchar(50);
declare variable numero_adherent_mutuelle varchar(50);
declare variable contrat_sante_pharma varchar(50);
declare variable t_couverture_amc_id varchar(50);
declare variable debut_droit_amc varchar(50);
declare variable attestation_ame_complementaire varchar(50);
declare variable fin_droit_amc varchar(50);
declare variable mutuelle_lue_sur_carte varchar(50);
declare variable mode_gestion_amc varchar(50);
declare variable date_derniere_visite varchar(50);
declare variable t_assure_rattache_id varchar(50);
declare variable rue_1 varchar(50);
declare variable rue_2 varchar(50);
declare variable code_postal varchar(50);
declare variable nom_ville varchar(50);
declare variable tel_personnel varchar(50);
declare variable tel_standard varchar(50);
declare variable tel_mobile varchar(50);
declare variable fax varchar(50);
declare variable email varchar(50);
declare variable activite varchar(50);
declare variable date_creation varchar(50);
declare variable genre varchar(50);
begin                                                         
    s ='|';
    chaine = 'clientId|numeroInsee|nom|prenom|nomJeuneFille|commentaireGlobal|commentaireGlobalBloquant|commentaireIndividuel|commentaireIndividuelBloquant|dateNaissance|qualite|rangGemellaire|natPieceJustifDroit|dateValiditePieceJustif|organismeAmoId|organismeAtId|organismeA115Id|centreGestionnaire|organismeAmcId|numeroAdherentMutuelle|contratSantePharma|couvertureAmcId|debutDroitAmc|attestationAmeComplementaire|finDroitAmc|mutuelleLueSurCarte|modeGestionAmc|dateDerniereVisite|assureRattacheId|rue1|rue2|codePostal|nomVille|telPersonnel|telStandard|telMobile|fax|email|activite|dateCreation|genre' ; 
    suspend;

   for select t_client_id,
              trim(coalesce(numero_insee,'')),
              trim(coalesce(nom,'')),
              trim(coalesce(prenom,'')),
              trim(coalesce(nom_jeune_fille,'')),
              trim(coalesce(commentaire_global,'')),
              trim(coalesce(commentaire_global_bloquant,'')),
              trim(coalesce(commentaire_individuel,'')),
              trim(coalesce(commentaire_individuel_bloquant,'')),
              trim(coalesce(date_naissance,'')),
              trim(coalesce(qualite,'')),
              trim(coalesce(rang_gemellaire,'')),
              trim(coalesce(nat_piece_justif_droit,'')),
              trim(coalesce(date_validite_piece_justif,'')),
              trim(coalesce(t_organisme_amo_id,'')),
              trim(coalesce(t_organisme_at_id,'')),
              trim(coalesce(t_organisme_a115_id,'')),
              trim(coalesce(centre_gestionnaire,'')),
              trim(coalesce(t_organisme_amc_id,'')),
              trim(coalesce(numero_adherent_mutuelle,'')),
              trim(coalesce(contrat_sante_pharma,'')),
              trim(coalesce(t_couverture_amc_id,'')),
              trim(coalesce(debut_droit_amc,'')),
              trim(coalesce(attestation_ame_complementaire,'')),
              trim(coalesce(fin_droit_amc,'')),
              trim(coalesce(mutuelle_lue_sur_carte,'')),
              trim(coalesce(mode_gestion_amc,'')),
              trim(coalesce(date_derniere_visite,'')),
              trim(coalesce(t_assure_rattache_id,'')),
              trim(coalesce(rue_1,'')),
              trim(coalesce(rue_2,'')),
              trim(coalesce(code_postal,'')),
              trim(coalesce(nom_ville,'')),
              trim(coalesce(tel_personnel,'')),
              trim(coalesce(tel_standard,'')),
              trim(coalesce(tel_mobile,'')),
              trim(coalesce(fax,'')),
              trim(coalesce(email,'')),
              trim(coalesce(activite,'')),
              trim(coalesce(date_creation,'')),
              trim(coalesce(genre,''))
  from t_client c             
      into :t_client_id,
           :numero_insee,
           :nom,
           :prenom,
           :nom_jeune_fille,
           :commentaire_global,
           :commentaire_global_bloquant,
           :commentaire_individuel,
           :commentaire_individuel_bloquant,
           :date_naissance,
           :qualite,
           :rang_gemellaire,
           :nat_piece_justif_droit,
           :date_validite_piece_justif,
           :t_organisme_amo_id,
           :t_organisme_at_id,
           :t_organisme_a115_id,
           :centre_gestionnaire,
           :t_organisme_amc_id,
           :numero_adherent_mutuelle,
           :contrat_sante_pharma,
           :t_couverture_amc_id,
           :debut_droit_amc,
           :attestation_ame_complementaire,
           :fin_droit_amc,
           :mutuelle_lue_sur_carte,
           :mode_gestion_amc,
           :date_derniere_visite,
           :t_assure_rattache_id,
           :rue_1,
           :rue_2,
           :code_postal,
           :nom_ville,
           :tel_personnel,
           :tel_standard,
           :tel_mobile,
           :fax,
           :email,
           :activite,
           :date_creation,
           :genre 
     do 
     begin
          execute procedure ps_date_naissance_yzy(:date_naissance) returning_values :lDateNaissance; 
          --execute procedure ps_date_yzy(:date_validite_piece_justif) returning_values :lDateValidPieceJustif; 
         
          chaine = :t_client_id||s||
                   :numero_insee||s||
                   :nom||s||
                   :prenom||s||
                   :nom_jeune_fille||s||
                   :commentaire_global||s||
                   :commentaire_global_bloquant||s||
                   :commentaire_individuel||s||
                   :commentaire_individuel_bloquant||s||
                   :lDateNaissance||s||
                   :qualite||s||
                   :rang_gemellaire||s||
                   :nat_piece_justif_droit||s||
                   :date_validite_piece_justif||s||
                   :t_organisme_amo_id||s||
                   :t_organisme_at_id||s||
                   :t_organisme_a115_id||s||
                   :centre_gestionnaire||s||
                   :t_organisme_amc_id||s||
                   :numero_adherent_mutuelle||s||
                   :contrat_sante_pharma||s||
                   :t_couverture_amc_id||s||
                   :debut_droit_amc||s||
                   :attestation_ame_complementaire||s||
                   :fin_droit_amc||s||
                   :mutuelle_lue_sur_carte||s||
                   :mode_gestion_amc||s||
                   :date_derniere_visite||s||
                   :t_assure_rattache_id||s||
                   :rue_1||s||
                   :rue_2||s||
                   :code_postal||s||
                   :nom_ville||s||
                   :tel_personnel||s||
                   :tel_standard||s||
                   :tel_mobile||s||
                   :fax||s||
                   :email||s||
                   :activite||s||
                   :date_creation||s||
                   :genre; 


      suspend;
     end 
end;

create or alter procedure ps_date_yzy (
    dateFB timestamp
) returns (
    dateYzy varchar(50) )
as
begin
    if (dateFB is null) then 
        dateyzy = '';
    else    
        dateyzy = lpad( extract( year from datefb ), 4, '0' ) ||'-'||
                  lpad( extract( month from datefb ), 2, '0' ) ||'-'||
                  lpad( extract( day from datefb ), 2, '0' ) ||' '|| 
                  lpad( extract( hour from datefb ), 2, '0' ) ||':'||
                  lpad( extract( minute from datefb ), 2, '0') ||':'||
                  lpad( cast(extract( second from datefb ) as integer), 2, '0') ;

    suspend;
end;

create or alter procedure ps_date_naissance_yzy (
    datePHA varchar(20) 
) returns (
    dateYzy varchar(50) )
as
declare variable validDate date;
begin
    if ((datePHA is null) or (trim(datePHA)='')) then 
        dateyzy = '';
    else
        begin 
            begin 
                -- pour les dates pourrie on essyer de convertir en vraie date
                validDate = cast(substring(datePHA from 5 for 4) || '-' ||
                                    substring(datePHA from 3 for 2) || '-' ||
                                    substring(datePHA from 1 for 2) as date);
                dateyzy = substring(datePHA from 5 for 4) ||'-'||
                          substring(datePHA from 3 for 2) ||'-'||
                          substring(datePHA from 1 for 2); 
            end          
            when any do
                -- exception, la date n a pas pu etre convertie
                dateYzy = '';
        end    
    suspend;
end;

create or alter procedure ps_codes_yzy (
    t_produit_id dm_code
) returns (
eans blob sub_type text )
as
declare variable code varchar(50);
declare variable type_code varchar(50);
begin
    eans = '';
    for select iif(trim(CODE_CIP) similar to '[[:DIGIT:]]{7}','CIP7:','CIP:')||trim(CODE_CIP) 
        from t_produit 
        where t_produit_id = :t_produit_id 
        union
        select 'BCB:'||T_PRODUIT_BDM_ID 
        from t_produit 
        where t_produit_id = :t_produit_id 
        union
        select 'EAN:'||CODE_EAN13 
        from T_CODE_EAN13 
        where code_ean13 not like '20000%' and t_produit_id = :t_produit_id

        into :code do
        begin 
            if (code is not null) then
            begin

                if (eans = '') then        
                    eans = :eans||':'||:code;
                else
                    eans = :eans||','||':'||:code;
            end         
        end
        suspend;          
end;


create or alter procedure ps_transfertyzy_depot
returns(
chaine varchar(500))
as
declare variable s char;
declare variable AIDDepot dm_code;
declare variable ALibelle dm_libelle;
declare variable AAutomate dm_boolean;
declare variable ATypeDepot dm_type_depot;
declare variable id_cloud varchar(50);
begin
    s = '|';
    chaine = 'warehouseIdLgo|name|robot|type|idcloud' ; 
    suspend;

   for select d.t_depot_id,
              d.libelle,
              d.automate,
              d.type_depot,
              coalesce(t.t_transfertyzy_depot_id,'')
      from t_depot d
      left join t_transfertyzy_depot t on t.t_depot_id = d.t_depot_id
      into :AIDDepot,
           :ALibelle,
           :AAutomate,
           :ATypeDepot,
           :id_cloud 
      do
      begin
        chaine = :AIDDepot||s||
                 :ALibelle||s||
                 iif(:AAutomate=1,'true','false')||s||
                 :ATypeDepot||s||
                 coalesce(:id_cloud,'')||s;
        suspend;  
      end      
end;



create or alter procedure ps_transfertyzy_produit
returns(
chaine varchar(500)
  )
as
-- champs historiques en A... gardent leur nom
-- variables locale en l...
-- champs specifique yzy avec leur nonimation yzy

declare variable s char;
declare variable codes varchar(1000);
declare variable AIDProduit varchar(50);
declare variable AIDProduitLGPI varchar(50);
declare variable ACodeCIP dm_code_cip;
declare variable ADesignation varchar(50);
declare variable APrixTTC numeric(10,3);
declare variable hdPersonalized varchar(50);
declare variable ATauxTVA numeric(5,2);
declare variable AContenance numeric(5);
declare variable AUniteMesure char(1);
declare variable ecoPart numeric(5,2); --?
declare variable ABaseRemboursement numeric(10,2);
declare variable marketingStatus varchar(50); -- AVAILABLE DELETED PHARMACO
declare variable AEtat char(1); -- ?
declare variable ADateDerniereVente date;
declare variable lDateDerniereVente varchar(50);
declare variable AVeterinaire char(1);
declare variable nbModeAdministration integer;
declare variable modeAdministration integer;
declare variable doseform varchar(50); --1910,Gélule 2054,Comprimé
declare variable classificationDto varchar(50); --?
declare variable ACodification1 varchar(50);
declare variable ACodification2 varchar(50);
declare variable ACodification3 varchar(50);
declare variable ACodification4 varchar(50);
declare variable ACodification5 varchar(50);
declare variable ACodification6 varchar(50);
declare variable idPackageBdm varchar(50);
begin
    s = '|';
    hdPersonalized = '';
    ecoPart = 0;
    idPackageBdm = '';
    doseform = '';
    classificationDto = '';
    marketingStatus = 'AVAILABLE'; 
    classificationDto = '';
    idPackageBdm = '';


    chaine = 'idLgo|idcloud|designation|productCodes|publicPrice|hdPersonalized|vatRate|contenance|measureUnit|ecoPart|reimbursementBasis|marketingStatus|lastSaleDate|veterinary|nbModeAdministration|modeAdministration|doseForm|classificationDto|codif1|codif2|codif3|codif4|codif5|codif6|idPackageBdm|managedQuantity' ; 
    suspend;

    for select prd.t_produit_id,
               coalesce(t.t_transfertyzy_produit_id,''),
               replace(prd.designation,'|',''),
               prd.prix_vente,
               tva.taux,
               coalesce(prd.contenance,0),
               coalesce(prd.unite_mesure,0),
               prd.base_remboursement,
               prd.etat,
               prd.date_derniere_vente,
               prd.veterinaire,
               trim(coalesce(cdf1.libelle,cdf1.code,'')),
               trim(coalesce(cdf2.libelle,cdf2.code,'')),
               trim(coalesce(cdf3.libelle,cdf3.code,'')),
               trim(coalesce(cdf4.libelle,cdf4.code,'')),
               trim(coalesce(cdf5.libelle,cdf5.code,'')),  
               trim(coalesce(cdf6.libelle,cdf6.code,'')),
               1 
      from t_produit prd
      left join t_transfertyzy_produit t on t.t_produit_id = prd.t_produit_id
      left join t_ref_tva tva on (tva.t_ref_tva_id = prd.t_ref_tva_id)
      left join t_codification cdf1 on (cdf1.t_codification_id = prd.t_codif_1_id)
      left join t_codification cdf2 on (cdf2.t_codification_id = prd.t_codif_2_id)
      left join t_codification cdf3 on (cdf3.t_codification_id = prd.t_codif_3_id)
      left join t_codification cdf4 on (cdf4.t_codification_id = prd.t_codif_4_id)
      left join t_codification cdf5 on (cdf5.t_codification_id = prd.t_codif_5_id)
      left join t_codification cdf6 on (cdf6.t_codification_id = prd.t_codif_6_id)
      into :AIDProduit,
           :AIDProduitLGPI,
           :ADesignation,
           :APrixTTC,
           :ATauxTVA,
           :AContenance,
           :AUniteMesure,
           :ABaseRemboursement,
           :AEtat, -- ? dispo pas dispos AVAILABLE DELETED PHARMACO
           :ADateDerniereVente,
           :AVeterinaire,
           :ACodification1,
           :ACodification2,
           :ACodification3,
           :ACodification4,
           :ACodification5,
           :ACodification6,
           :managedQuantity
      do    
      begin          
          execute procedure ps_codes_yzy(:AIdProduit) returning_values :codes;           
          execute procedure ps_date_yzy(:ADateDerniereVente) returning_values :lDateDerniereVente; 
          chaine = :AIDProduit||s||
                   :AIDProduitLGPI||s||
                   :ADesignation||s||
                   :codes||s||
                   :APrixTTC||s||
                   :hdPersonalized||s||
                   :ATauxTVA||s||
                   :AContenance||s||
                   :AUniteMesure||s||
                   :ecoPart||s||
                   :ABaseremboursement||s||
                   :marketingStatus||s||
                   :lDateDerniereVente||s||
                   :AVeterinaire||s||
                   coalesce(:modeAdministration,'')||s||
                   coalesce(:nbModeAdministration,'')||s||
                   :doseform||s||
                   :classificationDto||s||
                   :ACodification1||s||
                   :ACodification2||s||
                   :ACodification3||s||
                   :ACodification4||s||
                   :ACodification5||s||
                   :ACodification6||s||
                   :idPackageBdm,
                   :managedQuantity; 
         suspend;
      end
end;


create or alter procedure ps_transfertyzy_stock
returns(
chaine varchar(500)
  )
as
declare variable s char;
declare variable AIDProduit varchar(50);
declare variable AIDDepot varchar(50);
declare variable AQuantite numeric(5);
declare variable idRepro varchar(50);
begin
  s = '|';
  chaine = 'idLgo|warehouseIdLgo|quantity|idRepro' ; 
  suspend;
  for select pg.t_produit_id,
             pg.t_depot_id,
             pg.quantite,
             coalesce(t.t_transfertyzy_stock_id,'')
      from t_produit_geographique pg
      left join t_transfertyzy_stock t on (t.t_produit_geographique_id = pg.t_produit_id)
      into :AIDProduit,
           :AIDDepot,
           :AQuantite,
           :idRepro
       do
       begin 
        chaine = :AIDProduit||s||
                 :AIDDepot||s||   
                 :AQuantite||s||  
                 :idRepro||s; 
        suspend;                    
       end            
end;
