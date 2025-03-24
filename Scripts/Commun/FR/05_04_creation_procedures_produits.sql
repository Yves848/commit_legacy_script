set sql dialect 3;

/* ********************************************************************************************** */
create or alter procedure ps_calculer_remise(
  APrixAchat dm_prix_achat,
  APrixRemise dm_prix_achat)
returns(
  ARemise dm_remise)
as
begin
  if ((APrixRemise > 0) and (APrixAchat > 0) and (APrixRemise<APrixAchat)) then
  begin
    ARemise = 100-((APrixRemise/APrixAchat)*100);

    if (ARemise > 100) then
      ARemise = 100;
    else
      if (ARemise < 0) then
        ARemise = 0;
  end
  else
    ARemise = 0;

	suspend;
end;

create or alter procedure ps_creer_catalogues
as
declare variable strCatalogue dm_code;
declare variable strProduit dm_code;
declare variable strFournisseurDirect dm_code;
declare variable ftPrixAchatCatalogue dm_prix_achat;
declare variable ftPrixAchatRemise dm_prix_achat;
declare variable dtDateReception dm_date;
declare variable dtDateCreation dm_date;
declare variable intNoLigne integer;
declare variable ftRemise dm_remise;
declare variable intColisage dm_numeric5;
begin
  delete from t_catalogue;

  -- Création des catalogues
  insert into t_catalogue(t_catalogue_id,
                          designation,
                          t_fournisseur_id)
  select distinct c.t_fournisseur_direct_id,
         'Catalogue ' || f.raison_sociale,
         c.t_fournisseur_direct_id
  from t_commande c
       inner join t_fournisseur_direct f on (f.t_fournisseur_direct_id = c.t_fournisseur_direct_id)
  where c.t_fournisseur_direct_id is not null
    and c.date_creation >= dateadd(-5 year to current_date);

  -- Creation des lignes de catalogue
  for select t_catalogue_id, t_fournisseur_id
      from t_catalogue
      into :strCatalogue, :strFournisseurDirect do
  begin
    intNoLigne = 1;
    for select max(e.date_creation),
               l.t_produit_id
        from t_commande e
             inner join t_commande_ligne l on (l.t_commande_id = e.t_commande_id)
        where l.quantite_totale_recue <> 0
          and e.t_fournisseur_direct_id = :strFournisseurDirect
          and e.date_creation >= dateadd(-5 year to current_date)
        group by l.t_produit_id
        into :dtDateCreation,
             :strProduit do
    begin
      select first 1 l.prix_achat_tarif, l.prix_achat_remise, l.colisage
      from t_commande_ligne l
           inner join t_commande e on (e.t_commande_id = l.t_commande_id)
      where l.t_produit_id = :strProduit
        and e.t_fournisseur_direct_id = :strFournisseurDirect
        and date_creation = :dtDateCreation
      into :ftPrixAchatCatalogue, :ftPrixAchatRemise, :intColisage;

      execute procedure ps_calculer_remise(:ftPrixAchatCatalogue, :ftPrixAchatRemise) returning_values :ftRemise;

      insert into t_catalogue_ligne(t_catalogue_ligne_id,
                                    t_catalogue_id,
                                    no_ligne,
                                    t_produit_id,
                                    prix_achat_catalogue,
                                    prix_achat_remise,
                                    remise_simple,
                                    date_maj_tarif,
                                    colisage)
      values (next value for seq_catalogue_ligne,
              :strCatalogue,
              :intNoLigne,
              :strProduit,
              :ftPrixAchatCatalogue,
              :ftPrixAchatRemise,
              :ftRemise,
              coalesce(:dtDateReception, :dtDateCreation),
              :intColisage);

      intNoLigne = intNoLigne + 1;
    end
  end
end;

/* ********************************************************************************************** */
create or alter  procedure ps_maj_date_derniere_vente
as
declare variable t_produit_id varchar(50);
declare variable date_derniere_vente date ;
begin
  update t_produit
  set date_derniere_vente = null;

  /* mise a jour de la date de derniere vente issue des historiques de vente mensuels */
  for select t_produit_id, max(cast( substring(periode from 1 for 2)||'-01-'|| substring(periode from 3 for 4) as date ))
      from t_historique_vente
      group by t_produit_id
      into :t_produit_id,
           :date_derniere_vente
  do
  begin
    if ((extract(month from current_date) = extract(month from date_derniere_vente)) and
        (extract(year from current_date) = extract(year from date_derniere_vente))) then
      date_derniere_vente = dateadd((extract(day from current_date) - 1) day to date_derniere_vente);
    else
    begin
      date_derniere_vente = dateadd(1 month to date_derniere_vente);
      date_derniere_vente = dateadd(-1 day to date_derniere_vente);
    end
    update t_produit set date_derniere_vente = :date_derniere_vente
    where t_produit_id = :t_produit_id;
  end
end;

create or alter  procedure ps_maj_date_derniere_vente_2
as
declare variable p integer;
declare variable c varchar(7);
declare variable d date ;
begin
  update t_produit
  set date_derniere_vente = null;

  /* mise a jour de la date de derniere vente issue des historiques de vente mensuels */
  for select p.t_produit_id, 
             max(e.date_acte)
      from t_historique_client_ligne l
           inner join t_historique_client e on (e.t_historique_client_id = l.t_historique_client_id)
           inner join t_produit p on (p.code_cip = l.code_cip)
      group by p.t_produit_id
      into :c,
           :d do
  begin    
    update t_produit 
    set date_derniere_vente = :d
    where t_produit_id = :c;
  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_decaler_historique_vente(
  ADecalage smallint,
  AProduit varchar(50))
as
declare variable strSQL varchar(500);
declare variable strProduit varchar(50);
declare variable intVendues integer;
declare variable intActes integer;
declare variable strPeriode varchar(6);
declare variable strNouvPeriode varchar(6);
declare variable intMois smallint;
declare variable intAnnee smallint;
begin
  if (ADecalage <> 0) then
  begin
    strSQL = 'select *
              from (select t_produit_id,
                           quantite_vendues,
                           quantite_actes,
                           periode,
                           cast(substring(periode from 1 for 2) as smallint) mois,
                           cast(substring(periode from 3 for 4) as smallint) annee
                    from t_historique_vente';
                    
      if (AProduit is not null) then
        strSQL = strSQL || ' where t_produit_id = ' || '''' || AProduit || '''';
      
      strSQL = strSQL || ')';

      if (ADecalage > 0) then
        strSQL = strSQL || ' order by t_produit_id, annee desc, mois desc';
      else
        strSQL = strSQL || ' order by t_produit_id, annee, mois';

      for execute statement strSQL
          into :strProduit, :intVendues, :intActes,
               :strPeriode, :intMois, :intAnnee do
      begin
        intMois = intMois + ADecalage;
        if (intMois = 0) then
        begin
          intMois = 12;
          intAnnee = intAnnee - 1;
        end
        else if (intMois > 12) then
        begin
          intMois = 1;
          intAnnee = intAnnee + 1;
        end
        
        strNouvPeriode = lpad(intMois, 2, '0') || intAnnee;
        update t_historique_vente
        set periode = :strNouvPeriode
        where t_produit_id = :strProduit
          and periode = :strPeriode;
      end       
  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_recreer_histo_vente(
  AFacteurVDL0 smallint,
  AFacteurVDL1 smallint)
as
declare variable p integer;
declare variable l char(1);
declare variable mois integer;
declare variable annee integer;
declare variable v integer;
declare variable q integer;
begin
  delete from t_historique_vente;
  
  for select t_produit_id, 
             liste,
             mois, 
             annee, 
             count(*), 
             sum(quantite_facturee) 
      from (select p.t_produit_id, 
                   p.liste,
                   extract(month from e.date_acte) mois, 
                   extract(year from e.date_acte) annee, 
                   l.quantite_facturee
            from t_historique_client_ligne l           
                 inner join t_historique_client e on (e.t_historique_client_id = l.t_historique_client_id)
                 inner join t_produit p on (p.code_cip = l.code_cip))
      group by t_produit_id, liste, mois, annee
      into :p, :l, :mois, :annee, :v, :q do
    begin
      if (l = '0') then
      begin
        v = v * AFacteurVDL0;
        q = q * AFacteurVDL0;
      end
      else
        if (l = '1') then
        begin
          v = v * AFacteurVDL1;
          q = q * AFacteurVDL1;        
        end
        
      insert into t_historique_vente(t_historique_vente_id,
                                     t_produit_id,
                                     periode,
                                     quantite_actes,
                                     quantite_vendues)
      values(next value for seq_historique_vente,
             :p,
             lpad(:mois, 2, '0') || :annee,
             :v,
             :q);
    end
end;

/* ********************************************************************************************** */

create sequence seq_cip13 ;
alter sequence seq_cip13  restart with 0;


create table t_cip13_generes(
cip7 char(7),
cip13 varchar(13)
);



create or alter procedure ps_generer_cip13
( no_check integer 
) 
returns(
  ACode_cip13 varchar(13))
as
declare variable cip12 varchar(12);
declare variable cle integer;
declare variable pair integer;
declare variable impair integer;
declare variable i integer;
begin
                                              
  cip12 = '20000' || lpad(next value for seq_cip13 ,7,'0' );

  if (no_check = 0) then 
        while ( (exists(select * from t_produit where substring(code_cip from 1 for 12)= :cip12 )) )
        do
        begin
          cip12 = '20000' || lpad(next value for seq_cip13 ,7,'0' );
        end
        
        i =1;  pair = 0; impair = 0;

  while ( i <= 12 ) do
  begin
    pair = pair + cast(substring(cip12 from i+1 for 1) as integer );
    impair = impair + cast(substring(cip12 from i for 1) as integer );

    i = i+2; 
  end

  pair = pair*3;
  impair = impair + pair;
  cle = 9-mod(impair-1,10);

  ACode_cip13 = cip12||cle ;  
     suspend;

end;
