create or replace package body migration.pk_praticiens as

	specialites pk_commun.tab_identifiants; 
	specialitesdentiste pk_commun.tab_identifiants; 

	function creer_praticien (
		anom in varchar2,
		aprenom in varchar2,
		acommentaires in varchar2,
		aidentifiant in varchar2,
		amatricule in varchar2,
		aspecialite in varchar2,
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
		adentiste in varchar2,
		amedecinfrontalier in varchar2,
		acategorie in number,
		afusion in char) return number
	as
		intadresse bel.t_adresse.t_adresse_id%type;
		idspecialite bel.t_specialite.t_specialite_id%type;
		idpraticien bel.t_praticienprive.t_praticienprive_id%type;
		strprenom bel.t_praticienprive.prenom%type;
	begin
		-- sauvegarde données déjà créée
		savepoint praticien;

		if afusion = '0' then
		  idpraticien := 0;
		else
			if aidentifiant is not null then
				begin
					select t_praticienprive_id 
					into idpraticien
					from bel.t_praticienprive 
					where identification=aidentifiant;
				exception
					when no_data_found or too_many_rows then 
						idpraticien := 0;    
 				end;
			else
				idpraticien := 0;
			end if;
		end if;
		
		
------------------------------Spécial MULTIPHARMA - Fusion des medecins --- Est ce qu on le remet ???
/*		if aidentifiant is not null and aidentifiant <> 999999999999 and acategorie =1 then
			begin
				select t_praticienprive_id 
				into idpraticien
				from bel.t_praticienprive 
				where identification=aidentifiant;
			exception
				when no_data_found or too_many_rows then 
					idpraticien := 0;    
			end;
		else
			idpraticien := 0;
		end if;
*/
		idspecialite := null;
		if (idpraticien = 0) and (aspecialite is not null) then
			--recherche de l'id de la specialité
			begin
				if adentiste='0' then
					idspecialite := specialites(aspecialite);
				else 
					idspecialite := specialitesdentiste(aspecialite);
				end if;
			exception
				when no_data_found then
					idspecialite := null;
			end;
--end if 		
			intadresse := pk_commun.creer_adresse(arue1, arue2, acodepostal, anomville, atelpersonnel, atelstandard, atelmobile, aemail, afax, acodepays);
--		if (idpraticien = 0) then  -- va avec la fusion de medecin
			--insertion du medecin
			insert into bel.t_praticienprive(
				t_praticienprive_id,
				nom,
				prenom,
				commentaires,
				datemodification,
				t_specialite_id,
				t_adresse_id,
				identification,
				categorie)
			values
				(bel.seq_id_praticien.nextval,
				anom,
				aprenom,
				acommentaires,
				sysdate,
				idspecialite,
				intadresse,
				aidentifiant,
				acategorie)
			returning t_praticienprive_id into idpraticien;     
		end if; 

		return idpraticien;  
	exception
		when others then
			rollback to praticien;
			raise;
	end;

begin
	for cr_spec in (select t_specialite_id, code from bel.t_specialite where is_dentiste='0') loop
		specialites(cr_spec.code) := cr_spec.t_specialite_id;
	end loop;

	for cr_spec in (select t_specialite_id, code from bel.t_specialite where is_dentiste='1') loop
		specialitesdentiste(cr_spec.code) := cr_spec.t_specialite_id;
	end loop;
end;
/