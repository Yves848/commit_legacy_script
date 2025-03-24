set sql dialect 3;

/* ********************************************************************************************** */
create or alter procedure ps_importer_conversion_org_amo(
  ALigne varchar(2048))
as
declare variable strOrganismeAMO varchar(50);
declare variable strIdNat varchar(9);
declare variable chRepris char(1);
begin
  strOrganismeAMO = trim(substring(ALigne from 1 for 50));
  strIdNat = trim(substring(ALigne from 51 for 9));
  chRepris = substring(ALigne from 60 for 1);
  
  execute procedure ps_maj_organisme_amo(:strOrganismeAMO, :chRepris, :strIdNat);
end;

create or alter procedure ps_importer_conversion_couv_amo(
  ALigne varchar(2048))
as
declare variable strCouvertureAMO varchar(50);
declare variable chRepris char(1);
declare variable chALD char(1);
declare variable strCodeCouverture varchar(5);
begin
  strCouvertureAMO  = trim(substring(ALigne from 1 for 50));
  chRepris  = substring(ALigne from 51 for 1);
  chALD = substring(ALigne from 52 for 1);
  strCodeCouverture = substring(ALigne from 53 for 5);
  
  execute procedure ps_maj_couverture_amo(:strCouvertureAMO, :chRepris, :chALD, :strCodeCouverture);
end;

create or alter procedure ps_importer_conversion_compte(
  ALigne varchar(2048))
as
declare variable strCompte varchar(50);
declare variable chRepris char(1);
declare variable chCollectif char(1);
declare variable strClient varchar(50);
begin
  strCompte = trim(substring(ALigne from 1 for 50));
  chRepris = substring(ALigne from 51 for 1);
  chCollectif = substring(ALigne from 52 for 1);
  strClient = trim(substring(ALigne from 53 for 50));
  
  execute procedure ps_maj_compte(:strCompte, :chRepris, :chCollectif, :strClient);
end;

create or alter procedure ps_exporter_conversions_org_amo(
  AFichier integer)
as
declare variable s varchar(100);
begin
  for select 
    rpad(o.t_organisme_id, 50, ' ' ) || 
    coalesce(rr.code, '  ') || coalesce(oref.caisse_gestionnaire, '   ') || coalesce(oref.centre_gestionnaire, '    ') ||  
    o.repris
  from
    t_organisme o
    left join t_ref_organisme oref on (oref.t_ref_organisme_id = o.t_ref_organisme_id)
    left join t_ref_regime rr on (rr.t_ref_regime_id = oref.t_ref_regime_id)
  where
   o.type_organisme = '1'
  into :s do
    f_ecrire_fichier_texte(AFichier, s);
end;

create or alter procedure ps_exporter_conversions_cou_amo(
  AFichier integer)
as
declare variable s varchar(100);
begin
  for select
        rpad(c.t_couverture_amo_id, 50, ' ') || c.repris || c.ald || cr.code_couverture
      from
        t_couverture_amo c
        inner join t_ref_couverture_amo cr on (cr.t_ref_couverture_amo_id = c.t_ref_couverture_amo_id)
      into :s do
    f_ecrire_fichier_texte(AFichier, s);      
end;

create or alter procedure ps_exporter_conversions_compte(
  AFichier integer)
as
declare variable s varchar(150);
begin
  for select
       rpad(t_compte_id, 50, ' ') || repris || collectif || rpad(t_client_id, 50, ' ')
     from
       t_compte
     into :s do
    f_ecrire_fichier_texte(AFichier, s);       
end;

/* ********************************************************************************************** */
create or alter procedure ps_impexp_conversion(
  ADonnee integer,
  AFichier varchar(255),
  AImpExp char(1))
as
declare variable f integer;
declare variable fin integer;
declare variable s varchar(2048);
begin
  if (AImpExp = '0') then
  begin
    fin = 0; f = f_ouvrir_fichier_texte(AFichier);
    if (f <> 0) then
      while (fin = 0) do
      begin
        s = f_lire_fichier_texte(f);
        if (s = '-1') then
          fin = 1;
        else
        begin
          fin = 0;
          
          if (ADonnee = 0) then execute procedure ps_importer_conversion_org_amo(:s);
          else if (ADonnee = 1) then execute procedure ps_importer_conversion_couv_amo(:s);
          else if (ADonnee = 2) then execute procedure ps_importer_conversion_compte(:s);
        end
      end
  end
  else
  begin
    f = f_creer_fichier_texte(AFichier);
    if (f <> 0) then
    begin    
      if (ADonnee = 0) then execute procedure ps_exporter_conversions_org_amo(:f);
      else if (ADonnee = 1) then execute procedure ps_exporter_conversions_cou_amo(:f);      
      else if (ADonnee = 2) then execute procedure ps_exporter_conversions_compte(:f);
    end      
  end
  
  if (f <> 0) then
    f_fermer_fichier(f);
end;