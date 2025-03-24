create or replace package body migration.pk_autres_donnees as

  type tab_adresse is varray(8) of varchar(40);
  
  /* ********************************************************************************************** */
  procedure maj_parametre(ACle in varchar,
                          AValeur in varchar) as                          
                          
    lAdresse tab_adresse;
    lIntIDAdresse integer;
    lIntIDCPVille integer;
    
    C_PARAMETRE_ADRESSE constant varchar2(50) := 'pha.adresse';
    
    C_ADRESSE_RUE_1 constant integer := 1;
    C_ADRESSE_RUE_2 constant integer := 2;
    C_ADRESSE_CODE_POSTAL constant integer := 3;
    C_ADRESSE_NOM_VILLE constant integer := 4;
    C_ADRESSE_TEL_STANDARD constant integer := 5;
    C_ADRESSE_TEL_PERSONNEL constant integer := 6;
    C_ADRESSE_TEL_MOBILE constant integer := 7;
    C_ADRESSE_FAX constant integer := 8;
    
    procedure decouper_chaine(AChaine in varchar,
                              ASeparateur in char)
    as      
      lStrChaine varchar2(300) := AChaine;
      i integer; lIntPos integer;
    begin      
      lAdresse := tab_adresse(); i := 0;
      while i < C_ADRESSE_FAX loop
        lIntPos := instr(lStrChaine, ASeparateur); 
        lAdresse.extend(1); i := i + 1;        
        if lIntPos > 0 then
          lAdresse(i) := substr(lStrChaine, 1, lIntPos - 1);
          lStrChaine := substr(lStrChaine, lIntPos + 1, length(lStrChaine) - lIntPos + 1);
        else
          lAdresse(i) := lStrChaine;
          lStrChaine := '';
        end if;        
      end loop;
    end;
    
  begin
    if AValeur is not null then
      -- Traitement de l'adresse    
      if lower(ACle) = C_PARAMETRE_ADRESSE then
        select valeur
        into lIntIDAdresse
        from erp.t_parametres
        where cle = C_PARAMETRE_ADRESSE;
        
        if lIntIDAdresse is not null then
          select t_cpville_id
          into lIntIDCPVille
          from erp.t_adresse
          where t_adresse_id = lIntIDAdresse;
                  
          decouper_chaine(AValeur, '|');
          update erp.t_cpville
          set codepostal = substr(lAdresse(C_ADRESSE_CODE_POSTAL), 1, 5),
              nomville = substr(lAdresse(C_ADRESSE_NOM_VILLE), 1, 30)
          where t_cpville_id = lIntIDCPVille;
          
          update erp.t_adresse
          set rue1 = substr(lAdresse(C_ADRESSE_RUE_1), 1, 40),
              rue2 = substr(lAdresse(C_ADRESSE_RUE_2), 1, 40),
              telstandard = substr(lAdresse(C_ADRESSE_TEL_STANDARD), 1, 20),
              telpersonnel = substr(lAdresse(C_ADRESSE_TEL_PERSONNEL), 1, 20),
              telmobile = substr(lAdresse(C_ADRESSE_TEL_MOBILE), 1, 20),
              fax = substr(lAdresse(C_ADRESSE_FAX), 1, 20)
          where t_adresse_id = lIntIDAdresse;
        end if;
      -- MAJ Parametre
      else
        update erp.t_parametres
        set valeur = AValeur
        where lower(cle) = lower(ACle);     
      end if;   
    end if;
  end;
  
  /* ********************************************************************************************** */
  function creer_operateur(AIDOperateur in varchar,
                           ACodeOperateur in varchar,
                           ANom in varchar,
                           APrenom in varchar,
                           AMotDePasse in varchar,
                           AActivationOperateur in char,
                           AGraviteInteraction in char)
                          return integer as
    intIDOperateur integer;
  begin
    savepoint sp_operateurs;

    insert into erp.t_operateur(t_operateur_id,
                                codeoperateur,
                                nom,
                                prenom,
                                motdepasse,
                                activationoperateur,
                                datemaj,                                
                                rgbintlevel1,
                                rgbintlevel2,
                                rgbintlevel3,
                                rgbintlevel4,
                                rgbci,
                                propqteacder,
                                t_profil_operateur_id,
								                rgb_redondance_pa)
    values(erp.seq_id_operateur.nextval,
           ACodeOperateur,
           ANom,
           APrenom,
           AMotDePasse,
           AActivationOperateur,
           sysdate,
           -154,
           -13261,
           -39424,
           -3407872,
           -65434,
           0,
           pk_commun.IDProfilOperateur,
		       -103)
    returning t_operateur_id into intIDOperateur;
    
    return intIDOperateur;
  exception
    when others then
      rollback to sp_operateurs;
      raise;
  end;
  
  /* ********************************************************************************************** */
  function creer_historique_client(AIDClient in integer,
                                   ANumeroFacture in number,
                                   ADatePrescription in date,
                                   ACodeOperateur in varchar,
                                   ANomPraticien in varchar,
                                   APrenomPraticien in varchar,
                                   ATypeFacturation in number,
                                   ADateActe in date)
                                  return integer
  as
    intIDHistoriqueClient integer;
  begin
    savepoint sp_historique_client;

    insert into erp.t_histo_client_entete(t_histo_client_entete_id,
                                          t_client_id,
                                          numero_facture,
                                          date_prescription,
                                          date_maj,
                                          code_operateur,
                                          nom_medecin,
                                          prenom_medecin,
                                          the_type_facturation,
                                          date_acte)
    values(erp.seq_pk_histo_client_entete.nextval,
           AIDClient,
           ANumeroFacture,
           ADatePrescription,
           sysdate,
           nvl(ACodeOperateur, '.'),
           ANomPraticien,
           APrenomPraticien,
           ATypeFacturation,
           ADateActe)
    returning t_histo_client_entete_id into intIDHistoriqueClient;

    return intIDHistoriqueClient;
  exception
    when others then
      rollback to sp_historique_client;
      raise;
  end;

  /* ********************************************************************************************** */
  procedure creer_historique_client_ligne(AIDHistoriqueClientEntete in integer,
                                          ACodeCIP in varchar,
                                          AIDProduit in integer,
                                          ADesignation in varchar,
                                          AQuantiteFacturee in number,
                                          APrixAchat in number,
                                          APrixVente in number,
                                          AMontantNetHT in number,
                                          AMontantNetTTC in number,
                                          APrixAchatHTRemise in number)
  as
    lIntProduitID integer;
  begin
    savepoint sp_historique_client_ligne;

  /* on essaye de retrouver le produit ID le cip qui arrive peut etre un cip7 ou cip13 */
  if ( AIDProduit is null ) then 
      begin
        select t_produit_id
        into lIntProduitID
        from erp.t_produit
        where codecip = ACodeCIP or codecip7 = ACodeCIP;
      exception
        when no_data_found or too_many_rows then
          lIntProduitID := null;
      end;
    end if;

    insert into erp.t_histo_client_ligne(t_histo_client_entete_id,
                                         t_histo_client_ligne_id,
                                         t_produit_id,
                                         codecip,
                                         designation,
                                         qtefacturee,
                                         prix_achat,
                                         prixvente,
                                         montant_net_ht,
                                         montant_net_ttc,
                                         prix_achat_ht_remise)
    values(AIDHistoriqueClientEntete,
           erp.seq_pk_histo_client_ligne.nextval,
          nvl(AIDProduit, lIntProduitID),
           ACodeCIP,
           ADesignation,
           AQuantiteFacturee,
           APrixAchat,
           APrixVente,
           AMontantNetHT,
           AMontantNetTTC,
           APrixAchatHTRemise);
  exception
    when others then
      rollback to sp_historique_client_ligne;
      raise;
  end;
  
  /* ********************************************************************************************** */
procedure recreer_historiques_ventes(AFacteurVDL0 in number, AFacteurVDL1 in number)
  as
    h erp.t_historiquevente.t_historiquevente_id%type;
    v integer;
    q integer;
  begin
    for cr in (select t_produit_id, 
                      liste,
                      mois, 
                      annee, 
                      count(*) nb_actes, 
                      sum(qtefacturee) nb_vendues
              from (select p.t_produit_id, 
                           p.liste,
                           extract(month from e.date_acte) mois, 
                           extract(year from e.date_acte) annee, 
                           l.qtefacturee
                    from erp.t_histo_client_ligne l           
                         inner join erp.t_histo_client_entete e on (e.t_histo_client_entete_id = l.t_histo_client_ligne_id)
                         inner join erp.t_produit p on (p.codecip = to_char(l.codecip)))
              group by t_produit_id, liste, mois, annee) loop
      if (cr.liste = '0') then
        v := v * AFacteurVDL0;
        q := q * AFacteurVDL0;
      else
        if (cr.liste = '1') then
          v := v * AFacteurVDL1;
          q := q * AFacteurVDL1;        
        end if;
      end if;
       
      begin
        select t_historiquevente_id
        into h
        from erp.t_historiquevente
        where t_produit_id = cr.t_produit_id
        and mois = cr.mois
        and annee = cr.annee;
        
        update erp.t_historiquevente
        set qtevendue = qtevendue + cr.nb_vendues,
            nbventes = nbventes + cr.nb_actes,
            datemajhistvte = sysdate;
      exception
        when no_data_found then
          insert into erp.t_historiquevente(t_historiquevente_id,
                                            t_produit_id,
                                            mois,
                                            annee,
                                            moisannee,
                                            qtevendue,
                                            nbventes,
                                            datemajhistvte)
          values(erp.seq_id_historiquevente.nextval,
                 cr.t_produit_id,
                 cr.mois,
                 cr.annee,
                 to_date('01' || lpad(cr.mois, 2, '0') || cr.annee, 'DDMMYYYY'),
                 cr.nb_vendues,
                 cr.nb_actes,
                 sysdate);
      end;
    end loop;
  end;
  

  /* ********************************************************************************************** */
    procedure creer_document(ATypeEntite in int, -- type d entite auquel est rattaché le doc 
                           AIDEntite in integer,
                           AContentType in integer,
                           ALibelle in varchar2,
                           ADateDocument in date, 
                           ACommentaire in varchar2,
                           ADocument in out blob)
  as
    d integer;  
    id integer;
    lobDest blob;
    docDate date;
    strMimeType varchar2(20);
    EntityType integer;
    ContentType integer;   -- 1=tif 2=pdf 3=autre 
  begin
    savepoint sp_document;
    

    if (AContentType is null) then 
      strMimeType := 'image/jpeg';
      ContentType := 3; 

      if (instr(upper(ALibelle), '.JPG') > 0) then 
        strMimeType := 'image/jpeg';
        ContentType := 3; 
      end if;
      if (instr(upper(ALibelle), '.PDF') > 0) then 
        strMimeType := 'application/pdf'; 
        ContentType := 2;
      end if;
      if (instr(upper(ALibelle), '.TIF') > 0) then 
        strMimeType := 'application/tiff'; 
        ContentType := 1;
      end if;
     else
      ContentType := AContentType; 
      
      if (ContentType = 3) then 
        strMimeType := 'image/jpeg';
      end if;
      if (ContentType = 2) then 
        strMimeType := 'application/pdf'; 
      end if;
      if (ContentType = 1) then 
        strMimeType := 'application/tiff'; 
      end if;       
     end if; 

    -- on n'utilise pas Entity type = 1 réservé aux vraies factures et reliée au facture 
    if (instr(upper(ACommentaire), 'MUTU') > 0) or (instr(upper(ACommentaire), 'ATTESTATION') > 0) then 
      EntityType:= 2; -- Attestation mutuelle
    else 
      EntityType:= 15; -- Autre Document
    end if;
 
    -- Création de la description en base
    insert into erp.t_document(id_doc, content_type, mime_type) 
      values(erp.seq_id_document.nextval, ContentType, strMimeType) 
    returning id_doc into d;    

  	if (ATypeEntite = 3) then
  	  select numero
  	  into id
  	  from erp.t_commande
  	  where t_commande_id = AIDEntite;
  	else
  	  id := AIDEntite;
  	end if;
    if (ADateDocument is null) then 
      docDate := sysdate;
    else
      docDate := ADateDocument;
    end if;
	  insert into erp.t_doc_asso(id_entity, id_doc, entity_type, date_cliche, comments) values(id, d, EntityType, docDate, ACommentaire);
    insert into erp.t_content_doc(page, id_doc) values(0, d);
    
    -- Ecriture du LOB
    select content
    into lobDest
    from erp.t_content_doc
    where id_doc = d
    for update;

    dbms_lob.copy(lobDest, ADocument, dbms_lob.getlength(ADocument));
  exception
    when others then
      rollback to sp_document;
      raise;
  end;
  


  /* ********************************************************************************************** */  
  procedure completer_histo_client
  as
	cursor c_rotation is  select moisannee, t_produit_id, qtevendue from erp.t_historiquevente
	where months_between( sysdate , moisannee ) <= 12 ;

	qte number;
	IDoperateur number;
	IDhisto number;
  begin

	  select t_operateur_id
	  into IDoperateur
	  from erp.t_operateur
	  where codeoperateur = '.' ;

	  for rec in c_rotation loop
		begin
		  select sum(l.qtefacturee)
		  into qte
		  from erp.t_histo_client_entete e
		  left join erp.t_histo_client_ligne l on l.t_histo_client_entete_id = e.t_histo_client_entete_id
		  where t_produit_id = rec.t_produit_id and to_char(e.date_acte,'MMYYYY') = to_char(rec.moisannee,'MMYYYY')
		  group by  to_char(e.date_acte,'MMYYYY') ,  l.t_produit_id;
		exception
		  when no_data_found then qte := 0 ;
		end;  

		if (qte <> rec.qtevendue ) then
			insert into erp.t_histo_client_entete(t_histo_client_entete_id,
											  date_prescription,
											  numero_facture,
											  date_maj,
											  code_operateur,
											  the_type_facturation,
											  date_acte)
			values(erp.seq_pk_histo_client_entete.nextval,
			   rec.moisannee,
			   0,
			   sysdate,
			   IDoperateur,
			   1,
			   rec.moisannee) returning t_histo_client_entete_id into IDhisto ;
			   
			insert into erp.t_histo_client_ligne(t_histo_client_entete_id,
											 t_histo_client_ligne_id,
											 t_produit_id,
											 designation,
											 qtefacturee,
											 prix_achat,
											 prixvente,
											 montant_net_ht,
											 montant_net_ttc,
											 prix_achat_ht_remise)
			values(IDHisto,
			   erp.seq_pk_histo_client_ligne.nextval,
			   rec.t_produit_id,
			   'equilibrage historiques vente',
			   rec.qtevendue - qte,
			   0,
			   0,
			   0,
			   0,
			   0);  			   
		-- dbms_output.put_line( 'completer_histo_client '||rec.t_produit_id || ' ' ||to_char(rec.moisannee,'MMYYYY') || ' qte rotation = '||rec.qtevendue || ' qte histo client ' || qte  );	  
		end if;
		
	  end loop;
  end;
  
/* ********************************************************************************************** */  
  
  function creer_commentaire(AIDCommentaireLGPI in integer,
                             AIDEntite in integer,
                             ATypeEntite in integer,
                             AEstGlobal in char,
                             AEstBloquant in char,
                             ACommentaire in clob)
                            return integer as intIDCommentaire integer;
  begin
    savepoint sp_commentaire;

            insert into erp.t_commentaire(id_commentaire,                 
                                      type_entite, 
                                      contenu, 
                                      datemaj, 
                                      id_icone, 
                                      id_operateur, 
                                      is_bloquant, 
                                      is_global,
                                      id_synchro)
            values(erp.seq_commentaire.nextval,
                    ATypeEntite, -- typecommentaire.assure_ayant_droit
                    '<p style="text-align: left;">' || ACommentaire || '</p>', 
                    sysdate, 
                    0, -- icone.aucun
                    pk_commun.IDOperateurPoint,
                    AEstBloquant,
                    AEstGlobal, 
                    sys_guid()
                    ) returning id_commentaire into intIDCommentaire;
                          
            insert into erp.t_commentaire_association(id_commentaire, 
                                                  id_entite)                
            values(intIDCommentaire,
                   AIDEntite);        
    
    return intIDCommentaire;
  exception
    when others then
      rollback to sp_commentaire;
      raise;
  end;

/* ********************************************************************************************** */  

  procedure calc_stat
  as
  begin
     DBMS_STATS.GATHER_SCHEMA_STATS(
       ownname            => 'ERP',
       Estimate_Percent   => 30,
       Cascade            => true,
       Method_Opt         => 'FOR ALL COLUMNS SIZE 1',
       no_invalidate => false
       );
  end;

/* ********************************************************************************************** */  

  procedure reactive_migration_muse
  as
  begin 
    update erp.t_parametres set valeur = 1 where cle = 'ged.migrationVersMuse.active';  
  end;

/* ********************************************************************************************** */  

end; 
/