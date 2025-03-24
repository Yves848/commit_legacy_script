create or replace package body migration.pk_programmes_fidelites as

 	/* ********************************************************************************************** */
  function creer_prog_avantage(AIDprogrammeavantage in varchar2,
                                ATypeCarte in integer,
                                ACodeExterne in varchar2,
                                ALibelle in varchar2,
                                ANbMoisValidite in integer,
                                ADateFinValidite in date,
                                ADesactivee in char,
                                ATypeObjectif in integer,
                                AValeurObjectif in integer,
                                AValeurPoint in integer,
                                ANbpointTranche in integer,
                                AValeurTranche in integer,
                                AValeurArrondi in integer,
                                ATypeAvantage in integer,
                                AModeCalculAvantage in integer,
                                AValeurAvantage in integer,
                                AValeurEcart in integer,
                                ADiffAssure in char,
                                AValeurCarte in integer )
                               return integer
	 as
		  intIDProgAvantage integer;
		  intCalculVisite integer;
  begin
    savepoint sp_prog_avantage;

    if ATypeObjectif = 3 then 
     intCalculVisite := 1 ;
    else 
     intCalculVisite := null;	
    end if;
  			 
    insert into erp.t_cartefi(t_cartefi_id, type_cartefi, code_ext, libelle, nbmois_validite,
                              date_fin_validite, desactivee, type_objectif, valeur_objectif, valeur_point,
                              nb_point_tranche, valeur_tranche, valeur_arrondi, type_avantage, 
                              mode_calcul_avantage, valeur_avantage, valeur_ecart, diff_assure,  
                              date_maj, avec_numero, facturable, valeur_carte, remboursable, 
                              edition_ticket, edition_histo_achat, produit_promo, type_calcul_visite)
    values(erp.seq_id_cartefi.nextval, ATypeCarte, ACodeExterne, ALibelle, ANbMoisValidite, 
          ADateFinValidite, ADesactivee, ATypeObjectif, AValeurObjectif, AValeurPoint,
          ANbpointTranche, AValeurTranche, AValeurArrondi, ATypeAvantage,
          AModeCalculAvantage, nvl(AValeurAvantage,1), AValeurEcart, ADiffAssure, 
          sysdate, 0, 0, AValeurCarte, 0,
          0, 0, 0, intCalculVisite)
    returning t_cartefi_id into intIDProgAvantage;
      
    return intIDProgAvantage;
  exception
    when others then
      rollback to sp_prog_avantage;
      raise;
  end;


 	/* ********************************************************************************************** */
 	procedure creer_prog_avantage_client(AIDprogrammeavantage in varchar2,
                                        AIDClient in varchar2,
                                        ANumeroCarte in varchar2,
                                        AStatut in integer,
                                        ADateCreation in date,
                                        ADateCreationInitiale in date,
                                        ADateFinValidite in date,
                                        AEncoursInitial in integer,
                                        AEncoursCA in integer,
                                        AOperateur in varchar2)
  as 
    lClient erp.t_assureayantdroit%rowtype;
    lIntLigneVente integer;   
    intIDProgAvantageCli integer; 
    recFacture pk_encours.rec_facture;    
    typeobj integer;
    fEncoursInitial float;
    fEncoursCA float;
    nbBoite integer; 
    nbPassage integer;
  begin
    savepoint sp_prog_avantage_clients;

    select type_objectif  into typeobj from erp.t_cartefi where t_cartefi_id = AIDprogrammeavantage ; 

    case typeobj 
      when 1 then if(AEncoursInitial > 0) then fEncoursInitial:=AEncoursInitial; else fEncoursInitial:= AEncoursCA; end if;
                  fEncoursCA:=0;
                  nbBoite:=1;
                  nbPassage:=1;
      when 2 then fEncoursInitial:=0; 
                  fEncoursCA:=AEncoursCA;
                  nbBoite:=AEncoursInitial;
                  nbPassage:=1;
      when 3 then fEncoursInitial:=0; 
                  fEncoursCA:=AEncoursCA;
                  nbBoite:=AEncoursInitial; -- on met nbboite = nbpassage pour diviser le prix total du CA par le nb de passage/boite 
                  nbPassage:=AEncoursInitial;
      when 4 then if(AEncoursInitial > 0) then fEncoursInitial:=AEncoursInitial; else fEncoursInitial:= AEncoursCA; end if;
                  fEncoursCA:=0;
                  nbBoite:=1;
                  nbPassage:=1;
    end case;

    --programme avantage
    insert into erp.t_cartefi_client(t_cartefi_client_id,  t_cartefi_id, t_aad_id,
                                    numero_carte, statut, date_creation,
                                    date_creation_initiale, date_fin_validite, encours_initial,
                                    t_operateur_id)
    values(erp.seq_id_cartefi_client.nextval, AIDprogrammeavantage, AIDClient,
          ANumeroCarte, AStatut, ADateCreation,
          ADateCreationInitiale, ADateFinValidite, fEncoursInitial,
          nvl(AOperateur, pk_commun.IDOperateurPoint))
    returning t_cartefi_client_id into intIDProgAvantageCli; 
          
    if (fEncoursCA > 0) then
      for i in 1..nbPassage 
      loop
      -- on soustrait un jour a la date de création sinon l'acte pourrait etre comptabilise comme un passage 
        recFacture := pk_encours.creer_facture(ADateCreation-1, AIDClient, fEncoursCA);
          insert into erp.t_lignevente(t_lignevente_id, qtefacturee,
                                    liste, complementprestation,
                                    qualificatifdepense, noordonnancier, designation, motifsubstitution,
                                    qtedelivree, qtemanquante, datemajlignevente, t_facture_id,
                                    --t_produit_id, 
                                    t_prestation_id, t_tva_id, typefacturation, remise,
                                    coefficient, prixvente, baseremboursement, tauxamo,
                                    codeaccordep, rembamo, rembamc, rembamotransmis,
                                    rembamctransmis, tauxamc, paht_prescrit, baseremboursement_prescrit,
                                    pvttc_prescrit, paht_brut, codetaux, tauxtva,
                                    codeprestation, suivi_interessement, veterinaire,
                                    delailait, delaiviande, pvttc_fichier, paht_remise,
                                    pamp, codelabotaux, codelabotaux_prescrit, pvht,
                                    pvhtremise, pvttc_boite, montant_net_ttc)
        values(erp.seq_id_lignevente.nextval, case typeobj when 2 then nbBoite else 1 end,
              0, 0,
              0, 0, 'Produit reprise des encours de programme avantage', 0,
              1, 0, sysdate, recFacture.t_facture_id,
              --null, 
              pk_commun.IDPrestationPHN, pk_commun.IDTVA0, '3', 0,
              1, round(fEncoursCA / nbBoite, 2), 0, 0, 
              '9', /*Acte non-soumis à accord*/ 0, 0, 0, 
              0, 0, 0, 0,
              0, 0, '0', 0,
              'PHN', '0', '0',
              0, 0, 0, 0,
              0, '0', '0', round(fEncoursCA / nbBoite, 2),
              round(fEncoursCA / nbBoite, 2), round(fEncoursCA / nbBoite, 2), fEncoursCA/nbpassage)
        returning t_lignevente_id into lIntLigneVente;

        -- Création de la ligne de vente_fidelite
        insert into erp.t_lignevente_fidelite(t_lignevente_fidelite_id,
                                                        t_cartefi_client_id,
                                                        nb_points_suppl,
                                                        qtefidelite,
                                                        t_lignevente_id)
        values(erp.seq_id_lignevente_fidelite.nextval,	
                  intIDProgAvantageCli,
                  '0',
                  case typeobj 
                    when 2 then nbBoite
                    else 1
                  end, -- cas type 2 : nbboite/1  , cas type 3 : 1 
                  lIntLigneVente);
      end loop;
    end if;  
  exception
    when others then
      rollback to sp_prog_avantage_clients;
      raise;
  end;

 	/* ********************************************************************************************** */
  function creer_prog_avantage_produit(AIDprogrammeavantage in varchar2,
                                        AIDProduit in varchar2,
                                        AGain in char,
                                        AOffert in char,
                                        ANbPointSupp in integer)
                                       return integer as
		intIDProgAvantageProduit integer;							   
  begin
    savepoint sp_prog_avantage_produits;

    insert into erp.t_cartefi_produit(t_cartefi_id,
                                      t_produit_id,
                                      gain,
                                      offert,
                                      nb_points_suppl)
    values(AIDprogrammeavantage,
           AIDProduit,
           AGain,
           AOffert,
           ANbPointSupp);

    return intIDProgAvantageProduit;
  exception
    when others then
      rollback to sp_prog_avantage_produits;
      raise;
  end;

  /* ********************************************************************************************** */
  procedure creer_carte_prog_rel(AIDcarteprogrel in integer,
                                AIDclient in varchar2,
                                Anumerocarte in varchar2,
                                AIDpfi_lgpi in integer)
  as
  begin
    savepoint sp_carte_programme_relationnel;

    insert into erp.t_aad_pfi(t_aad_pfi_id,
                                      t_aad_id,
                                      numerocarte,
                                      t_pfi_id)
    values(erp.seq_aad_pfi.nextval,
           AIDclient,
           Anumerocarte,
           decode(AIDpfi_lgpi, 0, pk_commun.Options.progr_relationnel_id, AIDpfi_lgpi));

  exception
    when others then
      rollback to sp_carte_programme_relationnel;
      raise;
  end;

end;
/