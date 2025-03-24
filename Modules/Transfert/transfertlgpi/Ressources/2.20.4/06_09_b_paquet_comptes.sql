create or replace package body migration.pk_comptes as

  /* ********************************************************************************************** */
  function creer_compte(AIDCompteLGPI in integer,
                        ANom in varchar2,
                        AActivite in varchar2,
                        ARue1 in varchar2,
                        ARue2 in varchar2,
                        ACodePostal in varchar2,
                        ANomVille in varchar2,
                        ATelPersonnel in varchar2,
                        ATelStandard in varchar2,
                        ATelMobile in varchar2,
                        AFax in varchar2,										                
                        ADelaiPaiement in number,
                        AFinDeMois in char,
                        ACollectivite in char,
                        AIDProfilremise in integer,
                        AIDProfilEdition in integer,		                        										                
                        APayeur in char,
                        AIDClient in integer)
                       return integer
  as                       
    intIDCompte integer;
    intIDActivite integer;
    intIDAdresse integer;
  begin
    savepoint ps_comptes;
  
    if AIDClient is not null then
      update erp.t_assureayantdroit
      set t_profiledition_id = nvl(AIDProfilEdition, pk_commun.IDProfilEditionDefaut),
          relevecredits = '1'
      where t_aad_id = AIDClient
      returning t_aad_id into intIDCompte;
    else		    
      intIDAdresse := pk_commun.creer_adresse(ARue1, ARue2, ACodePostal, ANomVille, ATelPersonnel, ATelStandard, ATelMobile, AFax, null);
      intIDActivite := pk_commun.creer_activite(AActivite, 'A'); 
      
      if AIDCompteLGPI is null then
        insert into erp.t_assureayantdroit(t_aad_id,
  		                                       nom,
  		    																	 t_activite_id,
  		                                       t_adresse_id,
  		                                       datemajaad,
  		                                       t_qualite_id,
  		                                       paiediffinterdit,
  		                                       chequeinterdit,
  		                                       commglobalbloquant,
  		                                       commindividuelbloquant,
  		                                       relevecredits,
  		                                       delaipaiement,
  		                                       findemois,
  		                                       t_profilremise_id,
  		                                       t_profiledition_id,
  		                                       collectivite,
  		                                       payeur,
  											   ranggemellaire
  												)
  						values(erp.seq_assureayantdroit.nextval,
  						       ANom,
  						       intIDActivite,
  						       intIDAdresse,
  						       sysdate,
               pk_commun.IDQualiteAssure,
               '0',
  						       '0',
  						       '0',
  						       '0',
  						       '1',
  						       ADelaiPaiement,
  						       AFinDeMois,
  						       AIDProfilRemise,
  						       nvl(AIDProfilEdition, pk_commun.IDProfilEditionDefaut),
  						       ACollectivite,
  						       APayeur,
  						       0)
  						returning t_aad_id into intIDCompte;
      else
        intIDCompte := AIDCompteLGPI;
        
        delete from erp.t_adresse
        where t_adresse_id = (select t_adresse_id
                              from erp.t_assureayantdroit
                              where t_aad_id = AIDCompteLGPI);  

        update erp.t_assureayantdroit
        set nom = ANom,
            t_activite_id = intIDActivite,
            t_adresse_id = intIDAdresse,
            datemajaad = sysdate,
            t_qualite_id = pk_commun.IDQualiteAssure,
            delaipaiement = ADelaiPaiement,
            findemois = AFinDeMois,
            t_profilremise_id = AIDProfilRemise,
            t_profiledition_id = nvl(AIDProfilEdition, pk_commun.IDProfilEditionDefaut),
            collectivite = ACollectivite,
            payeur = APayeur
        where t_aad_id = AIDCompteLGPI;
        
        delete from erp.t_collectivite where id_collectivite = AIDCompteLGPI;
      end if;
				end if;
    
    return intIDCompte;
  exception
    when others then
      rollback to ps_comptes;
      raise;
  end;
  
  /* ********************************************************************************************** */
  procedure rattacher_client(AIDCompte in integer,
                            AIDClient in integer)
  as
  begin
    savepoint ps_clients_comptes;
    
    insert into erp.t_collectivite(id_collectivite,
                                   id_adherent)
    values(AIDCompte,
           AIDClient);
  exception
    when others then
      rollback to ps_clients_comptes;
  end;
  /* ********************************************************************************************** */  
  function creer_param_remise_fixe(AIDParamRemiseFixeLGPI in integer,
                  																 ATaux in number)
                  																return integer
  as intIDparamremisefixe integer;                     
  begin
    savepoint ps_paramremisefixe;
  
    if AIDParamRemiseFixeLGPI is null then
      insert into erp.t_paramremisefixe(t_paramremisefixe_id,
                      																	 taux,
                      																	 datemaj)
      values(erp.seq_paramremise.nextval,
      							ATaux,
    									sysdate)
   			returning t_paramremisefixe_id into intIDparamremisefixe;
   	else
    		intIDparamremisefixe := AIDParamRemiseFixeLGPI;
    		
    		update erp.t_paramremisefixe 
    		set taux = ATaux,
    		    datemaj = sysdate
    		where t_paramremisefixe_id = intIDparamremisefixe;	
    end if ;  

    return intIDparamRemiseFixe;
  exception
    when others then
      rollback to ps_paramremisefixe;
      raise;
  end;  

  /* ********************************************************************************************** */ 
  function creer_profil_remise(AIDProfilRemiseLgpi in integer,
               															 ALibelle in varchar2,
               															 AArrondi in number,
               															 ATypeArrondi in char,
              														   AIDParamRemiseFixe in integer,
              														   ATypeRemise in char,
              														   ASurVenteDirecte in char,
              														   ASurFactureCiale in char,
               															 ASurFactureRetro in char,
               															 ASurOrdonnance in char)
               															return integer
  as 
    intIDprofilremise integer;                      
  begin
    savepoint ps_profilremise;
  
    if AIDProfilRemiseLgpi is null then
      insert into erp.t_profilremise(t_profilremise_id,
                                     libelle,
                                     arrondi,
                                     type_arrondi,
                                     parametresremisefixe_id,
                                     datemaj,
                                     typeremise,
                                     sur_vd,
                                     sur_factciale,
                                     sur_factretro,
                                     sur_ordonnance,
                                     sur_promo_ou_remise)
      values(erp.seq_profilremise.nextval, 
             ALibelle,
             AArrondi,
             ATypeArrondi,
             AIDParamRemiseFixe,
             sysdate,
             ATypeRemise,
             ASurVenteDirecte,
             ASurFactureCiale,
             ASurFactureRetro,
             ASurOrdonnance,
             '0')
 				 returning t_profilremise_id into intIDprofilremise;					
    else
   		intIDprofilremise	:= AIDProfilRemiseLgpi;				
  			
  			update erp.t_profilremise
  			set libelle = ALibelle,           
         arrondi = AArrondi,           
         type_arrondi = ATypeArrondi,       
         parametresremisefixe_id = AIDParamRemiseFixe, 
         datemaj = sysdate,            
         typeremise = ATypeRemise,        
         sur_vd = ASurVenteDirecte,   
         sur_factciale = ASurFactureCiale,   
         sur_factretro = ASurFactureRetro,   
         sur_ordonnance = ASurOrdonnance
      where t_profilremise_id = intIDprofilremise;
            
    end if; 
    
    return intIDprofilRemise;
  exception
    when others then
      rollback to ps_profilremise;
      raise;
  end;  
end; 
/