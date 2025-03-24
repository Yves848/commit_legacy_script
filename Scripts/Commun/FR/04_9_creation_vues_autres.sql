set sql dialect 3;

/* ********************************************************************************************** */
 recreate view v_liste_clients(
   t_client_id,
   numero_insee,
   nom,
   prenom,
   date_derniere_visite,
   t_organisme_amo_id,
   organisme_amo,
   t_couverture_amo_id,
   derniere_date_fin_droit_amo,
   t_organisme_amc_id,
   organisme_amc)
 as
 select
   c.t_client_id,
   c.numero_insee,
   c.nom,
   c.prenom,
   c.date_derniere_visite,
   c.t_organisme_amo_id,
   amo.nom,
   cc.t_couverture_amo_id,
   max(cc.fin_droit_amo),
   c.t_organisme_amc_id,
   amc.nom
 from t_client c
      inner join t_organisme amo on (amo.t_organisme_id = c.t_organisme_amo_id)
      left join t_couverture_amo_client cc on (cc.t_client_id = c.t_client_id)
      left join t_organisme amc on (amc.t_organisme_id = c.t_organisme_amc_id)
 group by c.t_client_id,
  c.numero_insee,
  c.nom,
  c.prenom,
  c.date_derniere_visite,
  c.t_organisme_amo_id,
  amo.nom,
  cc.t_couverture_amo_id,
  c.t_organisme_amc_id,
  amc.nom;


create or alter procedure V_produits_doublons
returns(
t_produit_id dm_code,
designation dm_libelle,
code_cip dm_code_cip,
codes_ean varchar(1000)
)
as
declare variable bDonnees blob sub_type 1;
declare variable debut integer;
declare variable fin integer;
declare variable eans varchar(1000);
begin
for select
      donnees,
      position( '<donnee nom="AIDPRODUIT" valeur="',donnees)+33,  
      position( '"/>',donnees) 
    from T_FCT_ERREUR
    where CODE_ERREUR_SQL = '20202'
  into  :bDonnees,
        :debut,
        :fin
        do
        begin
         t_produit_id = substring( :bDonnees from debut for fin-debut );
           for select designation , 
                      code_cip 
               from t_produit 
               where t_produit_id = :t_produit_id
               into :designation,
                    :code_cip  
           do    
           begin
            codes_ean = '' ;
            for select code_ean13
            from t_code_ean13
            where t_produit_id = :t_produit_id
               into :eans do
               codes_ean =codes_ean || :eans || ' ,';
          suspend;
         end 
        end

end;

create or alter procedure V_clients_doublons
returns(
t_client_id dm_code,
numero_insee varchar(15),
nom varchar(30),
prenom varchar(30)
)
as
declare variable bDonnees blob sub_type 1;
declare variable debut integer;
declare variable fin integer;
begin
for select
      donnees,
      position( '<donnee nom="AIDCLIENT" valeur="',donnees)+33,  
      position( '"/>',donnees) 
    from T_FCT_ERREUR
    where CODE_ERREUR_SQL = '20201'
  into  :bDonnees,
        :debut,
        :fin
        do
        begin
         t_client_id = substring( :bDonnees from debut for fin-debut );
           for select numero_insee, 
                      nom, 
                      prenom 
               from t_client 
               where t_client_id = :t_client_id
               into :numero_insee,
                    :nom,
                    :prenom  
           do    
           begin

           suspend;
         end 
        end

end;