create or replace package body migration.pk_commun as  
  
  Pays tab_identifiants;
  CodesPostaux tab_identifiants;
  id_cp integer;

  /* ********************************************************************************************** */
  function creer_code_postal(ACodePostal in char,
                             ANomVille in varchar2,
                             ACodePays in varchar2)
                            return integer
  as
    intIDCodePostal integer;
    
    procedure inserer_code_postal as
    begin
      insert into bel.t_cpville(t_cpville_id,
                                codepostal,
                                nomville,
                                datemajcpville,
                                t_pays_id)
      values(bel.seq_cpville.nextval,
             upper(ACodePostal),
             upper(ANomVille),
             sysdate,
             Pays(ACodePays))
      returning t_cpville_id into intIDCodePostal;
              
      CodesPostaux(lower(ACodePostal) || ' ' || lower(ANomVille) || '(' || upper(ACodePays) || ')') := intIDCodePostal;    
    end;
    
  begin
    if (ACodePostal is not null) and (ANomVille is not null) and (ACodePays is not null) then
      if CodesPostaux.count = 0 then
        inserer_code_postal;
      else
        begin
          intIDCodePostal := CodesPostaux(lower(ACodePostal) || ' ' || lower(ANomVille) || '(' || upper(ACodePays) || ')');
        exception
          when no_data_found then
            intIDCodePostal := null;
        end;
        
        if intIDCodePostal is null then
          inserer_code_postal;
        end if;
      end if;
    else
      intIDCodePostal := 0;
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
                         AAdresseMail in varchar2,
                         AFax in varchar2,
                         ACodePays in varchar2)
                        return integer
  as
    intIDCodePostal integer;
    intIDAdresse integer;         
	telmobile varchar2(20);
  begin    
	
	if (substr(ATelMobile,1,2)='32') or (substr(ATelMobile,1,2)='33') or (substr(ATelMobile,1,2)='31') or (substr(ATelMobile,1,2)='49') then 
		telmobile := '0' || substr( ATelMobile, 3, length(ATelMobile)-2);
	elsif (substr(ATelMobile,1,3)='+32') or (substr(ATelMobile,1,3)='+33') or (substr(ATelMobile,1,3)='+31') or (substr(ATelMobile,1,3)='+49') or (substr(ATelMobile,1,3)='352') then 
		telmobile := '0' || substr( ATelMobile, 4, length(ATelMobile)-3);
	else
		telmobile := ATelMobile;
	end if;
	
	
    intIDCodePostal := creer_code_postal(ACodePostal, ANomVille, ACodePays);
    if intIDCodePostal is not null then
      insert into bel.t_adresse(t_adresse_id,
                                rue1,
                                rue2,
                                t_cpville_id,
                                telpersonnel,
                                telstandard,
                                telmobile,
                                fax,
                                email,
                                datemajadresse)
      values(bel.seq_adresse.nextval,
             ARue1,
             ARue2,
             intIDCodePostal,
             ATelPersonnel,
             ATelStandard,
             telmobile,
             AFax,
             AAdresseMail,
             sysdate)
      returning t_adresse_id into intIDAdresse;
    else
      intIDAdresse := null;
    end if;
     
    return intIDAdresse;
  exception
    when others then
      return null;
  end;
    
  /* ********************************************************************************************** */
  /*procedure initialiser_transfert
  as
  begin	
    select t_canevas_facture_id
    into IDCanevasFacture
    from bel.t_canevas_facture
    where rownum = 1
    order by t_canevas_facture_id;
  end;*/
  
  /* ********************************************************************************************** */
  procedure initialiser_transfert(AOptions in rec_options,
                                  AMode in integer,
                                  ASuppressionTableTMP in char)
  as
  begin	
	   Options := AOptions;
       
    begin
      select t_operateur_id
      into IDOperateurPoint
      from bel.t_operateur
      where codeoperateur = '.'
        and motdepasse = 'windhof';
    exception
      when no_data_found then
        raise_application_error(-20100, 'Opérateur "." introuvable !');
    end;
    
    begin
      select t_id_postedetravail, id_tiroircaisse
      into IDPoste0, IDTiroirCaissePoste0
      from bel.t_postedetravail
      where /*upper(nom) = 'POSTE0'
        and */serveur = '1'
        and rownum = 1;
    exception
      when no_data_found then
        raise_application_error(-20100, 'Poste de travail POSTE0 introuvable !');
    end;
    
    begin
      select min(t_modereglement_id)
      into IDModeReglementCredit
      from bel.t_modereglement
      where type = 5;
    exception
      when no_data_found then
        raise_application_error(-20100, 'Mode de reglement par crédit introuvable !');    
    end;
    
    begin
      select min(t_devise_id)
      into IDDeviseEuro
      from bel.t_devise
      where codedevise = 'EUR';
    exception
      when no_data_found then
        raise_application_error(-20100, 'Devise Euro(¿) introuvable !');    
    end; 

    begin
      select t_profiledition_id
      into IDProfilEditionDefaut
      from bel.t_profiledition
      where saut_page_client = '1'
        and sous_total_client = '1'
        and detail_produits = '1'
        and type_de_tri = '2';
    exception
      when no_data_found then
        raise_application_error(-20100, 'Profil d''édition par défaut (Saut page client/Sous total client/Détail produit) introuvable !');    
    end;    
    
    -- Suppression des tables temporaires
    if ASuppressionTableTMP = '1' then
      delete from migration.t_tmp_produit_fusionne;
      delete from migration.t_tmp_client_fusionne;
    end if;
  end;
  
  /* ********************************************************************************************** */
  procedure initialiser_transfert
  as
  begin	
    select t_canevas_facture_id
    into IDCanevasFacture
    from bel.t_canevas_facture
    where rownum = 1
    order by t_canevas_facture_id;
  end;
  
begin
  -- Codes postaux
  for cr_cp in (select cp.t_cpville_id, lower(cp.codepostal) codepostal, lower(cp.nomville) nomville, upper(p.code_iso) pays from bel.t_cpville cp inner join bel.t_pays p on p.t_pays_id=cp.t_pays_id) loop
	begin
          ID_Cp := CodesPostaux(cr_cp.codepostal || ' ' || cr_cp.nomville || '(' || upper(cr_cp.pays) || ')');
        exception
          when no_data_found then
            CodesPostaux(cr_cp.codepostal || ' ' || cr_cp.nomville|| '(' || upper(cr_cp.pays) || ')') := cr_cp.t_cpville_id;
        end;
	end loop;
  
  for cr_pays in (select t_pays_id, upper(code_iso) pays from bel.t_pays ) loop
    Pays(cr_pays.pays) := cr_pays.t_pays_id;
  end loop;
    
/*  -- Activités
  for cr_act in (select t_activite_id, type, libelle from bel.t_activite) loop
    Activites(cr_act.type || '_' || cr_act.libelle) := cr_act.t_activite_id;
  end loop;
*/
  initialiser_transfert(Options, C_MODE_NORMAL, '0');   
end; 


/