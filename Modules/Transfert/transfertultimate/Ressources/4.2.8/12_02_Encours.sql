create or replace package body migration.pk_encours as

	function creationavanceproduit(
		alitige in varchar2,
		aclient in number,
		aproduit in varchar2,
		atypelitige in number,
		adescriptionlitige in varchar2,
		anompdt in varchar2,
		acdbu in varchar2,
		anoord in varchar2,
		aprixclient in number,
		aqtedelivree in number,
		aqtemanquante in number,
		adatevente in date,
		aisfacture in varchar2,
		Agtin in varchar2,
		Anumero_serie in varchar2,
		t_litige_id out number) return number
	as
		idop bel.t_operateur.t_operateur_id%type;
		idposte bel.t_postedetravail.t_id_postedetravail%type;
		idacte bel.t_acte.t_acte_id%type;
		idligvte bel.t_lignevente.t_lignevente_id%type;
		iddevise bel.t_devise.t_devise_id%type;
		idmodregl bel.t_modereglement.t_modereglement_id%type;
		idfact bel.t_facture.t_facture_id%type;
		idtva bel.t_tva.t_tva_id%type;
		nomcli bel.t_assureayantdroit.nom%type;
		prenomcli bel.t_assureayantdroit.prenom%type;
		idaad bel.t_assureayantdroit.t_aad_id%type;
		idaaddeb bel.t_assureayantdroit.t_aad_id%type;
		idaaddest bel.t_facture.t_aad_destinataire_id%type;
		idcli bel.t_facture.t_client_id%type;
		typeecrit bel.t_encaissement.type_ecriture%type;
		payeur bel.t_facture.payeur%type;
		numfact bel.t_facture.numero_facture%type;
		idcollectivite bel.t_collectivite.no_collectivite%type;
		idacteenc bel.t_encaissement.t_acte_encaisse_id%type;
		idencfact bel.t_encaissement.t_facture_id%type;
		idencfactenc bel.t_encaissement.t_facture_encaisse_id%type;
		preffact bel.t_facturation.numero_2%type;
		idfacturation bel.t_facturation.t_facturation_id%type;
		tauxtva bel.t_lignevente.tauxtva%type;
		icompdepot1 integer;
		icompdepot2 integer;
		icompdepot3 integer;
		i integer;
		j integer;

		nblignesvteacreer number;

		lproduit bel.t_produit%rowtype;
		desig bel.t_produit.designation%type;
		lstock bel.t_produitgeographique%rowtype;
		dejafacture varchar2(1);

		cursor colid(idaad number) is 
			select c.no_collectivite 
			from bel.t_collectivite c 
			where c.t_aad_id = idaad;
			
		etat_c char(1);
	begin
		savepoint litige;

			idacte := null;
			idligvte := null;
			idcollectivite := null;
			idop := 0;
			idposte := 0;
			iddevise := 0;
			idmodregl := 0;
			idfact := 0;
			idtva := 0;
			nomcli := null;
			prenomcli := null;
			desig := null;
			idaad := null;
			idaaddeb := null;
			idaaddest := null;
			idcli := null;
			typeecrit := ' ';
			payeur := null;
			numfact := null;
			idacteenc := null;
			idencfact := null;
			idencfactenc := null;
			preffact := null;
			idfacturation := null;
			tauxtva := null;
			icompdepot1 :=0;
			icompdepot2 :=0;
			icompdepot3 :=0;

			select t_operateur_id into idop from bel.t_operateur where codeoperateur like '.';
			select min(t_id_postedetravail) into idposte from bel.t_postedetravail ;
			select t_devise_id into iddevise from bel.t_devise where codedevise like 'EUR';
			-- select t_tva_id into idtva from bel.t_tva where tauxtva = 0;
			--select t_tva_id into idtva from bel.view_produit_tarif_actif where t_produit_id = aproduit;
			
			select t_tva_id 
			into idtva 
			from bel.t_tarif_produit 
			where t_produit_id = aproduit 
			  and date_valid_debut = (select max (date_valid_debut) 
									  from bel.t_tarif_produit tar 
									  where tar.t_produit_id = t_tarif_produit.t_produit_id 
										and date_valid_debut <= sysdate);

			if ((idtva is not null) and (idtva <> 0)) then
				select tauxtva 
				into tauxtva 
				from bel.t_tva 
				where t_tva_id = idtva;
			else
				tauxtva := 0;
			end if;

			select nom, prenom 
			into nomcli,prenomcli 
			from bel.t_assureayantdroit 
			where t_aad_id = aclient;

			select prod.* 
				into lproduit 
				from bel.t_produit prod 
				where prod.t_produit_id = aproduit;

			select count(*) 
			into icompdepot1 
			from bel.t_produitgeographique stk 
			where stk.t_produit_id = aproduit 
			  and stk.t_depot_id in (select t_depot_id from bel.t_depot where libelle like 'PHARMACIE' or libelle like 'APOTHEEK');

			if (icompdepot1>0) then		
				select stk.* 
				into lstock 
				from bel.t_produitgeographique stk 
				where stk.t_produit_id = aproduit 
				  and stk.t_depot_id in (select t_depot_id from bel.t_depot where libelle like 'PHARMACIE' or libelle like 'APOTHEEK')  and stk.priorite = 1;
			end if;

			select count(*) 
			into icompdepot2 
			from bel.t_produitgeographique stk 
			where stk.t_produit_id = aproduit 
			  and stk.t_depot_id in (select t_depot_id from bel.t_depot where libelle like 'ROBOT');

			if (icompdepot2>0) then
				select stk.* 
				into lstock 
				from bel.t_produitgeographique stk 
				where stk.t_produit_id = aproduit 
				  and stk.t_depot_id in (select t_depot_id from bel.t_depot where libelle like 'ROBOT') and stk.priorite = 1;
			end if;

			select count(*) 
			into icompdepot3 
			from bel.t_produitgeographique stk 
			where stk.t_produit_id = aproduit 
			  and stk.t_depot_id in (select t_depot_id from bel.t_depot where libelle like 'RESERVE');

			if (icompdepot3>0) then
				select stk.* 
				into lstock 
				from bel.t_produitgeographique stk 
				where stk.t_produit_id = aproduit 
				  and stk.t_depot_id in (select t_depot_id from bel.t_depot where libelle like 'RESERVE') and stk.priorite = 1;
			end if;

			insert into bel.t_acte(
				t_acte_id,
				t_operateur_id,
				t_postedetravail_id,
				typeacte,
				termine,
				valide,
				signe,
				t_tiroircaisse_id,
				dateacte)
			values(
				bel.seq_id_acte.nextval,
				idop,
				idposte,
				1, /* 1 = facturation, 2 = rétrocession */
				1,
				0,
				0,
				0,
				nvl(adatevente,to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY')));

			select bel.seq_id_acte.currval into idacte from dual;

			open colid(aclient);
			fetch colid into idcollectivite;
			close colid;


			/* if ((aisfacture is not null) and (aisfacture = '1')) then
			dejafacture := '1';
			else
			dejafacture := '0';
			end if; */

			dejafacture := '1';
			nblignesvteacreer := aqtedelivree;
			i :=1;
			j :=1;


			while nblignesvteacreer > 0 loop
				nblignesvteacreer := nblignesvteacreer - 1;

				if ((idcollectivite is not null) and (idcollectivite <> 0)) then
					typeecrit := 'D';
					payeur := 'C';
					idaaddest := idcollectivite;
					idaad := idcollectivite;
					idaaddeb := idcollectivite;
					/* idcli := idcollectivite; */
					idcli := aclient;

					select min(t_modereglement_id) into idmodregl from bel.t_modereglement where type = 5; /* 5 = crédit */

					if (dejafacture = '1') then
						select valeur 
						into preffact 
						from bel.t_parametres 
						where cle like 'facturation.prefixe';

						insert into bel.t_facturation(
							t_facturation_id, numero_1,  numero_2,
							date_edition, date_echeance, 
							date_maj, date_export_excel,
							type_edition, typedestinataire)
						values(
							bel.seq_id_facturation.nextval, preffact, bel.seq_numero2_facturation.nextval,
							to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY'), to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY'),
							to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY'), to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY'),
							0, 1);

						select bel.seq_id_facturation.currval into idfacturation from dual;
					else
						idfacturation := null;
					end if;
			
					numfact := 0;
					idacteenc := idacte;
				else
					select min(t_modereglement_id)  into idmodregl 
					from bel.t_modereglement 
					where type = 1; /* 1 = espèce */

					payeur := null;
					typeecrit := ' ';
					idaaddest := null;
					idaad := null;
					idaaddeb := null;
					numfact := null;
					idacteenc := null;
					idfacturation := null;
					idcli := aclient;
				end if;

				insert into bel.t_facture(
					t_facture_id, date_maj, id_acte, t_operateur_id, etat_facture,
					date_execution, code_operateur, the_type_facturation, total_facture, montant_assure,
					remise, type_remise, total_remise, exoneration_tva, edition_cbl,
					t_client_id, nom_client, prenom_client, retarification_enattente, edition_prix_surbl,
					total_remb_amo, total_remb_amc, total_remb_amotransmis, total_remb_amctransmis, t_aad_destinataire_id,
					payeur, numero_facture, t_facturation_id)
				values(bel.seq_id_facture.nextval, to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY'), idacte, idop, 'V',
					nvl(adatevente,to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY')), '.', 4, aprixclient, aprixclient,
					0, 'P', 0, '0', '0',
					idcli, nomcli, prenomcli, '0', '0',
					0, 0, 0, 0, idaaddest,
					payeur, numfact, idfacturation);

				select bel.seq_id_facture.currval into idfact from dual;

				if (anompdt is null) then
					desig := lproduit.designation;
				else
					desig := anompdt;
				end if;

				insert into bel.t_lignevente( t_lignevente_id, qtefacturee, noordonnancier, qtedelivree, qtemanquante,
					datemajlignevente, t_facture_id, typefacturation, t_produit_id, t_tva_id,
					prixvente, baseremboursement, montantligne, rembamo, rembamc,
					codecip, paht_brut, tauxtva, t_legislation_id, t_type_ordonnancier_id,
					saisir_cbu, saisir_nolot, suivi_interessement, t_zonegeo_id, veterinaire,
					delailait, delaiviande, pvttc_fichier, paht_remise, pamp,
					pvht, pvhtremise, quantite_regul_va_payee, designation_fr, designation_nl,
					t_categorie_produit_id, edition_704, edition_bvac, quantite_differee, dette_cbu, 
					dette_nolot, remisedirecte, ristournefinannee, prixclient, type_demande_ecrite, 
					compresse_chimique, mtassureht, typepriseenchargeclient)
				values(bel.seq_id_lignevente.nextval,  1, /* aqtedelivree, */ 0, /* pas d'ordonnance */ 1, /* aqtedelivree,*/ aqtemanquante,
					to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY'), idfact, 4, /* 4 => avance produit = manque ordo */ aproduit, idtva,
					aprixclient, 0, aprixclient, 0, 0,
					lproduit.codecip, aprixclient, tauxtva, lproduit.t_legislation_id, lproduit.t_type_ordonnancier_id,
					decode(trim(regexp_substr(acdbu, '[^;]+', 1, i)),null,'0','1'), '0', '0', lstock.t_zonegeo_id, '0',
					0, 0, aprixclient, aprixclient, 0,
					(aprixclient / (1 + (tauxtva/100))), (aprixclient / (1 + (tauxtva/100))), 0, desig, desig,
					lproduit.t_categorie_produit_id, '0', '0', 0, '0',
					'0', 0, 0, aprixclient, 0, 
					'0', (aprixclient / (1 + (tauxtva/100))), 0)
					returning t_lignevente_id into t_litige_id;

				select bel.seq_id_lignevente.currval into idligvte from dual;

				insert into bel.t_ventilation_tva_facture(
					t_ventilation_tva_facture_id, t_facture_id, montant_ht, t_tva_id, montant_ttc,
					montant_tva, taux_tva, remise_ttc, remise_ht, remise_tva,
					remb_ttc, remb_ht, ristourne_ttc, ristourne_ht, ristourne_tva,
					mtclient_ttc, mtclient_ht, rembamo_ht, rembamo_ttc, rembamc_ht,
					rembamc_ttc)
				values(
					bel.seq_id_ventilation.nextval, idfact, (aprixclient / (1 + (tauxtva/100))), idtva, aprixclient, 
					aprixclient - (aprixclient / (1 + (tauxtva/100))), tauxtva, 0, 0, 0, 
					0, 0, 0, 0, 0, 
					aprixclient, (aprixclient / (1 + (tauxtva/100))), 0, 0, 0,
					0);

				--si il y a plusieurs cbu et gtin/num_serie dans une seule avnce, on commence par les cbu et on finit par le reste
				if (trim(regexp_substr(acdbu, '[^;]+', 1, i)) is not null) then
					insert into bel.t_lignevente_cbu(
						t_lignevente_cbu_id,
						code,
						t_lignevente_id,
						is_noserie,
						datemaj)
					values(
						bel.seq_id_lignevente_cbu.nextval,
						trim(regexp_substr(acdbu, '[^;]+', 1, i)),
						idligvte,
						0,
						to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY'));

						i:=i+1;

				elsif ( (trim(regexp_substr(Agtin, '[^;]+', 1, j)) is not null) and (trim(regexp_substr(Anumero_serie, '[^;]+', 1, j)) is not null) ) then
						insert into bel.t_lignevente_cbu(
							t_lignevente_cbu_id,
							gtin,
							code,
							t_lignevente_id,
							is_noserie,
							datemaj)
						values(
							bel.seq_id_lignevente_cbu.nextval,
							trim(regexp_substr(Agtin, '[^;]+', 1, j)),
							trim(regexp_substr(Anumero_serie, '[^;]+', 1, j)),
							idligvte,
							1,
							to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY'));
							
							j:=j+1;
				end if;
			
			end loop;

			/*
			sans insérer de lignes d'encaissement, on considère que le manque ordonnance est déjà payé.
			ds le cas, manques ordonnances facturés non payés cela pose problème.
			*/
			/*
			if ((idcollectivite is not null) and (idcollectivite <> 0)) then
			idencfact := idfact;
			idencfactenc := idfact;
			else
			idencfact := null;
			idencfactenc := null;
			end if;

			if ((idcollectivite is null) or (dejafacture = '0')) then
			insert into bel.t_encaissement(t_acte_id,
										 n_ordre,
										 montant,
										 t_devise_id,
										 t_modereglement_id,
										 t_postedetravail_id,
										 datemaj,
										 montantdevise,
										 codeoperateur,
										 dateecriture,
										 type_ecriture,
										 lettre,
										 valide_releve,
										 soumisareleve,*/ /* valeur 1 qd ordonnance en suspens (pour manque carte sis, manque attestation) */ /*
										 t_aad_debiteur_id,
										 t_aad_id,
										 t_facture_id,
										 t_facture_encaisse_id,
										 t_acte_encaisse_id)
			values(idacte,
			1,
			aprixclient,
			iddevise,
			idmodregl,
			idposte,
			to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY'),
			aprixclient,
			'1',
			nvl(adatevente,to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY')),
			typeecrit,
			'0',
			0,
			'0',
			idaaddeb,
			idaad,
			idencfact,
			idencfactenc,
			idacteenc);
			end if; */
	--	end if;
		
		Return t_litige_id;
	exception
		when others then
			rollback to litige;
			raise;
	end creationavanceproduit;

	function creationdeldif(
		adeldif in varchar2,
		aproduit in number,
		aclient in number,
		amedecin in varchar2,
		anoordon in varchar2,
		adateprescr in date,
		adatedeliv in date,
		aqttdiff in number,
		adateordon in date,
		atypedeldif in number,
		t_deldif_id out number) return number
	as
		idposte bel.t_postedetravail.t_id_postedetravail%type;
		idop bel.t_operateur.t_operateur_id%type;
		idacte bel.t_acte.t_acte_id%type;
		etat_c char(1);
	begin
		savepoint deldif;

			idacte := null;
			idop := 0;
			idposte := 0;

			select t_operateur_id into idop from bel.t_operateur where codeoperateur like '.';
			select min(t_id_postedetravail) into idposte from bel.t_postedetravail ;
						
			if ((idop <> 0) and (idposte <> 0)) then
				insert into bel.t_acte(
					t_acte_id,
					typeacte,
					termine,
					dateacte,
					t_operateur_id,
					t_postedetravail_id)
				values(
					bel.seq_id_acte.nextval,
					1,
					1,
					adatedeliv,
					idop,
					idposte);

				select bel.seq_id_acte.currval into idacte from dual;
			end if;

			if (idacte is not null) then
				insert into bel.t_delivrancediff(
					t_delivrancediff_id,
					t_aad_id,
					t_praticienprive_id,
					t_acte_id,
					no_ordonnance,
					dateprescription,
					datemaj,
					dateordonnance,
					quantite_differee,
					t_produit_id,
					reprise_renouv) 
				values(
					bel.seq_delivrancediff.nextval,
					aclient,
					amedecin,
					idacte,
					anoordon,
					adateprescr,
					to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY'),
					adateordon,
					aqttdiff,
					aproduit,
					decode(atypedeldif, 3, 1, 0))
				returning t_delivrancediff_id into t_deldif_id;

				return t_deldif_id;
			end if;
	--	end if;
	exception
		when others then
			rollback to deldif;
			raise;
	end creationdeldif;


	function creationcredit(
		acredit in varchar2,
		amontant in number,
		adatecredit in date,
		aclient in number,
		t_acte_id out number) return number
	as
		idop bel.t_operateur.t_operateur_id%type;
		idposte bel.t_postedetravail.t_id_postedetravail%type;
		idacte bel.t_acte.t_acte_id%type;
		iddevise bel.t_devise.t_devise_id%type;
		idmodregl bel.t_modereglement.t_modereglement_id%type;
		idfact bel.t_facture.t_facture_id%type;
		idtva bel.t_tva.t_tva_id%type;
		nomcli bel.t_assureayantdroit.nom%type;
		prenomcli bel.t_assureayantdroit.prenom%type;
		t_client_id bel.t_assureayantdroit.t_aad_id%type;
		
		etat_c char(1);
	begin
		savepoint credit;

			idacte := null;
			idop := 0;
			idposte := 0;
			iddevise := 0;
			idmodregl := 0;
			idfact := 0;
			idtva := 0;
			nomcli := null;
			prenomcli := null;

			select t_operateur_id into idop from bel.t_operateur where codeoperateur like '.';
			select min(t_id_postedetravail) into idposte from bel.t_postedetravail ;
			select t_devise_id into iddevise from bel.t_devise where codedevise like 'EUR';
			select min(t_modereglement_id) into idmodregl from bel.t_modereglement where type = 5;
			select t_tva_id into idtva from bel.t_tva where tauxtva = 6;
			select nom,prenom into nomcli,prenomcli from bel.t_assureayantdroit where t_aad_id = aclient;

			/* type_acte = 1 => facturation, type_acte = 2 => rétrocession */
			insert into bel.t_acte(
				t_acte_id,
				t_operateur_id,
				t_postedetravail_id,
				typeacte,
				termine,
				signe,
				valide,
				dateacte)
			values(
				bel.seq_id_acte.nextval,
				idop,
				idposte,
				'1',
				'1',
				'0',
				'0',
				nvl(adatecredit,to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY')))
			returning t_acte_id into t_acte_id;

			select bel.seq_id_acte.currval into idacte from dual;

			insert into bel.t_encaissement(
				t_acte_id,
				n_ordre,
				montant,
				t_devise_id,
				t_modereglement_id,
				datemaj,
				montantdevise,
				dateecriture,
				type_ecriture,
				lettre,
				valide_releve,
				soumisareleve,
				t_aad_debiteur_id)			
			values(
				idacte,
				1,
				amontant,
				iddevise,
				idmodregl,
				to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY'),
				amontant,
				nvl(adatecredit,to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY')),
				'D',
				'0',
				0,
				'0',
				aclient);

			insert into bel.t_facture(
				t_facture_id,
				date_maj,
				id_acte,
				t_operateur_id,
				numero_facture,
				date_execution,
				code_operateur,
				the_type_facturation,
				exoneration_tva,
				edition_cbl,
				etat_facture,
				total_facture,
				montant_assure,
				remise,
				type_remise,
				total_remise,
				/*frais_port,*/
				t_client_id,
				edition_prix_surbl,
				retarification_enattente,
				nom_client,
				prenom_client)
			values(
				bel.seq_id_facture.nextval,
				to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY'),
				idacte,
				idop,
				0, -- vente directe donc => 0
				nvl(adatecredit,to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY')),
				'.',
				3,
				'0',
				'0',
				'V',
				amontant,
				amontant,
				0,
				'P',
				0,
				/* 0, */
				aclient,
				'0',
				'0',
				nomcli,
				prenomcli);

			select bel.seq_id_facture.currval into idfact from dual;

			/*insert into bel.t_lignevente(t_lignevente_id,qtemanquante,noordonnancier,qtefacturee,qtedelivree,datemajlignevente,t_facture_id,typefacturation,
			t_produit_id,t_tva_id,prixvente,montantligne,baseremboursement,rembamo,rembamc,*/ /* ,rembamotransmis,  rembamctransmis, */
			/* tm_oa,tm_oc, */ /* codecip,paht_brut,tauxtva,saisir_cbu,saisir_nolot,suivi_interessement,veterinaire,delailait,delaiviande,
			pvttc_fichier,paht_remise,pamp,pvht,pvhtremise,designation_fr,designation_nl,edition_704,edition_bvac,quantite_differee,
			dette_cbu,dette_nolot,remisedirecte,ristournefinannee,prixclient,compresse_chimique,mtassureht)
			values(bel.seq_id_lignevente.nextval,0,0,1,1,to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY'),idfact,3,
			null,idtva,amontant,amontant,0,0,0,*/ /* 0, 0, */ /* 0,0,*/ /*null,amontant,6,'0','0','0','0',0,0,amontant,amontant,0,amontant,amontant,
			'reprise crédit','reprise crédit','0','0',0,'0','0',0,0,amontant,'0',0);*/

			update bel.t_assureayantdroit
			set commindividuelbloquant = 1
			where t_aad_id = aclient;
	--	end if;

		return t_acte_id;
	exception
		when others then
			rollback to credit;
			raise;
	end creationcredit;

	function creationattestation(
		aattestation in varchar2,
		aspeid in number,
		acliid in number,
		anumatt in varchar2,
		ascanne in varchar2,
		adatelimite in date,
		acatremb in number,
		acondremb in number,
		anbcond in number,
		anbmaxcond in number,
		acodassursocial in varchar2,
		t_attestation_id out number) return number
	as
		catremb bel.t_remboursement.type_cat_remb%type;
		condremb bel.t_remboursement.type_cond_remb%type;
	begin
		catremb := null;
		condremb := null;

		if acatremb = 99 then
			/* select distinct type_cat_remb into catremb from bel.t_remboursement remb, bel.t_type_assurance_sociale asssoc
			where remb.t_produit_id = aspeid and remb.t_type_assurance_sociale_id = asssoc.t_type_assurance_sociale_id
			and asssoc.code = acodassursocial; */
			catremb := null;
		else
			catremb := acatremb;
		end if;

		if acondremb = 99 then
			/*select distinct type_cond_remb into condremb from bel.t_remboursement remb, bel.t_type_assurance_sociale asssoc
			where remb.t_produit_id = aspeid and remb.t_type_assurance_sociale_id = asssoc.t_type_assurance_sociale_id
			and asssoc.code = acodassursocial; */
			condremb := 1;
		else
			condremb := acondremb;
		end if;

		insert into bel.t_attestationremb(
			t_attestationremb_id,
			t_produit_id,
			t_aad_id,
			noattestation,
			scanne,
			datefinvalidite,
			datemajattestationremb,
			type_cat_remb,
			type_condition_remb,
			nb_conditionnement,
			nb_conditionnementmax)
		values(
			bel.seq_attestationremb.nextval,
			aspeid,
			acliid,
			anumatt,
			ascanne,
			adatelimite,
			to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY'),
			catremb,
			condremb,
			anbcond,
			anbmaxcond)
		returning t_attestationremb_id into t_attestation_id;

		return t_attestation_id;
	exception
		when others then
		raise;
	end creationattestation;
end;
/