create or replace package body migration.pk_commun as  
  
  CodesPostaux tab_identifiants;
  
  /* ********************************************************************************************** */
  function creer_code_postal(ACodePostal in char,
                             ANomVille in varchar2)
                            return integer
  as
    intIDCodePostal integer;
    
    procedure inserer_code_postal as
    begin
      insert into erp.t_cpville(t_cpville_id,
                                codepostal,
                                nomville,
                                datemajcpville,
                                t_pays_id)
      values(erp.seq_cpville.nextval,
             upper(ACodePostal),
             upper(ANomVille),
             sysdate,
             1)
      returning t_cpville_id into intIDCodePostal;
              
      CodesPostaux(lower(ACodePostal) || ' ' || lower(ANomVille)) := intIDCodePostal;    
    end;
    
  begin
    if (ACodePostal is not null) and (ANomVille is not null) then
      if CodesPostaux.count = 0 then
        inserer_code_postal;
      else
        begin
          intIDCodePostal := CodesPostaux(lower(ACodePostal) || ' ' || lower(ANomVille));
        exception
          when no_data_found then
            intIDCodePostal := null;
        end;
        
        if intIDCodePostal is null then
          inserer_code_postal;
        end if;
      end if;
    else
      intIDCodePostal := null;
    end if;
    
    return intIDCodePostal;    
  exception
    when others then
      return null;
  end;

  /* ********************************************************************************************** */
  function creer_adresse(ARue1 in varchar2,
                         ARue2 in varchar2,
                         ACodePostal in char,
                         ANomVille in varchar2,
                         ATelPersonnel in varchar2,
                         ATelStandard in varchar2,
                         ATelMobile in varchar2,
                         AFax in varchar2,
                         AAdresseMail in varchar2)
                        return integer
  as
    intIDCodePostal integer;
    intIDAdresse integer;         
  begin    
    intIDCodePostal := creer_code_postal(ACodePostal, ANomVille);
    --if intIDCodePostal is not null then
      insert into erp.t_adresse(t_adresse_id,
                                rue1,
                                rue2,
                                t_cpville_id,
                                telpersonnel,
                                telstandard,
                                telmobile,
                                fax,
                                email,
                                datemajadresse)
      values(erp.seq_adresse.nextval,
             ARue1,
             ARue2,
             intIDCodePostal,
             ATelPersonnel,
             ATelStandard,
             ATelMobile,
             AFax,
             AAdresseMail,
             sysdate)
      returning t_adresse_id into intIDAdresse;
    --else
    --  intIDAdresse := null;
    --end if;
     
    return intIDAdresse;
  exception
    when others then
      return null;
  end;
  
  /* ********************************************************************************************** */
  function creer_activite(ALibelle in varchar2,
                          AType in char)
                         return integer
  as
    intIDActivite integer;  
    
    procedure inserer_activite as
    begin
      insert into erp.t_activite(t_activite_id,
                                 libelle,
                                 datemajactivite,
                                 type)
      values(erp.seq_id_activite.nextval,
             ALibelle,
             sysdate,
             AType)
      returning t_activite_id into intIDActivite;

      Activites(AType || '_' || ALibelle) := intIDActivite;      
    end;
    
  begin    
    if (ALibelle is not null) and (AType is not null) then
      if Activites.count = 0 then
        inserer_activite;
      else
        begin
          intIDActivite := Activites(AType || '_' || ALibelle);
        exception
          when no_data_found then
            intIDActivite := null;
        end;
        
        if intIDActivite is null then
          inserer_activite;
        end if;
      end if;
    else
      intIDActivite := null;    
    end if;
    
    return intIDActivite;    
  exception
    when others then
      return null;
  end;
  
  /* ********************************************************************************************** */
  procedure initialiser_transfert(AOptions in rec_options,
                                  AMode in integer,
                                  ASuppressionTableTMP in char)
  as
  begin	
	   Options := AOptions;
    
    IDQualiteAssure := Qualites('0');
    --IDPrestationMX1 := Prestations('MX1').id;
    IDPrestationPHN := Prestations('PHN').id;
   
    begin
      select t_id_postedetravail, id_tiroircaisse
      into IDPoste0, IDTiroirCaissePoste0
      from erp.t_postedetravail
      where /*upper(nom) = 'POSTE0'
        and */serveur = '1'
        and rownum = 1;
    exception
      when no_data_found then
        raise_application_error(-20100, 'Poste de travail POSTE0 introuvable !');
    end;
    
    begin
      select t_modereglement_id
      into IDModeReglementCredit
      from erp.t_modereglement
      where type = 5
      and rownum = 1;
    exception
      when no_data_found then
        raise_application_error(-20100, 'Mode de reglement par crédit introuvable !');    
    end;
    
    begin
      select t_devise_id
      into IDDeviseEuro
      from erp.t_devise
      where codedevise = 'EUR';
    exception
      when no_data_found then
        raise_application_error(-20100, 'Devise Euro(¿) introuvable !');    
    end; 

	begin
  begin
        select t_operateur_id
        into IDOperateurPoint
        from erp.t_operateur
        where codeoperateur = '.'
          and motdepasse = 'villers'
          and d_del is null;
      exception
        when no_data_found or too_many_rows then
          raise_application_error(-20100, 'Opérateur "." introuvable ! ou multiple');
     end;
    end;
      	
   
    -- Suppression des tables temporaires
    if ASuppressionTableTMP = '1' then
      delete from migration.t_tmp_produit_fusionne;
      delete from migration.t_tmp_client_fusionne;
    end if;
  end;
  
begin
  -- Codes postaux
  for cr_cp in (select t_cpville_id, lower(codepostal) codepostal, lower(nomville) nomville from erp.t_cpville) loop
    CodesPostaux(cr_cp.codepostal || ' ' || cr_cp.nomville) := cr_cp.t_cpville_id;
  end loop;
    
  -- Prestations  
  for cr_prest in (select t_prestation_id, code, esttips, estlpp, codetaux from erp.t_prestation) loop
    Prestations(cr_prest.code).id := cr_prest.t_prestation_id;
    Prestations(cr_prest.code).est_tips := cr_prest.esttips;
    Prestations(cr_prest.code).est_lpp := cr_prest.estlpp;
    Prestations(cr_prest.code).code_taux := cr_prest.codetaux;        
  end loop;
   
  -- Activités
  for cr_act in (select t_activite_id, type, libelle from erp.t_activite) loop
    Activites(cr_act.type || '_' || cr_act.libelle) := cr_act.t_activite_id;
  end loop;

  -- Qualités
  for cr_q in (select t_qualite_id, code from erp.t_qualite) loop
    Qualites(cr_q.code) := cr_q.t_qualite_id;
  end loop;  
  
  --initialiser_transfert(Options, C_MODE_NORMAL, '0');   
end; 
/