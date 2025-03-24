create or replace package body migration.pk_organismes as
  
  type rec_regime is record(
    id integer,
    sans_centre_gestionnaire char(1));
  
  type tab_regimes is table
    of rec_regime index by varchar(2);
    
  type rec_pec_amc is record(
    taux numeric(3),
    formule varchar(3));
    
  C_ORGANISME_AMO constant integer := 1;
  C_ORGANISME_AMC constant integer := 2;
    
  Regimes tab_regimes;  
  OrganismesAMCRef pk_commun.tab_identifiants;
  OrganismesAMCUnq pk_commun.tab_identifiants;
  CouvertureAMCRef pk_commun.tab_identifiants;
  FormulesSTS pk_commun.tab_identifiants;
  
  /* ********************************************************************************************** */
  function creer_destinataire(AIDDestinataireLGPI in integer,
                              ANumIdent in varchar2,
                              --ANomUtil in varchar2, -- disparu en 2.0
                              --AMotPasse in varchar2, -- disparu en 2.0
                              AServSmtp in varchar2,
                              AServPop3 in varchar2,
                              AServDNS in varchar2,
                              AUtilisateurPop3 in varchar2,
                              AMotPassePop3 in varchar2,
                              AAdresseBAL in varchar2,
                              ANoAppel in varchar2,
                              ATempo in number,
                              AEmailOCT in varchar2,
                              ANom in varchar2,
                              ARue1 in varchar2,
                              ARue2 in varchar2,
                              ACodePostal in varchar2,
                              ANomVille in varchar2,
                              ATelPersonnel in varchar2,
                              ATelStandard in varchar2,
                              ATelMobile in varchar2,
                              AFax in varchar2,
                              AApplicationOCT in varchar2,
                              ANumDestOCT in varchar2,
                              ANorme in varchar2,
                              ANormeRetour in varchar2,
                              --ANomFicAller in varchar2, -- disparu en 2.0
                              --ANomFicRetour in varchar2, -- disparu en 2.0
                              ACommentaire in varchar2,
                              AFlux in varchar2,
                              AZoneMessage in varchar2,
                              AOCT in varchar2,
                              AAuthentification in char,
                              ATyp in varchar2,
                              ARefuseHTP in char,
                              AGestionNumLots in char,
                              AXSL in varchar2)
                             return integer
  as                           
    intIDDestinataire integer;
    intIDAdresse integer;
  begin
    savepoint ps_destinataire;
    
    intIDAdresse := pk_commun.creer_adresse(ARue1,ARue2, ACodePostal, ANomVille, ATelPersonnel, ATelStandard, ATelMobile, AFax, null);                                               
    insert into erp.t_destinataire(t_destinataire_id,
                                   num_ident,
                                   serv_smtp,
                                   serv_pop3,
                                   mot_passe_pop3,
                                   adresse_bal,
                                   no_appel,
                                   email_oct,
                                   nom,
                                   adresseid,
                                   date_modif,
                                   application_oct,
                                   num_dest_oct,
                                   norme,
                                   commentaire,
                                   numagrement,
                                   norme_retour,
                                   --flux, --disparu en 2.12.xxxxx
                                   zone_message,
                                   utilisateur_pop3,
                                   oct,
                                   authentification,
                                   typ,
                                   type_norme_aller,
                                   refuse_htp,
                                   gestion_num_lots,
                                   xsl,
                                   gestion_bordereau,
                                   tempo,
                                   autoedit,
                                   ar_oct,
                                   bordereau_amo,
                                   bordereau_amc,
                                   bordereau_fse,
                                   rsp_det,
                                   arl,
                                   liste_rejet,
                                   liste_fact_rejet,
                                   recap_totaux,
                                   saut_aroct,
                                   saut_bordamo,
                                   saut_bordamc,
                                   saut_rspdet,
                                   nb_oct,
                                   nb_amo,
                                   nb_amc,
                                   nb_fse,
                                   nb_rspdet,
                                   nb_arl,
                                   nb_factrejet,
                                   nb_rejet,
                                   nb_recap,
                                   tri,
                                   rupture)
    values(erp.seq_destinataire.nextval,
           ANumIdent,
           AServSmtp,
           AServPop3,
           AMotpassePop3,
           AAdresseBAL,
           ANoAppel,
           AEmailOCT,
           ANom,
           intIDAdresse,
           sysdate,
           AApplicationOCT,
           ANumDestOCT,
           ANorme,
           ACommentaire,
           null,
           ANormeRetour,
           --AFlux,
           AZoneMessage,
           AUtilisateurPop3,
           AOCT,
           AAuthentification,
           ATyp,
           3,
           ARefuseHTP,
           AGestionNumLots,
           AXSL,
           '0',
           ATempo,
           '0',
           '0',
           '0',
           '0',
           '0',
           '0',
           '0',
           '0',
           '0',
           '0',
           '0',
           '0',
           '0',
           '0',
           '0',
           '0',
           '0',
           '0',
           '0',
           '0',
           '0',
           '0',
           '0',
           null,
           null)
    returning t_destinataire_id into intIDDestinataire;

    insert into erp.t_sv_numlot(t_destinataire_id,
                                numlotfse)
    values(intIDDestinataire,
           0);
           
    return intIDDestinataire;
  exception
    when others then      
      rollback to ps_destinataire;
      raise;
  end;
  
  /* ********************************************************************************************** */
  function creer_organisme(AIDOrganismeAMCLGPI in integer,
                           ATypeOrganisme in char,
                           ANomReduit in varchar2,
                           ACommentaire in varchar2,
                           ACommentaireBloquant in varchar2,
                           ARue1 in varchar2,
                           ARue2 in varchar2,
                           ACodePostal in char,
                           ANomVille in varchar2,
                           ATelPersonnel in varchar2,
                           ATelStandard in varchar2,
                           ATelMobile in varchar2,
                           AFax in varchar2,
                           AOrgReference in char,
                           AMtSeuilTiersPayant in number,
                           AAccordTiersPayant char,
                           AIDDestinataire in varchar2,
                           ADocFacturation in number,
                           ATypeReleve in varchar2,
                           AEditionReleve in char,
                           AFrequenceReleve in number,
                           AMtSeuilEdReleve in number,
                           ARegime in varchar2,
                           ACaisseGestionnaire in varchar2,
                           ACentreGestionnaire in varchar2,
                           AFinDroitsOrgAMC in char,
                           --ATopR in char, -- disparu 2.0
                           AOrgCirconscription in char,
                           AOrgConventionne in char,
                           ANom in varchar2,
                           --AOrgSantePharma in char, -- disparu 2.0
                           AIdentifiantNational in varchar2,
                           APriseEnChargeAME in char,
                           AApplicationMtMiniPC in char,
                           ATypeContrat in number,
                           ASaisieNoAdherent in char,
                           AFusion in char)
                          return integer
  as
    intIDOrganisme integer;
    intIDOrganismeUnique integer;
    intIDAdresse integer;
    intIDAdresseLGPI integer;
    recRegime rec_regime;
    intIDOrganismePayeur integer;
    intIDDestinataireFusion integer;
    
    function creer_organisme_payeur return integer
    as
      intIDAdresse integer;
    begin
      intIDAdresse := pk_commun.creer_adresse(ARue1, ARue2, ACodePostal, ANomVille, ATelPersonnel, ATelStandard, ATelMobile, AFax, null); 
      insert into erp.t_organismepayeur(t_organismepayeur_id,
                                        datemaj,
                                        libelle,
                                        code,
                                        t_adresse_id)
      values(erp.seq_id_organismepayeur.nextval,
             sysdate,
             ANom,
             substr(ANom, 1, 8),
             intIDAdresse)
      returning t_organismepayeur_id into intIDOrganismePayeur;
      
      return intIDOrganismePayeur;
    end;
    
  begin
    savepoint ps_organismes;
    
    intIDAdresse := pk_commun.creer_adresse(ARue1, ARue2, ACodePostal, ANomVille, ATelPersonnel, ATelStandard, ATelMobile, AFax, null); 
    if ATypeOrganisme = C_ORGANISME_AMO then
      -- Recherche de l'organisme
      begin
        recRegime := Regimes(nvl(ARegime, '01'));
        begin
          if (recRegime.sans_centre_gestionnaire  = '1') then
            select t_organismeamo_id
            into intIDOrganisme
            from erp.t_organismeamo
            where t_regime_id = recRegime.id
              and caissegestionnaire = ACaisseGestionnaire
              and centregestionnaire is null;
          else
            select t_organismeamo_id
            into intIDOrganisme
            from erp.t_organismeamo
            where t_regime_id = recRegime.id
              and caissegestionnaire = ACaisseGestionnaire
              and centregestionnaire = ACentreGestionnaire;
          end if;
        exception
          when no_data_found then
            intIDOrganisme := null;
        end;
      exception
        when no_data_found then
          intIDOrganisme := null;      
      end;
      
      if intIDOrganisme is null then
        intIDOrganismePayeur := creer_organisme_payeur;
        insert into erp.t_organismeamo(t_organismeamo_id,
                                       caissegestionnaire,
                                       centregestionnaire,
                                       nom,
                                       commentaire,
                                       commentairebloquant,
                                       orgreference,
                                       mtseuiltierspayant,
                                       accordtierspayant,
                                       datemajorganisme,
                                       nomreduit,
                                       t_regime_id,
                                       t_adresse_id,
                                       t_destinataire_id,
                                       organismedestinataire,
                                       centreinfo,
                                       findroitsorgamc,
                                       orgcirconscription,
                                       orgconventionne,
                                       applicationmtminipc,
                                       docfacturation,
                                       typereleve,
                                       t_organismepayeur_id,
                                       editionrreleve,
                                       frequencereleve,
                                       mtseuiledreleve,
                                       controle_insee)
        values(erp.seq_organisme.nextval,
               ACaisseGestionnaire,
               ACentreGestionnaire,
               ANom,
               ACommentaire,
               ACommentairebloquant,
               '0',
               '1' ,  --AMtSeuilTiersPayant = flux maintenu ... : forcé à 1 sinon pas de TP !!!,
               AAccordTiersPayant,
               sysdate,
               ANomReduit,
               recRegime.id,
               intIDAdresse,
               AIDDestinataire,
               null,
               null,
               AFinDroitsOrgAMC,
               AOrgCirconscription,
               decode(AOrgConventionne, null, decode(AIDDestinataire, null, '0', '1'), '0'),
               AApplicationMtMiniPC,
               ADocFacturation,
               '5',
               intIDOrganismePayeur,
               '1',
               AFrequenceReleve,
               AMtSeuilEdReleve,
               '0')
        returning t_organismeamo_id into intIDOrganisme;      
      elsif AFusion = '0' then
        select t_adresse_id
        into intIDAdresseLGPI
        from erp.t_organismeamo
        where t_organismeamo_id = intIDOrganisme;
        
        update erp.t_organismeamo
        set nomreduit = ANomReduit,
            orgconventionne = decode(AOrgConventionne, null, decode(AIDDestinataire, null, '0', '1'), AOrgConventionne),
            orgcirconscription = AOrgCirconscription,
            commentaire = ACommentaire,
            commentairebloquant = ACommentaireBloquant,
            datemajorganisme = sysdate,
            t_adresse_id = intIDAdresse,
            t_destinataire_id = decode(AFusion, '1', t_destinataire_id, AIDDestinataire),
            editionrreleve = '1',
            typereleve = '5'
        where t_organismeamo_id = intIDOrganisme;
        
        delete from erp.t_adresse where t_adresse_id = intIDAdresseLGPI;
      end if;
    elsif ATypeOrganisme = C_ORGANISME_AMC then      
      -- Gestion des organismes CMU / AME / ACS
      begin
         intIDOrganisme := OrganismesAMCRef(AIdentifiantNational);
      exception
        when no_data_found or value_error then
          intIDOrganisme := null;
      end;
      
      begin
         intIDOrganismeUnique := OrganismesAMCUnq(AIdentifiantNational);
      exception
        when no_data_found or value_error then
          intIDOrganismeUnique := null;
      end;


      if (intIDOrganismeUnique is null) and (intIDOrganisme is null) and (AIDOrganismeAMCLGPI is null) then
        intIDOrganismePayeur := creer_organisme_payeur;

         if ( AFusion = '1' ) then
            select t_destinataire_id 
            into intIDDestinataireFusion
            from (select t_destinataire_id 
                  from erp.t_organismeamc 
                  group by t_destinataire_id
                  order by count(*) desc)
            where rownum = 1;
          end if;  

        insert into erp.t_organismeamc(t_organismeamc_id,
                                       nom,
                                       commentaire,
                                       commentairebloquant,
                                       orgreference,
                                       mtseuiltierspayant,
                                       accordtierspayant,
                                       datemajorganisme,
                                       nomreduit,
                                       identifiantnational,
                                       t_adresse_id,
                                       t_destinataire_id,
                                       priseenchargeame,
                                       typecontrat,
                                       saisienoadherent,
                                       applicationmtminipc,
                                       docfacturation,
                                       typereleve,
                                       t_organismepayeur_id,
                                       editionrreleve,
                                       mtseuiledreleve,
                                       specifmut)
        values(erp.seq_organisme.nextval,
               ANom,
               ACommentaire,
               ACommentairebloquant,
               AOrgReference,
               AMtSeuilTiersPayant,
               '1', --AAccordTiersPayant,
               sysdate,
               ANomReduit,
               AIdentifiantNational,
               intIDAdresse,
               nvl(intIDDestinataireFusion,AIDDestinataire),
               APriseEnChargeAME,
               ATypeContrat,
               ASaisieNoAdherent,
               AApplicationMtMiniPC,
               ADocFacturation,
               '5',
               intIDOrganismePayeur,
               '1',
               AMtSeuilEdReleve,
               0)
        returning t_organismeamc_id into intIDOrganisme;
      
        insert into erp.t_bordereau_nbex_per_org(t_bordereau_nbex_per_org_id,
                                                 t_organisme_id)
        values(erp.seq_bordereau_nbex.nextval,
               intIDOrganisme);
      else      
        intIDOrganisme := nvl(intIDOrganisme,nvl( AIDOrganismeAMCLGPI, intIDOrganismeUnique));
      
        if AFusion = '0' then
          select t_adresse_id
          into intIDAdresseLGPI
          from erp.t_organismeamc
          where t_organismeamc_id = intIDOrganisme;
          
          update erp.t_organismeamc
          set nomreduit = ANomReduit,
              commentaire = ACommentaire,
              commentairebloquant = ACommentaireBloquant,
              datemajorganisme = sysdate,
              t_adresse_id = intIDAdresse,
              t_destinataire_id = AIDDestinataire,
              editionrreleve = '1',
              identifiantnational = AIdentifiantNational,
              mtseuiltierspayant = AMtSeuilTiersPayant,
              accordtierspayant = AAccordTiersPayant,
              saisienoadherent = ASaisieNoAdherent,
              typecontrat = ATypeContrat,
              applicationmtminipc = AApplicationMtMiniPC,
              mtseuiledreleve = AMtSeuilEdReleve,
              docfacturation = ADocFacturation
          where t_organismeamc_id = intIDOrganisme;
          
          delete from erp.t_adresse where t_adresse_id = intIDAdresseLGPI;
        end if;
      end if;      
    end if;
    
    return intIDOrganisme;
  exception
    when others then
      rollback to ps_organismes;    
      raise;
  end;  
  
  /* ********************************************************************************************** */
  function creer_couverture_amc(AIDCouvertureAMCLGPI in integer,
                                AIDOrganismeAMC in integer,
                                ALibelle in varchar2,
                                AMontantFranchise in number,
                                APlafondPriseEnCharge in number,
                                ACouvertureCMU in char)
                               return integer
  as
    intIDCouvertureAMC integer;
    boolOrgRefTrouve boolean;
  begin
    savepoint ps_couvertures_amc;
    
    if AIDCouvertureAMCLGPI is null then
      begin
        intIDCouvertureAMC := CouvertureAMCRef(AIDOrganismeAMC);
      exception
        when no_data_found then
          intIDCouvertureAMC := null;
      end;
              
      if intIDCouvertureAMC is null then
        -- Creation de la couverture
        insert into erp.t_couvertureamc(t_couvertureamc_id,
                                          libelle,
                                          montantfranchise,
                                          plafondpriseencharge,
                                          datemajcouvamc,
                                          couvreference,
                                          couvcmu)
        values(erp.seq_couvertureamc.nextval,
                 substr(ALibelle,1,60),
                 AMontantFranchise,
                 APlafondPriseEnCharge,
                 sysdate,
                 '0',
                 ACouvertureCMU)
        returning t_couvertureamc_id into intIDCouvertureAMC;

        -- Association avec l'organisme AMC
        insert into erp.t_24(t_organismeamc_id,
                                          t_couvertureamc_id)
        values(AIDOrganismeAMC,
                     intIDCouvertureAMC);    
      end if;
    else
      intIDCouvertureAMC := AIDCouvertureAMCLGPI;
      
      update erp.t_couvertureamc
      set libelle = ALibelle,
          montantfranchise = AMontantFranchise,
          plafondpriseencharge = APlafondPriseEnCharge,
          couvcmu = ACouvertureCMU
      where t_couvertureamc_id = intIDCouvertureAMC;
      
      delete from erp.t_pec_amc
      where t_couverture_amc_id = intIDCouvertureAMC;
    end if;     
    
    return intIDCouvertureAMC;
  exception
    when others then
      rollback to ps_couvertures_amc;
      raise;
  end;
  
  /* ********************************************************************************************** */
  procedure creer_taux_prise_en_charge(AIDCouvertureAMC in integer,
                                       APrestation in varchar2,
                                       ATaux in number,
                                       AFormule in varchar2)
  as
    i integer;
    intIDFormule integer;
    intIDPecAmc integer;
    intNoParametreFormule integer;
  datePecAmcPH1 date;
    recPrestation pk_commun.rec_prestation;
  begin
    savepoint ps_taux_prise_en_charge;

    select count(*)
    into i
    from erp.t_24 t   
         inner join erp.t_organismeamc c on (c.t_organismeamc_id = t.t_organismeamc_id)
    where c.orgreference = '1'
      and t.t_couvertureamc_id = AIDCouvertureAMC;
  
    if i = 0 then
      recPrestation := pk_commun.Prestations(APrestation);
    
      begin
        intIDFormule := FormulesSTS(AFormule);
      exception
        when no_data_found then
          intIDFormule := FormulesSTS('021');
      end;
    
      begin 
       select date_application 
       into datePecAmcPH1
       from erp.t_pec_amc 
       where t_couverture_amc_id = AIDCouvertureAMC 
         and t_prestation_id = ( select t_prestation_id from erp.t_prestation where code = 'PH1');
      exception
        when no_data_found then datePecAmcPH1 := null;
      end;
   
   
      insert into erp.t_pec_amc(t_pec_amc_id,
                                date_application,
                                datemajpecamc,
                                t_couverture_amc_id,
                                t_prestation_id,
                                t_formule_id)
      values(erp.seq_id_pec_amc.nextval,
             decode(datePecAmcPH1, null, trunc(sysdate, 'DD'),datePecAmcPH1),
             sysdate,
             AIDCouvertureAMC,
             recPrestation.id,
             intIDFormule) 
      returning t_pec_amc_id into intIDPecAmc;
      
     select no_parametre_formule
     into intNoParametreFormule
     from erp.t_formule_sts_parametre
     where t_formule_sts_id = intIDFormule; 
     
     insert into erp.t_pec_amc_formule_parametre(t_pec_amc_formule_parametre_id,
                no_parametre_formule,
                valeur,
                t_pec_amc_id,
                datemajpecamcformuleparametre)
     values(erp.SEQ_ID_PEC_AMC_FORMULE_PARAMET.nextval,                       
            intNoParametreFormule,
            ATaux,
            intIDPecAmc,
            sysdate);                   
     end if;
  exception
    when others then
       rollback to ps_taux_prise_en_charge;      
      raise;
  end;

  /* ********************************************************************************************** */
  procedure ajuster_couvertures_amc
  as
   recTauxVigBleue rec_pec_amc;
   recTauxVigBlanche rec_pec_amc;
   recTauxVig100 rec_pec_amc;
   recTauxVigNR rec_pec_amc;
   recTauxVigOr rec_pec_amc;
   recTauxVigLPP rec_pec_amc;
   recTauxVigVGP rec_pec_amc;
   recTaux rec_pec_amc;

   intIDCouvertureAMORef integer;
   intIDCouvertureAMC integer;
   intIDPEC integer;
  
     function renvoyer_taux_amo(ATaux in varchar2, AIDCouvertureAMO in integer) return integer
     as
       intTaux integer;
     begin
       select tauxpc.tauxpriseencharge
       into intTaux
       from erp.t_tauxpriseencharge tauxpc,
            erp.t_prestation prest
       where tauxpc.t_prestation_id = prest.t_prestation_id
         and tauxpc.t_couvertureamo_id = AIDCouvertureAMO
         and prest.code = ATaux;
     
       return intTaux;
     end;
     
     function renvoyer_taux_amc(ATaux in varchar2,
                                AIDCouvertureAMC in integer,
                                ATauxDefaut in integer,
                                AFormuleDefaut in varchar)
                               return rec_pec_amc
     as
       recTaux rec_pec_amc;
     begin
       begin
         select taux.valeur, sts.no_formule
         into recTaux
         from erp.t_prestation prest
              inner join erp.t_pec_amc pc on (pc.t_prestation_id = prest.t_prestation_id)
              inner join erp.t_formule_sts sts on (sts.t_formule_sts_id = pc.t_formule_id)
              inner join erp.t_pec_amc_formule_parametre taux on (taux.t_pec_amc_id = pc.t_pec_amc_id)
         where pc.t_couverture_amc_id = AIDCouvertureAMC
           and prest.code = ATaux;
       exception
         when no_data_found then
           creer_taux_prise_en_charge(AIDCouvertureAMC, ATaux, ATauxDefaut, AFormuleDefaut);
           recTaux.taux := ATauxDefaut;
           recTaux.formule := AFormuleDefaut;
       end;

       return recTaux;
     end;
    
  begin
    -- Ajustement des couvertures AMC ou ils manquent des taux
    -- liste des couvertures incompletes
	   for c_couv_amc in (select t.t_couvertureamc_id, count(*)
						 from erp.t_24 t
							  inner join erp.t_pec_amc pc on (pc.t_couverture_amc_id = t.t_couvertureamc_id)
							  inner join erp.t_organismeamc o on (o.t_organismeamc_id = t.t_organismeamc_id)
						 where o.orgreference = '0'
						 group by t.t_couvertureamc_id
						 having count(*) < (select count(*) from erp.t_prestation)) loop
		savepoint ps_ajustement_couv_amc;

		begin              
		  recTauxVigOr  := renvoyer_taux_amc('PH2', c_couv_amc.t_couvertureamc_id, 15, '02A');
		  recTauxVigBleue := renvoyer_taux_amc('PH4', c_couv_amc.t_couvertureamc_id, 100, '02A');
		  recTauxVigBlanche := renvoyer_taux_amc('PH7', c_couv_amc.t_couvertureamc_id, 100, '02A');
		  recTauxVig100 := renvoyer_taux_amc('PH1', c_couv_amc.t_couvertureamc_id, 100, '02A');
		  recTauxVigNR := renvoyer_taux_amc('PHN', c_couv_amc.t_couvertureamc_id, 0, '02A');
		  recTauxVigLPP := renvoyer_taux_amc('AAD', c_couv_amc.t_couvertureamc_id, 0, '02A');
      recTauxVigVGP := renvoyer_taux_amc('VGP', c_couv_amc.t_couvertureamc_id, recTauxVigBlanche.taux, '02A');
		  -- Modification de la dfinition de la couverture en cours
		  -- pour chaque couverture on liste tous les taux
		  for c_prestation in (select t_prestation_id, code, codetaux , estlpp
							   from erp.t_prestation
							   where code not in ('PH2', 'PH4', 'PH7', 'PH1', 'PHN', 'AAD', 'PMR', 'VGP')) loop
			begin
			 
			  select pec.t_pec_amc_id
			  into intIDPEC
			  from erp.t_pec_amc pec
				   inner join erp.t_formule_sts sts on (sts.t_formule_sts_id = pec.t_formule_id)
			  where t_couverture_amc_id = c_couv_amc.t_couvertureamc_id
				and t_prestation_id = c_prestation.t_prestation_id;
		
			  delete from erp.t_pec_amc_formule_parametre where t_pec_amc_id = intIDPEC;
			  delete from erp.t_pec_amc where t_pec_amc_id = intIDPEC;        
			exception
			  when no_data_found then
				insert into t_erreur values (seq_erreur.nextval, 0,'no data', 'c_prestation');        
			end;

			if (c_prestation.estlpp = '0') then
			  if (c_prestation.codetaux = '4') then
				creer_taux_prise_en_charge(c_couv_amc.t_couvertureamc_id, c_prestation.code, recTauxVigBleue.taux, recTauxVigBleue.formule);
			  end if;

			  if (c_prestation.codetaux = '7') then
				creer_taux_prise_en_charge(c_couv_amc.t_couvertureamc_id, c_prestation.code, recTauxVigBlanche.taux, recTauxVigBlanche.formule);
			  end if;

			  if (c_prestation.codetaux = '1') then
				creer_taux_prise_en_charge(c_couv_amc.t_couvertureamc_id, c_prestation.code, recTauxVig100.taux, recTauxVig100.formule);
			  end if;

			  if (c_prestation.codetaux = '0') then
				creer_taux_prise_en_charge(c_couv_amc.t_couvertureamc_id, c_prestation.code, recTauxVigNR.taux, recTauxVigNR.formule);
			  end if;

			  if (c_prestation.codetaux = '5') then
				creer_taux_prise_en_charge(c_couv_amc.t_couvertureamc_id, c_prestation.code, recTauxVigOr.taux, recTauxVigOr.formule);
			  end if;

			  if (c_prestation.codetaux = '6') then
				creer_taux_prise_en_charge(c_couv_amc.t_couvertureamc_id, c_prestation.code, recTauxVigBlanche.taux, recTauxVigBlanche.formule);
			  end if;

        if (c_prestation.codetaux = '8') then
        creer_taux_prise_en_charge(c_couv_amc.t_couvertureamc_id, c_prestation.code, recTauxVigVGP.taux, recTauxVigVGP.formule);
        end if;  
			else  
			  creer_taux_prise_en_charge(c_couv_amc.t_couvertureamc_id, c_prestation.code, recTauxVigLPP.taux, recTauxVigBlanche.formule);
			end if;
		  end loop;
		exception
		  when others then
			rollback to ps_ajustement_couv_amc;         
		end;
	  end loop;
  end; 

  /* ********************************************************************************************** */
  procedure maj_numero_lot(AIDDestinataire in integer,
                           ANumeroLot in  number)
  as
  begin
    update erp.t_sv_numlot
    set numlotfse = ANumeroLot
    where t_destinataire_id = AIDDestinataire;
  end;
  
begin
  for cr_reg in (select t_regime_id, code, sanscentregestionnaire from erp.t_regime) loop
    Regimes(cr_reg.code).id := cr_reg.t_regime_id;
    Regimes(cr_reg.code).sans_centre_gestionnaire := cr_reg.sanscentregestionnaire;
  end loop;
  
  for cr_orgamcref in (select t_organismeamc_id, identifiantnational from erp.t_organismeamc where orgreference = '1') loop
    OrganismesAMCRef(cr_orgamcref.identifiantnational) := cr_orgamcref.t_organismeamc_id;
  end loop;
  
  for cr_couvamcref in (select t.t_organismeamc_id, t.t_couvertureamc_id 
                        from erp.t_24 t
                             inner join erp.t_organismeamc c on c.t_organismeamc_id = t.t_organismeamc_id
                        where c.orgreference = '1') loop
    CouvertureAMCRef(cr_couvamcref.t_organismeamc_id) := cr_couvamcref.t_couvertureamc_id;
  end loop;
  
  for cr_fsts in (select t_formule_sts_id, no_formule from erp.t_formule_sts) loop
    FormulesSTS(cr_fsts.no_formule) := cr_fsts.t_formule_sts_id;
  end loop; 

  for cr_orgamcunq in (select t_organismeamc_id, identifiantnational
                        from erp.t_organismeamc 
                        where (datemajorganisme,identifiantnational) in
                        (
                        select 
                        max(datemajorganisme), identifiantnational 
                        from erp.t_organismeamc 
                        where identifiantnational is not null
                        and id_del is null
                        group by identifiantnational )) loop
    OrganismesAMCUnq(cr_orgamcunq.identifiantnational) := cr_orgamcunq.t_organismeamc_id;
  end loop;

end; 
/