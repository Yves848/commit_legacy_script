set sql dialect 3;

create view v_util_commandes_en_cours(
  t_commande_id,
  t_produit_id
)
as
select
  c.t_commande_id,
  l.t_produit_id
from
  t_commande_ligne l
  inner join t_commande c on (c.t_commande_id = l.t_commande_id)
where 
  c.etat <> 3;




/* ********************************************************************************************** */
create desc index idx_hist_cli_date_acte on t_historique_client(date_acte);

/* ********************************************************************************************** */
recreate view v_utl_pha_client_encours(
  t_client_id, nom_client, prenom_client,
  t_credit_id,  montant_credit, date_credit,
  t_vignette_avancee_id, code_cip_avance, quantite_avancee, date_avance,
  t_facture_attente_id, date_facture,
  t_produit_du_id, code_cip_du, quantite_du, date_du)
as
-- clients a exclure de la purge car relies a un encours
select 
  cen.t_client_id, cen.nom, cen.prenom,
  cr.t_credit_id, cr.montant, cr.date_credit,
  v.t_vignette_avancee_id, v.code_cip, v.quantite_avancee, v.date_avance,
  f.t_facture_attente_id, f.date_acte,
  p.t_produit_du_id, pr.code_cip, p.quantite, p.date_du
from t_client cen                    
  left join t_credit cr on (cr.t_client_id = cen.t_client_id)
  left join t_vignette_avancee v on (v.t_client_id = cen.t_client_id)
  left join t_facture_attente f on (f.t_client_id = cen.t_client_id)
  left join t_produit_du p on (p.t_client_id = cen.t_client_id)
  left join t_produit pr on (pr.t_produit_id = p.t_produit_id)
where cen.repris = '1'
  and ((cr.repris = '1' and cr.t_credit_id is not null) or 
       (v.repris = '1' and v.t_vignette_avancee_id is not null) or 
	   (f.repris = '1' and f.t_facture_attente_id is not null) or 
	   (p.repris = '1' and p.t_produit_du_id is not null));
  
/* ********************************************************************************************** */
recreate view v_utl_pha_produit_encours(
  t_produit_id, 
  t_vignette_avancee_id, 
  t_facture_attente_ligne_id, 
  t_produit_du_id,
  t_commande_id)
as 
--produits a exclure de la purge car relié a un encours 
select 
  p.t_produit_id, 
  v.t_vignette_avancee_id, 
  fl.t_facture_attente_ligne_id, 
  pd.t_produit_du_id,
  co.t_commande_id
from t_produit p

  left join t_vignette_avancee v on (v.t_produit_id = p.t_produit_id)
  left join t_facture_attente_ligne fl on (fl.t_produit_id = p.t_produit_id)
  left join t_facture_attente f on (fl.t_facture_attente_id = f.t_facture_attente_id)
  left join t_produit_du pd on (pd.t_produit_id = p.t_produit_id)
  left join v_util_commandes_en_cours co on co.t_produit_id = p.t_produit_id
where p.repris = '1'  
  and ((v.repris = '1' and v.t_vignette_avancee_id is not null) or 
     (f.repris = '1' and f.t_facture_attente_id is not null) or 
     (pd.repris = '1' and pd.t_produit_du_id is not null) or
           ( co.t_commande_id is not null)
           );
/* ********************************************************************************************** */
create or alter procedure ps_utl_pha_organismes_amc(
  atype char(1),
  aparametre varchar(500))
returns(
  aorganismeamcid varchar(50),
  anom varchar(50),
  anomreduit varchar(20),
  aidentifiantnational varchar(9),
  arue1 varchar(40),
  arue2 varchar(40),
  acodepostalville varchar(36),
  acommentaire varchar(200))
as
begin
  if (atype = '0') then
    for select o.t_organisme_id,
               o.nom,
               o.nom_reduit,
               o.identifiant_national,
               o.rue_1,
               o.rue_2,
               case
                 when ((o.code_postal is null) or (o.code_postal = '')) then o.nom_ville
                 else o.code_postal || ' ' || o.nom_ville
               end,
               o.commentaire
        from t_organisme o
        where o.type_organisme = '2'
          and o.repris = '1'
          and not (exists (select *
                           from t_client c
                           where c.t_organisme_amc_id = o.t_organisme_id))
        into :aorganismeamcid,
             :anom,
             :anomreduit,
             :aidentifiantnational,
             :arue1,
             :arue2,
             :acodepostalville,
             :acommentaire do
      suspend;
end;


/* ********************************************************************************************** */
create or alter procedure ps_utl_pha_clients(
  atype char(1),
  aparametre varchar(500))
returns(
  aclientid varchar(50),
  anom varchar(50),
  aprenom varchar(50),
  anumeroinsee varchar(15),
  adatedernierevisite date)
as
begin
  if (atype = '0') then
    for select c.t_client_id,
               c.nom,
               c.prenom,
               c.numero_insee,
               c.date_derniere_visite
        from t_client c
        where (c.date_derniere_visite < :aparametre or c.date_derniere_visite is null)
          and c.repris = '1'
          and not exists(select * from v_utl_pha_client_encours en where en.t_client_id = c.t_client_id)
        into :aclientid,
             :anom,
             :aprenom,
             :anumeroinsee,
             :adatedernierevisite do
      suspend;
  else
    if (atype = '2') then
      for select c.t_client_id,
               c.nom,
               c.prenom,
               c.numero_insee,
               c.date_derniere_visite
        from t_client c
        where ((c.numero_insee = '') or (c.numero_insee is null))
          and c.repris = '1'
          and not exists(select * from v_utl_pha_client_encours en where en.t_client_id = c.t_client_id)
        into :aclientid,
             :anom,
             :aprenom,
             :anumeroinsee,
             :adatedernierevisite do
        suspend;
    else
      if (atype = '1') then
        for select b.t_client_id,
               b.nom,
               b.prenom,
               b.numero_insee,
               b.date_derniere_visite
          from t_client b
          where b.qualite <> 1
            and not exists(select *
                           from t_client a
                           where a.numero_insee = b.numero_insee
                             and a.repris = '1')                            
            and b.repris = '1'
            and not exists(select * from v_utl_pha_client_encours en where en.t_client_id = b.t_client_id)
          into :aclientid,
             :anom,
             :aprenom,
             :anumeroinsee,
             :adatedernierevisite do
          suspend;
      else
        if (atype = '3') then
          for select b.t_client_id,
               b.nom,
               b.prenom,
               b.numero_insee,
               b.date_derniere_visite
              from t_client b
              where t_organisme_amo_id is null 
                and t_organisme_amc_id is null
                and b.repris = '1'
                and not exists(select * from v_utl_pha_client_encours en where en.t_client_id = b.t_client_id)              
              into :aclientid,
               :anom,
               :aprenom,
               :anumeroinsee,
               :adatedernierevisite do
            suspend;
        else
          for select c.t_client_id,
                     c.nom,
                     c.prenom,
                     c.numero_insee,
                     c.date_derniere_visite
              from t_client c
              where c.repris = '1'
                and not exists(select * from v_utl_pha_client_encours en where en.t_client_id = c.t_client_id)
              into :aclientid,
                   :anom,
                   :aprenom,
                   :anumeroinsee,
                   :adatedernierevisite do
            suspend;
end;

create or alter procedure ps_utl_pha_praticiens(
  AType char(1),
  AParametre varchar(500))
returns(
  APraticienID varchar(255),
  ANom varchar(255),
  APrenom varchar(255),
  ANoFiness varchar(15),
  ASpecialite varchar(2),
  ANumRPPS varchar(15),
  ARue1 varchar(128),
  ARue2 varchar(128),
  ACodePostalVille varchar(5),
  ACommentaire varchar(256),
  ADateDernierePrescription date)
as
BEGIN
if (AType = '0') then
  for SELECT DISTINCT p.t_praticien_id,
                  p.nom,
                  p.prenom,
                  p.no_finess,
                  p.t_ref_specialite_id,
                  p.num_rpps,
                  p.rue_1,
                  p.rue_2,
                  p.code_postal,
                  p.commentaire,
                  h.date_prescription
FROM t_praticien p
INNER JOIN t_historique_client h
on p.t_praticien_id = h.t_praticien_id 
WHERE p.num_rpps is null and p.repris = '1'
into :APraticienID,
         :ANom,
         :APrenom,
         :ANoFiness,
         :ASpecialite,
         :ANumRPPS,
         :ARue1,
         :ARue2,
         :ACodePostalVille,
         :ACommentaire,
         :ADateDernierePrescription do
  suspend;
else
for SELECT DISTINCT p.t_praticien_id,
                  p.nom,
                  p.prenom,
                  p.no_finess,
                  p.t_ref_specialite_id,
                  p.num_rpps,
                  p.rue_1,
                  p.rue_2,
                  p.code_postal,
                  p.commentaire,
                  h.date_prescription
FROM t_praticien p
INNER JOIN t_historique_client h
ON p.t_praticien_id = h.t_praticien_id
WHERE h.date_prescription >= :AParametre
      and p.repris = '1'
    into :APraticienID,
         :ANom,
         :APrenom,
         :ANoFiness,
         :ASpecialite,
         :ANumRPPS,
         :ARue1,
         :ARue2,
         :ACodePostalVille,
         :ACommentaire,
         :ADateDernierePrescription do
  suspend;
END;
/* ********************************************************************************************** */
create or alter procedure ps_utl_pha_produits(
  AType char(1),
  AParametre varchar(500))
returns(
  AProduitID varchar(50),
  ACodeCIP dm_code_cip,
  ADesignation varchar(50),
  APrixAchatCatalogue numeric(10,3),
  APrixVente numeric(10,2),
  APAMP numeric(10,3),
  APrixAchatRemise numeric(10,3),
  AFournisseur varchar(50),
  ARepartiteur varchar(50),
  APrestation varchar(3),
  ADateDerniereVente date,
  AStockTotal integer,
  ATypeHomeo char(1))
as
begin
  if (AType = '0') then
    for select p.t_produit_id,
               p.code_cip,
               p.designation,
               p.prix_achat_catalogue,
               p.prix_vente,
               p.pamp,
               p.prix_achat_remise,
               c.libelle,
               r.raison_sociale,
               a.code,
               p.date_derniere_vente,
               s.stock_total,
               p.type_homeo
        from t_produit p
             inner join t_ref_prestation a on (a.t_ref_prestation_id = p.t_ref_prestation_id)
             left join t_codification c on (c.t_codification_id = p.t_codif_6_id)
             left join t_repartiteur r on (r.t_repartiteur_id = p.t_repartiteur_id)
             left join (select t_produit_id, sum(quantite) stock_total
                        from t_produit_geographique
                        group by t_produit_id) s on (s.t_produit_id = p.t_produit_id)
        where (p.date_derniere_vente < :AParametre  or p.date_derniere_vente is null)
          and p.repris = '1'
          and (s.stock_total <= 0 or s.stock_total is null)
          and not exists(select * from v_utl_pha_produit_encours en where en.t_produit_id = p.t_produit_id)
        into :AProduitID,
             :ACodeCIP,
             :ADesignation,
             :APrixAchatCatalogue,
             :APrixVente,
             :APAMP,
             :APrixAchatRemise,
             :AFournisseur,
             :ARepartiteur,
             :APrestation,
             :ADateDerniereVente,
             :AStockTotal,
             :ATypeHomeo do
      suspend;
  else
    if (AType = '1') then
      for select p.t_produit_id,
                 p.code_cip,
                 p.designation,
                 p.prix_achat_catalogue,
                 p.prix_vente,
                 p.pamp,
                 p.prix_achat_remise,
                 c.libelle,
                 r.raison_sociale,
                 a.code,
                 p.date_derniere_vente,
                 s.stock_total,
                 p.type_homeo
          from t_produit p
               inner join t_ref_prestation a on (a.t_ref_prestation_id = p.t_ref_prestation_id)
               left join t_codification c on (c.t_codification_id = p.t_codif_6_id)
               left join t_repartiteur r on (r.t_repartiteur_id = p.t_repartiteur_id)
               left join (select t_produit_id, sum(quantite) stock_total
                          from t_produit_geographique
                          group by t_produit_id) s on (s.t_produit_id = p.t_produit_id)
          where p.t_codif_6_id = :AParametre
            and p.repris = '1'
            and (s.stock_total <= 0 or s.stock_total is null)
            and not exists(select * from v_utl_pha_produit_encours en where en.t_produit_id = p.t_produit_id)            
          into :AProduitID,
               :ACodeCIP,
               :ADesignation,
               :APrixAchatCatalogue,
               :APrixVente,
               :APAMP,
               :APrixAchatRemise,
               :AFournisseur,
               :ARepartiteur,
               :APrestation,
               :ADateDerniereVente,
               :AStockTotal,
               :ATypeHomeo do
        suspend;
    else
      for select p.t_produit_id,
                 p.code_cip,
                 p.designation,
                 p.prix_achat_catalogue,
                 p.prix_vente,
                 p.pamp,
                 p.prix_achat_remise,
                 c.libelle,
                 r.raison_sociale,
                 a.code,
                 p.date_derniere_vente,
                 s.stock_total,
                 p.type_homeo
            from t_produit p
                 inner join t_ref_prestation a on (a.t_ref_prestation_id = p.t_ref_prestation_id)
                 left join t_codification c on (c.t_codification_id = p.t_codif_6_id)
                 left join t_repartiteur r on (r.t_repartiteur_id = p.t_repartiteur_id)
                 left join (select t_produit_id, sum(quantite) stock_total
                            from t_produit_geographique
                            group by t_produit_id) s on (s.t_produit_id = p.t_produit_id)
            where p.repris = '1'
              and not exists(select * from v_utl_pha_produit_encours en where en.t_produit_id = p.t_produit_id)
            into :AProduitID,
                 :ACodeCIP,
                 :ADesignation,
                 :APrixAchatCatalogue,
                 :APrixVente,
                 :APAMP,
                 :APrixAchatRemise,
                 :AFournisseur,
                 :ARepartiteur,
                 :APrestation,
                 :ADateDerniereVente,
                 :AStockTotal,
                 :ATypeHomeo do
        suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_utl_pha_histo_client(
  AType char(1),
  AParametre varchar(500))
returns(
  AHistoriqueClientID varchar(50),
  ANumeroFacture numeric(10),
  ADateActe date,
  ADatePrescription date,
  ANomClient varchar(30),
  APrenomClient varchar(30),
  APurgeClient varchar(30))
as
begin
  if (AType = '0') then
    for select h.t_historique_client_id,
               h.numero_facture,
               h.date_acte,
               h.date_prescription,
               c.prenom,
               c.nom,
               iif(c.repris = '0' , 'Client purgé', '')
        from t_historique_client h  inner join t_client c on (c.t_client_id = h.t_client_id)
        where (h.date_acte < :AParametre)
          and h.repris = '1'

          and not exists(select * from v_utl_pha_client_encours en where en.t_client_id = c.t_client_id)		 
        into :AHistoriqueClientID,
             :ANumeroFacture,
             :ADateActe,
             :ADatePrescription,
             :ANomClient,
             :APrenomClient,
             :APurgeClient do
      suspend;
end;


/* ********************************************************************************************** */
create or alter procedure ps_utl_pha_commandes(
  AType char(1),
  AParametre varchar(500))
returns(
  ACommandeID varchar(50),
  ADateCommande date,
  ADateReception date,
  ANomFournisseur varchar(30),
  AMontant numeric(10,2) )
as
begin
  if (AType = '0') then -- 0 toutes commandes archivée : purge par date
    for select com.t_commande_id,
               com.date_creation,
               com.date_reception,
               coalesce(rep.raison_sociale, fou.raison_sociale),
               com.montant_ht
          from t_commande com 
          left join t_repartiteur rep on rep.t_repartiteur_id = com.t_repartiteur_id
          left join t_fournisseur_direct fou on fou.t_fournisseur_direct_id = com.t_fournisseur_direct_id         
        where (com.date_creation < :Aparametre)
          and com.repris = '1'
          and com.etat = '3'
        into :ACommandeID,
             :ADateCommande,
             :ADateReception,
             :ANomFournisseur,
             :AMontant do
      suspend;
end;


/* ********************************************************************************************** */
recreate view v_utl_pha_fournisseur_direct(
  id,
  libelle,
  nombre_produits)
as
select c.t_codification_id,
       c.libelle,
       count(*)
from t_codification c
     inner join t_produit p on (p.t_codif_6_id = c.t_codification_id)
group by c.t_codification_id,
         c.libelle;

/* ********************************************************************************************** */
create or alter procedure ps_utl_pha_purger(
  ADonneesAPurger char(1),
  ATypePurge char(1),
  AParametrePurge varchar(500),
  AReset char(1))
returns(
  ADonneesRestantes integer,
  ADonneesPurges integer)
as
declare variable strTable varchar(31);
declare variable strTableID varchar(31);
declare variable strProcedure varchar(31);
declare variable strProcedureID varchar(31);
declare variable intID varchar(50);
begin
  -- Paramètrage des tables/procédures

  -- cas des encours : 4 traitements differents géré "en dur"
  if (ADonneesAPurger in ( '5', '6', '7', '8', '9')) then -- en cours
  begin
      if (ADonneesAPurger = '5') then
      begin -- 5 = tous les encours
          if (AReset = '0') then  
            begin
              --insert into t_debug values ( :ADonneesAPurger, 'purge de tout',:AParametrePurge,:AReset);
              update t_credit set repris = '0' where date_credit < :AParametrePurge;
              update t_vignette_avancee set repris = '0' where date_avance < :AParametrePurge;
              update t_facture_attente set repris = '0' where date_acte < :AParametrePurge;
              update t_produit_du set repris = '0' where date_du < :AParametrePurge;
            end  
          else if (AReset = '1') then
            begin
              --insert into t_debug values ( :ADonneesAPurger, 'reset de tout',:AParametrePurge,:AReset);
              update t_credit set repris = '1';
              update t_vignette_avancee set repris = '1';
              update t_facture_attente set repris = '1';
              update t_produit_du set repris = '1';     
            end
       end     
      else -- un seul traitement 6 7 8 ou 9
      begin
         if (AReset = '0') then  -- mode normal
          begin  
            --  insert into t_debug values ( :ADonneesAPurger, 'Purge partielle ',:AParametrePurge,:AReset);

            if (ADonneesAPurger = '6') then 
              update t_credit set repris = '0' where date_credit < :AParametrePurge;
            else 
              if (ADonneesAPurger = '7') then 
                update t_vignette_avancee set repris = '0' where date_avance < :AParametrePurge;
              else 
                if (ADonneesAPurger = '8') then 
                  update t_facture_attente set repris = '0' where date_acte < :AParametrePurge;
                else
                  if (ADonneesAPurger = '9') then 
                    update t_produit_du set repris = '0' where date_du < :AParametrePurge;    
           end
          else if (AReset = '1') then  -- mode reset
          begin  
          --insert into t_debug values ( :ADonneesAPurger, 'reset partiel',:AParametrePurge,:AReset);

            if (ADonneesAPurger = '6') then update t_credit set repris = '1';
            else 
              if (ADonneesAPurger = '7') then update t_vignette_avancee set repris = '1';
              else 
                if (ADonneesAPurger = '8') then update t_facture_attente set repris = '1';
                else
                  if (ADonneesAPurger = '9') then update t_produit_du set repris = '1';    
          end
       end   
  end
  else -- autres données prat org cli histo
  begin
    -- insert into t_debug values ( :ADonneesAPurger, 'ligne 72',:AParametrePurge,:AReset);

      if (ADonneesAPurger= '0') then 
      begin
        strTable = 't_praticien';
        strTableID = 't_praticien_id';
        strProcedure = 'ps_utl_pha_praticiens';
        strProcedureID = 'APraticienID';
      end
      else if (ADonneesAPurger= '1') then 
        begin
          strTable = 't_organisme';
          strTableID = 't_organisme_id';
          strProcedure = 'ps_utl_pha_organismes_amc';
          strProcedureID = 'AOrganismeAMCID';
        end
        else if (ADonneesAPurger= '2') then 
          begin
            strTable = 't_client';
            strTableID = 't_client_id';
            strProcedure = 'ps_utl_pha_clients';
            strProcedureID = 'AClientID';
          end
          else if (ADonneesAPurger= '3') then 
            begin
              strTable = 't_produit';
              strTableID = 't_produit_id';
              strProcedure = 'ps_utl_pha_produits';
              strProcedureID = 'AProduitID';
            end
            else if (ADonneesAPurger= '4') then 
              begin
                strTable = 't_historique_client';
                strTableID = 't_historique_client_id';
                strProcedure = 'ps_utl_pha_histo_client';
                strProcedureID = 'AHistoriqueClientID';
              end
              else if (ADonneesAPurger= '10') then 
                begin
                  strTable = 't_commande';
                  strTableID = 't_commande_id';
                  strProcedure = 'ps_utl_pha_commandes';
                  strProcedureID = 'ACommandeID';
                end

              -- Lancement de la purge dynamique  
              ADonneesPurges = 0;
              -- mode '1' = RESET
              if (AReset = '1') then
                  for  execute statement 'select ' || strTableID || ' from ' || strTable into :intID do
                    execute statement 'update ' || strTable || ' set repris = ' || '''' || '1' || '''' || ' where ' || strTableID || ' = ' || '''' || replace(intID, '''', '''' || '''') || '''';
                -- mode '0' = mode normal de selection
                else if (AReset = '0') then
                  for execute statement 'select distinct ' || strProcedureID || ' from ' || strProcedure || '(' || '''' || ATypePurge || '''' || ', ' || '''' || AParametrePurge || '''' || ')'
                      into :intID do
                  begin    
                    execute statement 'update ' || strTable || ' set repris = ' || '''' || '0' || '''' || ' where ' || strTableID || ' = ' || '''' || replace(intID, '''', '''' || '''') || '''';
                    ADonneesPurges = ADonneesPurges + 1;
                  end
                  else -- mode '2' = comptage
                    execute statement 'select count(*) from ' || strTable || ' where repris = ' || '''' || '0' || '''' into :ADonneesPurges;

                  -- cas special des organisme ou il faut exclure les AMO  
                  if (ADonneesAPurger= '1') then 
                    execute statement 'select count(*) from ' || strTable || ' where type_organisme = 2 and repris = ' || '''' || '1' || '''' into :ADonneesRestantes;
                  else
                    execute statement 'select count(*) from ' || strTable || ' where repris = ' || '''' || '1' || '''' into :ADonneesRestantes;

              suspend;
  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_utl_pha_exceptions_purge(
  ATypeDonnees char(1),
  AID varchar(50))
as
begin
-- ne concerne que les traitment avec cases a cocher pour exclure des records de la purge
  if (ATypeDonnees= '0') then
    update t_praticien
    set repris = '1'
    where t_praticien_id = :AID;
  else  
    if (ATypeDonnees= '1') then
      update t_organisme
      set repris = '1'
      where t_organisme_id = :AID;
    else
      if (ATypeDonnees = '2') then
        update t_client
        set repris = '1'
        where t_client_id = :AID;
      else
        if (ATypeDonnees = '3') then
          update t_produit
          set repris = '1'
          where t_produit_id = :AID;
end;

/* ********************************************************************************************** */
recreate view v_utl_pha_repartiteur(
  t_repartiteur_id,
  raison_sociale,
  identifiant_171,
  code_postal_ville,
  defaut)
as
select
  t_repartiteur_id,
  raison_sociale,
  identifiant_171,
  case
    when ((code_postal is null) or (code_postal = '')) then nom_ville
    else code_postal || ' ' || nom_ville
  end,
  defaut
from t_repartiteur;

/* ********************************************************************************************** */
create or alter procedure ps_utl_pha_maj_rep_defaut(
  ARepartiteurID varchar(50))
as
begin
   update t_repartiteur
   set defaut = '1'
   where t_repartiteur_id = :ARepartiteurID;
end;

/* ********************************************************************************************** */
recreate view v_utl_pha_ah_cip(
  cip_1,
  type_homeo,
  total)
as
select substring(code_cip from  1 for 1),
       type_homeo,
       count(*)
from t_produit
group by substring(code_cip from  1 for 1), type_homeo;

/* ********************************************************************************************** */
recreate view v_utl_pha_ah_fournisseur_direct(
  t_fournisseur_direct_id,
  raison_sociale,
  type_homeo,
  total)
as
select p.t_codif_6_id,
       c.libelle,
       p.type_homeo,
       count(*)
from t_produit p
     inner join t_codification c on (c.t_codification_id = p.t_codif_6_id)
group by p.t_codif_6_id,
         c.libelle,
         p.type_homeo;

/* ********************************************************************************************** */
create or alter procedure ps_utl_pha_forcer_homeo(
  ATypeHomeo char(1),
  AFournisseurDirectID varchar(50))
as
begin
  update t_produit
  set type_homeo = :ATypeHomeo
  where t_codif_6_id = :AFournisseurDirectID;
end;

/* ********************************************************************************************** */
recreate view v_utl_pha_organisme(
  t_organisme_id,
  type_organisme,
  nom,
  identifiant_national,
  code_postal_ville,
  org_sante_pharma,
  t_destinataire_id)
as
select o.t_organisme_id,
       case
         when o.type_organisme = '1' then 'AMO'
         when o.type_organisme = '2' then 'AMC'
       end,
       o.nom,
       case
         when o.type_organisme = '1' then r.code || o.caisse_gestionnaire || coalesce(o.centre_gestionnaire, '')
         when o.type_organisme = '2' then o.identifiant_national
       end,
       case
         when ((o.code_postal is null) or (o.code_postal = '')) then o.nom_ville
         else o.code_postal || ' ' || o.nom_ville
       end,
       o.org_sante_pharma,
       o.t_destinataire_id
from t_organisme o
     left join t_ref_regime r on (r.t_ref_regime_id = o.t_ref_regime_id)
     left join t_destinataire d on (d.t_destinataire_id = o.t_destinataire_id);
     
/* ********************************************************************************************** */
create or alter procedure ps_utl_pha_maj_organisme(
  AOrganismeID varchar(50),
  ATypeOrganisme char(1),
  ADepartement varchar(2),
  ADestinataireID varchar(50),
  AOrgSantePHARMA char(1))
as
declare variable strSQL varchar(2000);
declare variable strWhere varchar(1000);
begin
  if (AOrganismeID is not null) then
    update t_organisme
    set t_destinataire_id = :ADestinataireID,
        org_sante_pharma = coalesce(:AOrgSantePHARMA, org_sante_pharma)
    where t_organisme_id = :AOrganismeID;
  else
  begin
    strSQL = 'update t_organisme
              set t_destinataire_id = ' || iif(:ADestinataireID is not null, '''' || :ADestinataireID || '''', 'null');

    if (ATypeOrganisme <> 0) then
      strWhere = 'type_organisme = ' || '''' || ATypeOrganisme || '''';
      
    if (ADepartement is not null) then
    begin
      if (strWhere <> '') then
        strWhere = strWhere || ' and ';
      strWhere = strWhere || 'substring(code_postal from 1 for 2) = ' || '''' || ADepartement || '''';
    end
    
    if (strWhere <> '') then
      strSQL = strSQL || ' where ' || strWhere;

    execute statement strSQL;
  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_utl_pha_eclater_org_sp(
  AIDOrganismeSP varchar(50),
  AChampClientIDNat varchar(31))
as
declare variable strSQL varchar(1000);
declare variable strIDClient varchar(50);
declare variable strIDOrg varchar(50);
declare variable strIDNat varchar(16);
declare variable strNom varchar(50);
declare variable strIDCouv varchar(50);
begin
  strSQL = 'select t_client_id, ' || AChampClientIDNat || ' 
            from t_client 
            where t_organisme_amc_id = ' || '''' || AIDOrganismeSP || '''' || '
              and ' || AChampClientIDNat || ' is not null and ' || AChampClientIDNat || ' <> ' || '''' || '''' || ' and char_length(' || AChampClientIDNat || ') = 8'; 
  for execute statement strSQL 
      into :strIDClient, :strIDNat do
  begin
    strIDOrg = 'AMC_SPSANTE_' || strIDNat;
    if (not exists(select *
                   from t_organisme
                   where t_organisme_id = :strIDOrg)) then
    begin
      -- Recherche de l'organisme SP de référence
      select nom
      from t_ref_organisme
      where type_organisme = '2'
        and identifiant_national = :strIDNat
      into :strNom;
      
      if (row_count = 0) then
        strNom = 'Organisme SPSante ' || :strIDNat;
        
      -- Création de l'organisme
      insert into t_organisme(t_organisme_id,
                              type_organisme,
                              nom,
                              identifiant_national)
      values(:strIDOrg,
             '2',
             :strNom,
             :strIDNat);
           
      -- Création des couvertures
      insert into t_couverture_amc(t_organisme_amc_id,
                                   t_couverture_amc_id,
                                   libelle,
                                   montant_franchise,
                                   plafond_prise_en_charge,
                                   formule,
                                   couverture_cmu) 
      select :strIDOrg,
             :strIDOrg || '_' || t_couverture_amc_id,
             libelle,
             montant_franchise,
             plafond_prise_en_charge,
             formule,
             couverture_cmu
      from t_couverture_amc
      where t_organisme_amc_id = :AIDOrganismeSP;
      
      insert into t_taux_prise_en_charge(t_taux_prise_en_charge_id,
                                         t_couverture_amc_id,
                                         t_ref_prestation_id,
                                         taux,
                                         formule)
      select next value for seq_taux_prise_en_charge,       
             :strIDOrg || '_' || t.t_couverture_amc_id,
             t.t_ref_prestation_id,
             t.taux,
             t.formule
      from t_taux_prise_en_charge t
           inner join t_couverture_amc c on (c.t_couverture_amc_id = t.t_couverture_amc_id)
      where c.t_organisme_amc_id = :AIDOrganismeSP;
    end
  
    -- mise à jour des clients
    update t_client
    set t_organisme_amc_id = :strIDorg,
        t_couverture_amc_id = :strIDOrg || '_' || t_couverture_amc_id,
        contrat_sante_pharma = null
    where t_client_id = :strIDClient;
  end
end;

/* ********************************************************************************************** */
recreate view v_utl_pha_destinataire(
  id,
  libelle)
as
select t_destinataire_id,
       nom
from t_destinataire;

/* ********************************************************************************************** */
recreate view v_utl_pha_inventaire(
  taux_tva,
  priorite,
  nb_produits,
  nb_unites,
  total_prix_achat_catalogue,
  total_prix_vente,
  total_pamp)
as
select t.taux,
       pg.t_depot_id,
       count(*),
       sum(pg.quantite),
       sum(pg.quantite * p.prix_achat_catalogue),
       sum(pg.quantite * p.prix_vente),
       sum(pg.quantite * p.pamp)
from t_produit p
     inner join t_ref_tva t on (t.t_ref_tva_id = p.t_ref_tva_id)
     inner join t_produit_geographique pg on (pg.t_produit_id = p.t_produit_id)
where pg.quantite > 0
group by t.taux,
       pg.t_depot_id;
