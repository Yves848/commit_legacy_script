create or replace package body migration.pk_clients as

	etatspathologiques pk_commun.tab_identifiants;
	classificationsatc pk_commun.tab_identifiants;

	function creationclient (
		aclient in varchar2,
		anom in varchar2,
		aprenom in varchar2,
		asexe in varchar2,
		alangue in varchar2,
		adatenaissance in date,
		aniss in varchar2,
		ainami in varchar2,
		arue1 in varchar2,
		arue2 in varchar2,
		acodepostal in varchar2,
		anomville in varchar2,
		acodepays in varchar2,
		atelpersonnel in varchar2,
		atelstandard in varchar2,
		atelmobile in varchar2,
		aemail in varchar2,
		afax in varchar2,
		asiteweb in varchar2,
		aoa in varchar2,
		aoacpas in number,
		amatoa in varchar2,
		adatedeboa in date,
		adatefinoa in date,
		aoc in varchar2,
		aoccpas in number,
		amatoc in varchar2,
		acatoc in varchar2,
		adatedeboc in date,
		adatefinoc in date,
		aoat in varchar2,
		amatat in varchar2,
		acatat in varchar2,
		adatedebat in date,
		adatefinat in date,
		act1 in varchar2,
		act2 in varchar2,
		acollectivite in varchar2,
		aversionassur in number,
		acertificat in varchar2,
		anumcartesis in varchar2,
		adernierelecture in date,
		adatedebvalpiece in date,
		adatefinvalpiece in date,
		apayeur in varchar2,
		anumtva in varchar2,
		acommindiv in varchar2,
		acommbloqu in varchar2,
		anatpiecejustifdroit in number,
		anumgroupe in varchar2,
		aidprofilremise in number,
		aidfamille in varchar2,
		adatedernierevisite in date,
		aeditionbvac in varchar2,
		aeditioncbl    in varchar2,
		aedition704 in varchar2,
		atypeprofilfacturation in number,
		acopiescanevasfacture in number,
		AEDITIONIMMEDIATE in varchar2,
		AMOMENT_FACTURATION in number,
		AJOUR_FACTURATION in number,
		APLAFOND_CREDIT in number,
		ACREDIT_EN_COURS in number,
		adate_delivrance in varchar2,
		anumchambre in varchar2,
		aetage in varchar2,
		amaison in varchar2,
		alit in varchar2,
		acodecourt in varchar2,
		anb_ticket_noteenvoi in number,
		anb_etiq_noteenvoi in number,
		adelaipaiement in number,
		asch_posologie in number,
		aph_ref in number,
		asejour_court in varchar2,
		atuh_boite_pleine in varchar2,
		aDECOND_FOUR in varchar2,
		aetat in varchar2,
		aidentifiant_externe in varchar2,
		asch_commentaire in varchar2,
		anumero_passport_cni in varchar2,
		afusion in char
		) return number 
	as
		t_client_id number;
		linttaad bel.t_assureayantdroit.t_aad_id%type;
		lintadresse bel.t_adresse.t_adresse_id%type;
		lintao bel.t_assurabilite.t_assurabilite_id%type;
		lintac bel.t_assurabilite.t_assurabilite_id%type;
		lintat bel.t_assurabilite.t_assurabilite_id%type;
		lintoao bel.t_organismeamo.t_organismeamo_id%type;
		lintoac bel.t_organismeamc.t_organismeamc_id%type;
		lintoat bel.t_organismeamo.t_organismeamo_id%type;
		ldatedeboc bel.t_assurabilite.datedebutdroit%type;
		varoc bel.t_organismeamc.t_organismeamc_id%type;
		
		cursor cursorgamc(oc in varchar2) is 
			select t_organismeamc_id 
			from bel.t_organismeamc 
			where identifiant = oc;
			
		cursor cursorgamcssm(cat in varchar2) is 
			select amc.t_organismeamc_id 
			from bel.t_organismeamc amc, bel.t_categoriebenef categ
			where categ.num_benef = trim(cat) and categ.t_typeoa_id = amc.t_typeoa_id;
			
		famserie tw_famille.fam_lgpi%type;
		idcol tw_client.cli_lgpi%type;
		idcategoa bel.t_categoriebenef.t_categoriebenef_id%type;
		idcategoc bel.t_categoriebenef.t_categoriebenef_id%type;
		idcategat bel.t_categoriebenef.t_categoriebenef_id%type;
		idcatoa bel.t_categoriebenef.t_categoriebenef_id%type;
		idcatoc bel.t_categoriebenef.t_categoriebenef_id%type;
		idcatat bel.t_categoriebenef.t_categoriebenef_id%type;
		v_prenom bel.t_assureayantdroit.prenom%type; --varchar50
		commentair bel.t_assureayantdroit.commindividuel%type; --varchar(500)
		nb integer;
		dtDDV date;
		intAdresseBEL integer;
		intAssurOABEL integer;
		intAssurOCBEL integer;
		intAssurATBEL integer;

		cursor recupidcol(numgrp in varchar2) is 
			select cli_lgpi 
			from tw_client 
			where client = numgrp;
		
		cursor recupidfamille(idfam in varchar2) is 
			select fam_lgpi 
			from tw_famille 
			where famille = idfam;
		
		cursor recupidcategoa(aaoa in varchar2) is 
			select t_categoriebenef 
			from bel.t_organismeamo 
			where identifiant = aaoa;

		cursor recupidcategoc(aaoc in varchar2) is 
			select t_categoriebenef_id 
			from bel.t_categoriebenef 
			where num_benef = aaoc;
			
		cursor recupidcategat(aaat in varchar2) is 
			select t_categoriebenef_id 
			from bel.t_categoriebenef 
			where num_benef = aaat;

		function enregistreassurabilite(
			amat in bel.t_assurabilite.num_inscription%type,
			act1 in bel.t_assurabilite.ct1%type,
			act2 in bel.t_assurabilite.ct2%type,
			adatedeb in bel.t_assurabilite.datedebutdroit%type,
			adatefin in bel.t_assurabilite.datefindroit%type) return bel.t_assurabilite.t_assurabilite_id%type
		as
			lintassurabilite bel.t_assurabilite.t_assurabilite_id%type;
		begin
			if (pk_annexes.erreur.err_code = 0) and (((amat is not null) and (amat <> ' ')) or ((act1 is not null and act1 <>0))) then
				begin
					insert into bel.t_assurabilite(t_assurabilite_id,
						num_inscription,
						ct1,
						ct2,
						datedebutdroit,
						datefindroit,
						datemaj)
					values(bel.seq_id_assurabilite.nextval,
						amat,
						act1,
						act2,
						adatedeb,
						adatefin,
						to_date(to_char(sysdate, 'dd/mm/yyyy') || ' 00:00', 'dd/mm/yyyy hh24:mi'))
					returning t_assurabilite_id into lintassurabilite;

					pk_annexes.erreur.err_code := 0; pk_annexes.erreur.err_msg := '';
				exception
					when others then
						lintassurabilite := null;
						pk_annexes.erreur.err_code := sqlcode; 
						pk_annexes.erreur.err_msg := sqlerrm;
						raise_application_error(-20200, 'assurabilite non créée !');
				end;
			else
				lintassurabilite := null;
				pk_annexes.erreur.err_code := 0; pk_annexes.erreur.err_msg := '';
			end if;
			
			return lintassurabilite;
		end enregistreassurabilite;

		procedure rechercheorgassurobl(
			aoa in bel.t_organismeamo.identifiant%type, 
			boolat in boolean)
		as
			varorg bel.t_organismeamo.t_organismeamo_id%type;
			
			cursor cursorgamo(oa in bel.t_organismeamo.identifiant%type) is 
				select t_organismeamo_id 
				from bel.t_organismeamo 
				where identifiant = oa;
		begin
			varorg := 0;
			open cursorgamo(aoa);
			fetch cursorgamo into varorg;

			if (varorg <> 0) then
				if (boolat = false) then
					lintoao := varorg;
				else
					lintoat := varorg;
				end if;
			else
				if (boolat = false) then
					lintoao := null;
				else
					lintoat := null;
				end if;
			end if;
			
			close cursorgamo;
		end rechercheorgassurobl;

	begin
		-- sauvegarde données déjà créée
		savepoint client;

		if afusion = '0' then
		  t_client_id := 0;
		else
			if aniss is not null then
				begin
					select t_aad_id, datedernierevisite 
					into t_client_id, dtDDV
					from bel.t_assureayantdroit 
					where numeroinsee=aniss;
				exception
					when no_data_found or too_many_rows then 
						begin
							select t_aad_id, datedernierevisite
							into t_client_id, dtDDV
							from bel.t_assureayantdroit 
							where code_court=acodecourt;
						exception
							when no_data_found or too_many_rows then 
								t_client_id:=0;    
						end;
				end;
			else
				t_client_id := 0;
			end if;
		end if;

		if (t_client_id = 0) or ((t_client_id <> 0) and (dtDDV < adatedernierevisite)) then
			-- Création des données connexes
		  
			/*************************************** creation de l'adresse du client  ***************************************/
			lintadresse := pk_commun.creer_adresse(
								arue1, 
								arue2, 
								acodepostal, 
								anomville, 
								atelpersonnel, 
								atelstandard, 
								atelmobile, 
								aemail, 
								afax, 
								acodepays);		
								
			/*************************************** création oa  ***************************************/
			rechercheorgassurobl(aoa,false);
			lintoao := coalesce(lintoao, aoacpas);
			if (lintoao is not null) then
				lintao := enregistreassurabilite(
							amatoa,
							act1,
							act2,
							adatedeboa,
							adatefinoa);
			end if;

			/*************************************** création oc ***************************************/
			varoc := 0;
			if (aoccpas is not null) then
				lintoac := aoccpas;
				lintac := enregistreassurabilite(amatoc,null,null, adatedeboc,adatefinoc);
			else
				if aoc = '993' then
					open cursorgamcssm(acatoc);
					fetch cursorgamcssm into varoc;
					close cursorgamcssm;
				else
					open cursorgamc(aoc);
					fetch cursorgamc into varoc;
					close cursorgamc;
				end if;
				
				if (varoc <> 0) then
					lintoac := varoc;
					if ((aoc not like '993') and (adatefinoc is not null)) then
						if (adatedeboc is null) then
							ldatedeboc := to_date('01/01/1900','dd/mm/yyyy');
						else
							ldatedeboc := adatedeboc;
						end if;
						
						lintac := enregistreassurabilite(
									amatoc,
									null, --act1
									null, --act2
									ldatedeboc,
									adatefinoc);
					else
						if (aoc like '993') then
							lintac := enregistreassurabilite(
										amatoc,
										null, -- act1,
										null, -- act2,
										adatedeboc,
										adatefinoc);
						else
							lintac := null;
						end if;
					end if;
				else
					lintoac := null;
				end if;
			end if;


			/*************************************** création at   ***************************************/
			rechercheorgassurobl(aoat,true);
			if (lintoat is not null) then
				lintat := enregistreassurabilite(
							amatat,
							null, /* act1 */
							null, /* act2 */
							adatedebat,
							adatefinat);
			end if;
		end if;
							
		if t_client_id = 0 then --insertion mais pas de fusion
		
			/*if (lintadresse is null) and (pk_annexes.erreur.err_code <> 0) then
			raise_application_error(-20200, 'erreur lors de la création de l adresse !');
			end if;*/

			/*************************************** création client ***************************************/
			idcol := null;
			famserie := null;
			idcategoa := null;
			idcategoc := null;
			idcategat := null;
			idcatoa := 0;
			idcatoc := 0;
			idcatat := 0;

			/*if acatoa is not null then --a voir si il y a une catég en oa !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
				open recupidcategoa(aoa);
				fetch recupidcategoa into idcatoa;	
				close recupidcategoa;

				if (idcatoa <> 0) then
					idcategoa := idcatoa;
				else
					idcategoa := null;
				--raise_application_error(-20200, 'problème oa !');
					end if;
			end if;*/

			if aoccpas is not null then
				select t_categoriebenef 
				into idcatoc 
				from bel.t_organismeamc 
				where t_organismeamc_id = aoccpas;
				
				if (idcatoc <> 0) then
					idcategoc := idcatoc;
				else
					idcategoc := null;
					--raise_application_error(-20200, 'problème oa !');
				end if;
			else
				if acatoc is not null or acatoc <>0 then
					open recupidcategoc(acatoc);
					fetch recupidcategoc into idcatoc;
					close recupidcategoc;

					if (idcatoc <> 0) then
						idcategoc := idcatoc;
					else
						idcategoc := null;
						--raise_application_error(-20200, 'problème oc !');
					end if;
				end if;
			end if;

			if acatat is not null then
				open recupidcategat(acatat);
				fetch recupidcategat into idcatat;
				close recupidcategat;

				if (idcatat <> 0) then
					idcategat := idcatat;
				else
					idcategat := null;
					-- raise_application_error(-20200, 'problème at !');
				end if;
			end if;

			v_prenom := aprenom;
			if (v_prenom is null) then 
				v_prenom:=' '; 
			end if;

			commentair := acommindiv;
			if (length(commentair)>498) then 
				commentair:= substr(commentair,1,438)||' !!! Commentaire tronqué, merci de regardez votre ancien soft';
			end if;

			insert into bel.t_assureayantdroit(
				t_aad_id,
				nom,
				prenom,
				sexe,
				datemaj,
				datenaissance,
				numeroinsee,
				noinami,
				collectivite,
				t_adresse_id,
				t_organismeamo_id,
				t_organismeamc_id,
				t_organismeat_id,
				categoriebenefoa,
				categoriebenefoc,
				categoriebenefat,
				t_assurabiliteoa_id,
				t_assurabiliteoc_id,
				t_assurabiliteat_id,
				versionassurabilite,
				certificatcartesis,
				numerocartesis,
				datedernierelecturesis,
				datedebutvaliditepiece,
				datefinvaliditepiece,
				payeur,
				datedernierevisite,
				t_profilremise_id,
				findemois,
				editioncbl,
				editionbvac,
				editionrecu,
				notvaintracommunautaire,
				commindividuel,
				commindividuelbloquant,
				langue,
				exonerationtva,
				natpiecejustifdroit,
				typeprofilfacturation,
				copiescanevasfacture,
				EDITIONIMMEDIATE,
				MOMENT_FACTURATION, 
				JOUR_FACTURATION,
				PLAFOND_CREDIT,
				CREDIT_EN_COURS,
				date_delivrance, 
				code_court,
				identifiant_externe,
				t_canevas_facture_id,
				ticket_noteenvoi,
				nb_ticket_noteenvoi,
				etiq_noteenvoi,
				nb_etiq_noteenvoi,
				delaipaiement,
				sch_posologie,
				ph_ref,
				sejour_court, 
				tuh_boite_pleine,   
				decond_four, 
				etat_client,
				sch_commentaire,
				NUMPASSEPORTCNI)
			values(
				bel.seq_id_assureayantdroit.nextval,
				upper(anom),
				v_prenom,
				asexe,
				to_date(to_char(sysdate, 'dd/mm/yyyy'),'dd/mm/yyyy'),
				adatenaissance,
				aniss,
				ainami,
				acollectivite,
				lintadresse,
				lintoao,
				lintoac,
				lintoat,
				idcategoa,
				idcategoc,
				idcategat,
				lintao,
				lintac,
				lintat,
				aversionassur,
				acertificat,
				to_number(anumcartesis),
				adernierelecture,
				adatedebvalpiece,
				adatefinvalpiece,
				apayeur,
				adatedernierevisite,
				aidprofilremise,
				0,
				nvl(aeditioncbl,'0'),
				nvl(aeditionbvac,'0'),
				nvl(aedition704,'0'),
				anumtva,
				commentair,
				nvl(acommbloqu,'0'),
				alangue,
				0,
				anatpiecejustifdroit,
				atypeprofilfacturation,
				acopiescanevasfacture,
				AEDITIONIMMEDIATE,
				AMOMENT_FACTURATION,
				AJOUR_FACTURATION,
				APLAFOND_CREDIT,
				ACREDIT_EN_COURS,
				adate_delivrance,
				acodecourt,
				aidentifiant_externe,
				decode(atypeprofilfacturation, '2', pk_commun.idcanevasfacture, null),
				decode(anb_ticket_noteenvoi,1,1,0),
				anb_ticket_noteenvoi,
				decode(anb_etiq_noteenvoi,1,1,0),
				anb_etiq_noteenvoi,
				adelaipaiement,
				asch_posologie,
				aph_ref,
				asejour_court,
				atuh_boite_pleine,
				adecond_four,
				aetat,
				asch_commentaire,
				anumero_passport_cni)
			returning t_aad_id into t_client_id;

			if afusion = '1' then
			  insert into migration.t_fusion_client(t_client_id, etat)
			  values(t_client_id, 'C');
			end if;
			
			if aidfamille is not null then
				famserie := null;
				open recupidfamille(aidfamille);
				fetch recupidfamille into famserie;
				close recupidfamille;

				if (famserie is not null) then
					insert into bel.t_familleaad(no_famille,t_aad_id)
					values(famserie,t_client_id);
				else
					insert into bel.t_familleaad(no_famille,t_aad_id)
					values(bel.seq_no_famille.nextval,t_client_id);

					insert into tw_famille(famille,fam_lgpi) 
					values(aidfamille,bel.seq_no_famille.currval);
				end if;
			end if;
			
			nb:=0;
			if ((acollectivite = 0) and (t_client_id is not null) and (anumgroupe is not null) and (aetat not in (1,2))) then
				open recupidcol (anumgroupe);
				fetch recupidcol into idcol;

				begin
					select t_aad_id 
					into nb 
					from bel.t_collectivite 
					where t_aad_id=t_client_id and no_collectivite=idcol;
				exception
					when no_data_found then
						nb:=0;            
				end;

				if (idcol is not null and nb=0) then
					insert into bel.t_collectivite(
						no_collectivite,
						t_aad_id,
						chambre,
						etage,
						maison,
						lit)
					values(
						idcol,
						t_client_id,
						anumchambre,
						aetage,
						amaison,
						alit);   
				end if;
				
				close recupidcol;
			end if;			
		elsif dtDDV < adatedernierevisite then --fusion			
			select t_adresse_id, t_assurabiliteoa_id, t_assurabiliteoc_id, t_assurabiliteat_id
			into intAdresseBEL, intAssurOABEL, intAssurOCBEL, intAssurATBEL
			from bel.t_assureayantdroit
			where t_aad_id = t_client_id;
			
			update bel.t_assureayantdroit
			set datemaj = sysdate,
				t_adresse_id = lintadresse,
				t_organismeamo_id = lintoao,
				t_organismeamc_id = lintoac,
				t_organismeat_id = lintoat,
				categoriebenefoa = idcategoa,
				categoriebenefoc = idcategoc,
				categoriebenefat = idcategat,
				t_assurabiliteoa_id = lintao,
				t_assurabiliteoc_id = lintac,
				t_assurabiliteat_id = lintat,
				versionassurabilite = aversionassur,
				certificatcartesis = acertificat,
				numerocartesis = to_number(anumcartesis),
				datedernierelecturesis = adernierelecture,
				datedebutvaliditepiece = adatedebvalpiece,
				datefinvaliditepiece = adatefinvalpiece,
				datedernierevisite = adatedernierevisite,
				natpiecejustifdroit = anatpiecejustifdroit,
				code_court = acodecourt,
				identifiant_externe = aidentifiant_externe
			where t_aad_id = t_client_id;
			
			delete from bel.t_adresse where t_adresse_id = intAdresseBEL;	
			delete from bel.t_assurabilite where t_assurabilite_id = intAssurOABEL;			
			delete from bel.t_assurabilite where t_assurabilite_id = intAssurOCBEL;
			delete from bel.t_assurabilite where t_assurabilite_id = intAssurATBEL;
			
			if afusion = '1' then
			  insert into migration.t_fusion_client(t_client_id, etat)
			  values(t_client_id, 'F');
			end if;			
		else
			if afusion = '1' then
			  insert into migration.t_fusion_client(t_client_id, etat)
			  values(t_client_id, 'R');
			end if;		
		end if;		

		insert into tw_client(
			client,
			cli_lgpi)
		values(
			aclient,
			t_client_id);

		return t_client_id;
	exception
		when others then
			rollback to client;
			raise;
	end creationclient;


	function creationprofilremise(
		aprofilremise in varchar2,
		adefaultofficine in varchar2,
		alibelle in varchar2,
		atauxreglegen in number,
		atyperistourne in varchar2,
		aplafondristourne in number,
		t_profilremise_id out number) return number
	as
		idprof bel.t_profilremise.t_profilremise_id%type;
	begin
		savepoint profilrem;

		if (adefaultofficine = 1) then
			begin
				select t_profilremise_id 
				into idprof 
				from bel.t_profilremise 
				where libelle like 'officine';

				if (idprof is not null) then
					update bel.t_parametres set valeur = '' where cle = 'remise.defaut';
					delete from bel.t_profilremise where libelle like 'officine';
				end if;
			exception
				when no_data_found then
					idprof := null;
			end;
		end if;

		insert into bel.t_profilremise(
			t_profilremise_id,
			libelle,
			sur_vd,
			sur_factretro,
			/*sur_factciale,*/ /* v1.02 b5 patch3 => retirer à partir de la v1.03*/
			sur_ordonnance,
			sur_avanceproduit,
			sur_prodprogavantage,
			incl_remboursables_vd,
			incl_remboursables_ordo,
			incl_rembourses_ordo,
			/*incl_remb_non_rembourses_ordo,*/
			rist_sur_regul_avance,
			taux,
			type_ristourne,
			mt_plafond_rist,
			datemaj)
		values
			(bel.seq_id_profilremise.nextval,
			alibelle,
			1,
			0,
			/* 0, */
			0,
			0,
			0,
			0,
			0,
			0,
			/*0,*/
			0,
			atauxreglegen,
			nvl(atyperistourne,'0'),
			aplafondristourne,
			to_date(to_char(sysdate, 'dd/mm/yyyy') || ' 00:00', 'dd/mm/yyyy hh24:mi'))
		returning t_profilremise_id into t_profilremise_id;

		if (adefaultofficine = 1) then
			update bel.t_parametres
			set valeur = t_profilremise_id
			where cle = 'remise.defaut';
		end if;

--		insert into tw_profilremise(profilremise,prrm_lgpi) values(aprofilremise, t_profilremise_id);

		return t_profilremise_id;
	exception
		when others then
			rollback to profilrem;
			raise;
	end creationprofilremise;

	function creationprofilremisesuppl(
		aprofilremisesuppl in varchar2,
		aprofilremise in varchar2,
		atyperegle in number,
		aordre in number,
		atyperist in varchar2,
		aplafrist in number,
		ataux in number,
		acatprod in varchar2,
		ausage in varchar2,
		aclassint in number,
		t_profilremisesuppl_id out number) return number
	as
		idcatprod bel.t_categorie_produit.t_categorie_produit_id%type;
	begin
		savepoint profremsuppl;

		insert into bel.t_profilremisesuppl(
			t_profilremisesuppl_id,
			t_profilremise_id,
			type_regle,
			no_ordre,
			type_ristourne,
			mt_plafond_rist,
			taux,
			datemaj,
			maintien_type_ristourne)
		values
			(bel.seq_id_profilremisesuppl.nextval,
			aprofilremise,
			atyperegle,
			aordre,
			atyperist,
			aplafrist,
			ataux,
			to_date(to_char(sysdate, 'dd/mm/yyyy') || ' 00:00', 'dd/mm/yyyy hh24:mi'),
			'0')
		returning t_profilremisesuppl_id into t_profilremisesuppl_id;

		if ((aclassint is not null) and (aclassint > 0) and (t_profilremisesuppl_id is not null)) then
			insert into bel.t_profilremisesuppl_classif(t_profilremisesuppl_id,t_classificationinterne_id) 
			values(t_profilremisesuppl_id,aclassint);
		end if;

		if ((acatprod is not null) and (t_profilremisesuppl_id is not null)) then
			select t_categorie_produit_id 
			into idcatprod 
			from bel.t_categorie_produit 
			where code = acatprod;
			
			if (idcatprod is not null) then
				insert into bel.t_profilremisesuppl_catprod(t_profilremisesuppl_id,t_categorie_produit_id) 
				values(t_profilremisesuppl_id,idcatprod);
			end if;
		end if;

--	insert into tw_profilremisesuppl(profilremisesuppl, prrmsup_lgpi) values(aprofilremisesuppl, t_profilremisesuppl_id);

		return t_profilremisesuppl_id;
	exception
		when others then
			rollback to profremsuppl;
			raise;
	end creationprofilremisesuppl;

	procedure creer_pathologie(
		aidclient in integer,
		apathologie in varchar2,
		afusion in char) 
	as
		intep integer;
		etat_c char(1);
	begin
		savepoint pathologie;

		select etat
		into etat_c
		from migration.t_fusion_client
		where t_client_id = AIDClient;
		
		if ((etat_c = 'C' and afusion='1') or (afusion='0'))  then
			begin
				intep := etatspathologiques(apathologie);
			exception
				when no_data_found then
					null;
			end;

			insert into bel.t_etatpathoassaad(
				t_etatpathoassaad_id,
				t_aad_id,
				t_delphi_etat_patho_id,
				datemaj)
			values(bel.seq_id_etatpathoassaad.nextval,
				aidclient,
				intep,
				sysdate);
		end if;
	exception
		when others then
			rollback to pathologie;
			raise;
	end;

	procedure creer_allergie_atc(
		aidclient in integer,
		aclassificationatc in varchar2, 
		afusion in char) 
	as
		intcl integer;
		etat_c char(1);		
	begin
		savepoint allergie_atc;

		select etat
		into etat_c
		from migration.t_fusion_client
		where t_client_id = AIDClient;
		
		if ((etat_c = 'C' and afusion='1') or (afusion='0')) then
			begin
				intcl := classificationsatc(aclassificationatc);
			exception
				when no_data_found then
					null;
			end;

			insert into bel.t_allergiedelphiatcassaad(t_allergiedelphiatcassaad_id,
				t_aad_id,
				t_delphi_classifatc_id,
				datemaj)
			values(bel.seq_id_etatpathoassaad.nextval,
				aidclient,
				intcl,
				sysdate);
		end if;
	exception
		when others then
			rollback to allergie_atc;
			raise;
	end;

	procedure majcpas(
		aorganismeoa in number,
		aorganismeoc in number,
		adestinataire_facture in number) 
	as
	begin
		savepoint orga;

		update bel.t_organismeamo set t_destinataire_fact_id=adestinataire_facture where t_organismeamo_id=aorganismeoa;
		update bel.t_organismeamc set t_destinataire_fact_id=adestinataire_facture where t_organismeamc_id=aorganismeoc;

	exception
		when others then
			rollback to orga;
			raise;
	end majcpas;	
	
begin
	for cr in (select code, t_delphi_etat_patho_id from bel.t_delphi_etat_patho) loop
		etatspathologiques(cr.code) := cr.t_delphi_etat_patho_id;
	end loop;

	for cr in (select code, t_delphi_classifatc_id from bel.t_delphi_classifatc) loop
		classificationsatc(cr.code) := cr.t_delphi_classifatc_id;
	end loop;
end;
/