set sql dialect 3;

/* ********************************************************************************************** */
create or alter procedure ps_convertir_organismes_amo
as
declare variable lIntOrganismeAMOID varchar(50);
declare variable lIntRegimeID integer;
declare variable lChSsCtrGest char(1);
declare variable lStrCaisseGest varchar(3);
declare variable lStrCentreGest varchar(4);
declare variable lIntOrganismeAMORefID integer;
declare variable strRegime varchar(2);
begin
    -- 05_3_creation_procedure_conversion.sql
  for select o.t_organisme_id,
             o.t_ref_regime_id,
             r.code,
             r.sans_centre_gestionnaire,
             o.caisse_gestionnaire,
             o.centre_gestionnaire
      from t_organisme o
           inner join t_ref_regime r on r.t_ref_regime_id = o.t_ref_regime_id
      where type_organisme = '1'
      into :lIntOrganismeAMOID,
           :lIntRegimeID,
           :strRegime ,
           :lChSsCtrGest,
           :lStrCaisseGest,
           :lStrCentreGest do
  begin
   if (lChSsCtrGest = '0' and lStrCentreGest is null and lStrCentreGest='') then
      begin
      if (strRegime in ('04', '05', '09', '12', '14', '15', '16', '80', '90')) then lStrCentreGest = '0000';
      else
        if (strRegime = '92') then lStrCentreGest = '0512';
        else 
          if (strRegime = '95') then lStrCentreGest = '0619';
            else
              if (strRegime = '96') then lStrCentreGest = '0516';             
    end
--    else
--      lStrCentreGest = '';

    select t_ref_organisme_id
    from t_ref_organisme
    where t_ref_regime_id = :lIntRegimeID
      and caisse_gestionnaire = :lStrCaisseGest
      and coalesce(centre_gestionnaire, '') = iif(:lChSsCtrGest = '0', :lStrCentreGest, '')
    into lIntOrganismeAMORefID;

    if (row_count = 1) then
    begin
      update t_organisme
      set t_ref_organisme_id = :lIntOrganismeAMORefID
      where t_organisme_id = :lIntOrganismeAMOID;
      
      if ((lChSsCtrGest = '1') and (lStrCentreGest <> '')) then
        update t_client
        set centre_gestionnaire = :lStrCentreGest
        where t_organisme_amo_id = :lIntOrganismeAMOID
          and centre_gestionnaire = '';
    end
  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_convertir_couvertures_amo
as
declare variable lStrCouvertureAMOID varchar(50);
declare variable lStrRegime varchar(2);
declare variable lIntNatureAssurance numeric(2);
declare variable lStrJustificatifExo char(1);
declare variable lIntIDPH4 numeric(3);
declare variable lIntIDPH7 numeric(3);
declare variable lIntIDPH1 numeric(3);
declare variable lIntIDPMR numeric(3);
declare variable lIntPH4 numeric(3);
declare variable lIntPH7 numeric(3);
declare variable lIntPH1 numeric(3);
declare variable lIntPMR numeric(3);
declare variable lStrCodeCouverture char(5);
declare variable lIntRefCouvertureAMOID integer;
declare variable lStrALD char(1);
begin
  execute procedure ps_supprimer_couv_amo_inutiles;

  -- 05_3_creation_procedure_conversion.sql
  execute procedure ps_renvoyer_id_prestation('PH4') returning_values :lIntIDPH4;
  execute procedure ps_renvoyer_id_prestation('PH7') returning_values :lIntIDPH7;
  execute procedure ps_renvoyer_id_prestation('PH1') returning_values :lIntIDPH1;

  if (lIntIDPH4 is null) then
    exception exp_cnv_couv_amo_taux_intrv 'PH4';

  if (lIntIDPH7 is null) then
    exception exp_cnv_couv_amo_taux_intrv 'PH7';

  if (lIntIDPH1 is null) then
    exception exp_cnv_couv_amo_taux_intrv 'PH1';

  for select couvamo.t_couverture_amo_id,
             reg.code,
             couvamo.justificatif_exo,
             couvamo.nature_assurance,
             ph4.taux,
             ph7.taux,
             ph1.taux
      from t_couverture_amo couvamo
           inner join t_organisme org on (org.t_organisme_id = couvamo.t_organisme_amo_id)
           left join t_ref_regime reg on (reg.t_ref_regime_id = org.t_ref_regime_id)
           inner join t_taux_prise_en_charge ph4 on (ph4.t_couverture_amo_id = couvamo.t_couverture_amo_id and ph4.t_ref_prestation_id = :lIntIDPH4)
           inner join t_ref_prestation pr_ph4 on (pr_ph4.t_ref_prestation_id = ph4.t_ref_prestation_id)
           inner join t_taux_prise_en_charge ph7 on (ph7.t_couverture_amo_id = couvamo.t_couverture_amo_id and ph7.t_ref_prestation_id = :lIntIDPH7)
           inner join t_ref_prestation pr_ph7 on (pr_ph7.t_ref_prestation_id = ph7.t_ref_prestation_id)
           inner join t_taux_prise_en_charge ph1 on (ph1.t_couverture_amo_id = couvamo.t_couverture_amo_id and ph1.t_ref_prestation_id = :lIntIDPH1)
           inner join t_ref_prestation pr_ph1 on (pr_ph1.t_ref_prestation_id = ph1.t_ref_prestation_id)
      where pr_ph4.code = 'PH4'
        and pr_ph7.code = 'PH7'
        and pr_ph1.code = 'PH1'
        and couvamo.t_ref_couverture_amo_id is null
      into :lStrCouvertureAMOID,
           :lStrRegime,
           :lStrJustificatifExo,
           :lIntNatureAssurance,
           :lIntPH4,
           :lIntPH7,
           :lIntPH1 do
  begin
    lStrALD = '0';

    /* Affectation du régime 01 */
    if ((lStrRegime in ('08', '12', '91', '92', '93', '94', '95', '96', '97', '98', '99')) or
        (lStrRegime is null)) then
      lStrRegime = '01';

    /* 00100, 00200, 00300 */
    if ((lIntNatureAssurance = 10) and (lStrJustificatifExo = '0') and (lIntPH4 = 30) and (lIntPH7 = 65) and (lIntPH1 = 100) and
        (lStrRegime in ('01', '02', '03'))) then
      lStrCodeCouverture = '0' || lStrRegime || '00';
    else
        /* 01000 CRPCEN*/
    if ((lIntNatureAssurance = 10) and (lStrJustificatifExo = '0') and (lIntPH4 = 45) and (lIntPH7 = 85) and (lIntPH1 = 100) and
        (lStrRegime in ('10'))) then
      lStrCodeCouverture = '0' || lStrRegime || '00';
    else
       /* 01002 CRPCEN*/
    if ((lIntNatureAssurance = 10) and (lStrJustificatifExo = '5') and (lIntPH4 = 45) and (lIntPH7 = 100) and (lIntPH1 = 100) and
        (lStrRegime in ('10'))) then
      lStrCodeCouverture = '0' || lStrRegime || '02';
    else
       /* 01004 CRPCEN*/
    if ((lIntNatureAssurance = 10) and (lStrJustificatifExo = '9') and (lIntPH4 = 45) and (lIntPH7 = 85) and (lIntPH1 = 100) and
        (lStrRegime in ('10'))) then
      lStrCodeCouverture = '0' || lStrRegime || '04';
    else
      /* 00101, 00201, 00301, 00401, 01001(CRPCEN) ART115  */
      if (((lIntNatureAssurance = 10) and (lStrJustificatifExo = '5') and (lIntPH4 = 100) and (lIntPH7 = 100) and (lIntPH1 = 100)) and
          (lStrRegime in ('01', '02', '03', '04' , '10'))) then
        lStrCodeCouverture = '0' || lStrRegime || '01';
      else
        /* 00102, 00202, 00302 INV  */
        if (((lIntNatureAssurance = 10) and (lStrJustificatifExo = '5') and (lIntPH4 = 30) and (lIntPH7 = 100) and (lIntPH1 = 100)) and
            (lStrRegime in ('01', '02', '03'))) then
          lStrCodeCouverture = '0' || lStrRegime || '02';
        else
          /* 00105, 00202 ALSACE MOSELLE  */
          if (((lIntNatureAssurance = 13) and (lStrJustificatifExo = '0') and (lIntPH4 = 80) and (lIntPH7 = 90) and (lIntPH1 = 100)) and
              (lStrRegime in ('01', '02'))) then
            lStrCodeCouverture = '0' || lStrRegime || '05';
          else
            /* 00106  O0202 ALSACE MOSELLE INV*/
            if (((lIntNatureAssurance = 13) and (lStrJustificatifExo = '5') and (lIntPH4 = 90) and (lIntPH7 = 100) and (lIntPH1 = 100)) and
                (lStrRegime in ('01', '02'))) then
              lStrCodeCouverture = '0' || lStrRegime || '06';
            else
              /* 001AT  */
              if (((lIntNatureAssurance = 41) and (lIntPH4 = 100) and (lIntPH7 = 100) and (lIntPH1 = 100)) and
                  (lStrRegime in ('01', '02'))) then
                lStrCodeCouverture = '9' || lStrRegime || 'AT';
              else
                /* 00400  */
                if (((lIntNatureAssurance = 10) and (lStrJustificatifExo = '0') and (lIntPH4 = 75) and (lIntPH7 = 75) and (lIntPH1 = 100)) and
                     (lStrRegime = '04')) then
                  lStrCodeCouverture = '0' || lStrRegime || '00';
                else
                  /* 00403  */
                  if (((lIntNatureAssurance = 10) and (lStrJustificatifExo = '0') and (lIntPH4 = 30) and (lIntPH7 = 65) and (lIntPH1 = 100)) and
                       (lStrRegime = '04')) then
                    lStrCodeCouverture = '0' || lStrRegime || '03';
                  else
                      /* 01000 CRPCEN */
                      if (((lIntNatureAssurance = 10) and (lStrJustificatifExo = '0') and (lIntPH4 = 45) and (lIntPH7 = 85) and (lIntPH1 = 100)) and
                           (lStrRegime = '10')) then
                        lStrCodeCouverture = '0' || lStrRegime || '00';    
                  else
                    /* ALD   */
                    if ((lIntNatureAssurance in (10, 21)) and (lStrJustificatifExo = '4')) then
                    begin
                      lStrALD = '1';
                      lStrCodeCouverture = null;
                    end
                    else
                    begin
                      lStrALD = null;
                      lStrCodeCouverture = null;
                    end
    /* MAJ */
    if (lStrALD is not null) then
    begin
      if (lStrCodeCouverture is not null) then
      begin
        select t_ref_couverture_amo_id
        from t_ref_couverture_amo
        where code_couverture = :lStrCodeCouverture
        into lIntRefCouvertureAMOID;

        if (row_count = 0) then
          lIntRefCouvertureAMOID = null;
      end
      else
        lIntRefCouvertureAMOID = null;

      update t_couverture_amo
      set ald = :lStrALD,
          t_ref_couverture_amo_id = :lIntRefCouvertureAMOID
      where t_couverture_amo_id = :lStrCouvertureAMOID;
    end
  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_maj_organisme_amo(
  AOrganismeAMOID varchar(50),
  ARepris char(1),
  AIdentifiantNational varchar(9))
as
declare variable lIntRegimeRefID integer;
declare variable lIntOrganismeAMORefID integer;
begin
  -- 05_3_creation_procedure_conversion.sql
  select t_ref_regime_id
  from t_ref_regime
  where code = substring(:AIdentifiantNational from 1 for 2)
  into :lIntRegimeRefID;

  if (row_count = 1) then
  begin
    select t_ref_organisme_id
    from t_ref_organisme
    where t_ref_regime_id = :lIntRegimeRefID
      and caisse_gestionnaire = substring(:AIdentifiantNational from 3 for 3)
      and coalesce(centre_gestionnaire, '') = substring(:AIdentifiantNational from 6 for 4)
    into :lIntOrganismeAMORefID;

    if (row_count = 0) then
      lIntOrganismeAMORefID = null;
  end
  else
    lIntOrganismeAMORefID = null;

  update t_organisme
  set t_ref_organisme_id = :lIntOrganismeAMORefID,
      repris = :ARepris
  where t_organisme_id = :AOrganismeAMOID;
  
  update t_couverture_amo
  set repris = :ARepris
  where t_organisme_amo_id = :AOrganismeAMOID;
end;

/* ********************************************************************************************** */
create or alter procedure ps_creer_vue_prestations_amo
as
declare variable lStrSQL varchar(3000);
declare variable lIntPrestationID integer;
declare variable lStrPrestation varchar(3);
begin
  -- 05_3_creation_procedure_conversion.sql
  -- Prestations couverture AMO
  lStrSQL = 'recreate view v_prestations_amo(t_couverture_amo_id';
  for select code
      from t_ref_prestation rp
           inner join t_cfg_prestation cp on (cp.t_ref_prestation_id = rp.t_ref_prestation_id)
      where utilisable_conversion = '1'
      order by priorite
      into :lStrPrestation do
    lStrSQL = lStrSQL || ', ' || lStrPrestation;

  lStrSQL = lStrSQL || ') as select couvamo.t_couverture_amo_id';

  for select code
      from t_ref_prestation rp
           inner join t_cfg_prestation cp on (cp.t_ref_prestation_id = rp.t_ref_prestation_id)
      where utilisable_conversion = '1'
      order by priorite
      into :lStrPrestation do
    lStrSQL = lStrSQL || ', coalesce(r_' || lStrPrestation || '.taux, ' || lStrPrestation || '.taux)';

  lStrSQL = lStrSQL || ' from t_couverture_amo couvamo ';

  for select rp.t_ref_prestation_id,
             rp.code
      from t_ref_prestation rp
           inner join t_cfg_prestation cp on (cp.t_ref_prestation_id = rp.t_ref_prestation_id)
      where utilisable_conversion = '1'
      order by priorite
      into :lIntPrestationID,
           :lStrPrestation do
    lStrSQL = lStrSQL || 'left join t_taux_prise_en_charge ' || lStrPrestation || ' on (' || lStrPrestation || '.t_couverture_amo_id = couvamo.t_couverture_amo_id and ' || lStrPrestation || '.t_ref_prestation_id = ' || lIntPrestationID || ') ';

  for select rp.t_ref_prestation_id,
             rp.code
      from t_ref_prestation rp
           inner join t_cfg_prestation cp on (cp.t_ref_prestation_id = rp.t_ref_prestation_id)
      where utilisable_conversion = '1'
      order by priorite
      into :lIntPrestationID,
           :lStrPrestation do
    lStrSQL = lStrSQL || 'left join t_ref_taux_prise_en_charge r_' || lStrPrestation || ' on (r_' || lStrPrestation || '.t_ref_couverture_amo_id = couvamo.t_ref_couverture_amo_id and r_' || lStrPrestation || '.t_ref_prestation_id = ' || lIntPrestationID || ') ';

  execute statement lStrSQL;
end;

/* ********************************************************************************************** */
create or alter procedure ps_maj_couverture_amo(
  ACouvertureAMOID varchar(50),
  ARepris char(1),
  AALD char(1),
  ACodeCouverture char(5))
as
declare variable chOrgRepris char(1);
declare variable lIntCouvertureAMORefID integer;
begin
  -- 05_3_creation_procedure_conversion.sql
  select o.repris
  from t_couverture_amo c
       inner join t_organisme o on (o.t_organisme_id = c.t_organisme_amo_id)
  where c.t_couverture_amo_id = :ACouvertureAMOID
  into :chOrgRepris;
  
  if (chOrgRepris = '0') then
    ARepris = '0';
    
  if (AALD = '0') then
    if (substring(ACodeCouverture from 1 for 1) = '1') then
    begin  
      AALD = '1';
      lIntCouvertureAMORefID = null;    
    end
    else
    begin    
      select t_ref_couverture_amo_id
      from t_ref_couverture_amo
      where code_couverture = :ACodeCouverture
      into :lIntCouvertureAMORefID;
    
      if (row_count = 0) then
        lIntCouvertureAMORefID = null;    
    end
  else
    lIntCouvertureAMORefID = null;

  update t_couverture_amo
  set t_ref_couverture_amo_id = :lIntCouvertureAMORefID,
      ald = :AALD,
      repris = :ARepris 
  where t_couverture_amo_id = :ACouvertureAMOID;
end;

/******************************************************************************/
create or alter procedure ps_supprimer_doublon_couv_amc
as
declare variable i integer;
declare variable intNbPrestUtil integer;
declare variable strOrgAMC varchar(50);
declare variable strCouvAMC1 varchar(50);
declare variable strCouvAMC2 varchar(50);
declare variable strPrestation varchar(3);
declare variable intTaux1 integer;
declare variable intTaux2 integer;
begin

  for select distinct t_organisme_amc_id
      from t_couverture_amc
      where t_organisme_amc_id is not null
      into strOrgAMC do
    for select t_cnv_couverture_amc_id
        from t_cnv_couverture_amc cc
        inner join t_couverture_amc c on (c.t_couverture_amc_id = cc.t_couverture_amc_id)
        where c.t_organisme_amc_id = :strOrgAMC
        into :strCouvAMC1 do
      for select t_cnv_couverture_amc_id
          from t_cnv_couverture_amc cc
          inner join t_couverture_amc c on (c.t_couverture_amc_id = cc.t_couverture_amc_id)
          where c.t_organisme_amc_id = :strOrgAMC
            and t_cnv_couverture_amc_id <> :strCouvAMC1
          into :strCouvAMC2 do
      begin
        select count(*)
        from t_cfg_prestation
        where utilisable_conversion = '1'
        into :intNbPrestUtil;

        i = 0;
        for select t_ref_prestation_id
            from t_cfg_prestation
            where utilisable_conversion = '1'
            into :strPrestation do
        begin
          select taux
          from t_cnv_taux_prise_en_charge
          where t_ref_prestation_id = :strPrestation
            and t_couverture_amc_id = :strCouvAMC1
          into :intTaux1;

          select taux
          from t_cnv_taux_prise_en_charge
          where t_ref_prestation_id = :strPrestation
            and t_couverture_amc_id = :strCouvAMC2
          into :intTaux2;

          if (intTaux1 = intTaux2) then
            i = i + 1;
        end

        /* le cas échéant => maj des clients & suppression de la couverture doublé */
        if (i = intNbPrestUtil) then
          begin
          /*update t_cnv_couverture_amc
          set t_cnv_couverture_amc_id = :strCouvAMC2
          where t_couverture_amc_id = :strCouvAMC1;*/
            update t_client set t_cnv_couverture_amc_id = :strCouvAMC2 where t_cnv_couverture_amc_id = :strCouvAMC1;
            delete from t_cnv_couverture_amc where t_cnv_couverture_amc_id = :strCouvAMC1;
          end
      end
end;

/* ********************************************************************************************** */
create or alter procedure ps_calculer_taux_couverture_amc(
  AALD char(1),
  ACouvAMO integer,
  ACouvAMCBase varchar(50),
  ACouvAMC varchar(50)) 
as
declare variable strPrestation varchar(3);
declare variable intTauxAMO integer;
declare variable intTauxAMC integer;
declare variable intTauxAMCConverti integer;
declare variable lIntIDPH1 numeric(3);
declare variable lIntIDAAD numeric(3);
begin
  execute procedure ps_renvoyer_id_prestation('PH1') returning_values :lIntIDPH1;
  execute procedure ps_renvoyer_id_prestation('AAD') returning_values :lIntIDAAD;
 /* Boucle de traitement des taux de prise en charge */

  for select cp.t_ref_prestation_id
      from t_cfg_prestation cp
        inner join t_ref_prestation p on (p.t_ref_prestation_id = cp.t_ref_prestation_id)
      where cp.utilisable_conversion = '1' and p.code <> 'PHN' 
      into :strPrestation do
  begin
    intTauxAMO = null;
    intTauxAMC = null;

    /* Taux AMO */
    if (AALD = '0') then
    begin
      select taux
      from t_ref_taux_prise_en_charge
      where t_ref_couverture_amo_id = :ACouvAMO
        and t_ref_prestation_id = :strPrestation
      into intTauxAMO;

      if (row_count = 0) then
        exception exp_cnv_couv_amc_taux_amo;
     end
  else
    intTauxAMO = 100;

    /* Taux AMC */  
    select taux
    from t_taux_prise_en_charge
    where t_couverture_amc_id = :ACouvAMCBase
      and t_ref_prestation_id = :strPrestation
    into intTauxAMC;

     /* Traitement Taux */
    intTauxAMCConverti = intTauxAMO + coalesce(intTauxAMC, 0);
    if ((intTauxAMCConverti > 100) and (:strPrestation <> :lIntIDAAD)) then
      intTauxAMCConverti = 100;
    
    if (intTauxAMCConverti < 0) then
        intTauxAMCConverti = 0;

    insert into t_cnv_taux_prise_en_charge(t_cnv_taux_prise_en_charge_id,
                                           t_couverture_amc_id,
                                           t_ref_prestation_id,
                                           taux)
    values(next value for seq_cnv_taux_prise_en_charge,
           :ACouvAMC,
           :strPrestation,
           :intTauxAMCConverti);
  end
end;

create or alter procedure ps_creer_vue_couvertures_amc
as
begin
  execute statement 'CREATE VIEW vw_cnv_couverture_amc AS
    SELECT DISTINCT c.t_couverture_amc_id, c.t_client_id, co.t_couverture_amo_id, co.t_ref_couverture_amo_id, cr.code_couverture, co.ald
    FROM t_client c
    INNER JOIN t_couverture_amc cm ON (cm.t_couverture_amc_id = c.t_couverture_amc_id)
    INNER JOIN t_taux_prise_en_charge t ON (t.t_couverture_amc_id = cm.t_couverture_amc_id)
    LEFT JOIN t_couverture_amo_client cc ON (cc.t_client_id = c.t_client_id)
    LEFT JOIN t_couverture_amo co ON (co.t_couverture_amo_id = cc.t_couverture_amo_id)
    LEFT JOIN t_ref_couverture_amo cr ON (cr.t_ref_couverture_amo_id = co.t_ref_couverture_amo_id)
    WHERE (cm.formule = ''021'' OR t.formule = ''021'')
      AND NOT EXISTS(SELECT NULL 
                     FROM t_cnv_couverture_amc cc
                     WHERE cc.t_couverture_amc_id = cm.t_couverture_amc_id) 
      AND ((cr.justificatif_exo = ''0'') OR (cr.justificatif_exo IS NULL))
      AND ((SUBSTRING(cr.code_couverture FROM 1 FOR 1) <> ''9'') OR (cr.code_couverture IS NULL));';
end;
execute procedure ps_creer_vue_couvertures_amc;

/* ********************************************************************************************** */
create or alter procedure ps_convertir_couvertures_amc
as
declare variable c varchar(50);
declare variable strCouvAMO varchar(50);
declare variable strCouvAMC varchar(50);
declare variable strCouvAMCcnv varchar(50);
declare variable strSV varchar(5);
declare variable intCouvAMODef integer;
declare variable intNbCouvAMC integer;
declare variable chALD char(1);
begin
  -- Re-init de la conversion 
  delete from t_cnv_taux_prise_en_charge;
  delete from t_cnv_couverture_amc;


    /* Mode calcul = 0, code formule sur couv */
    insert into t_cnv_couverture_amc
    select distinct t.t_couverture_amc_id, t.t_couverture_amc_id, iif(c.formule = '021', '02A', c.formule)
    from t_taux_prise_en_charge t
      inner join t_ref_prestation p on (p.t_ref_prestation_id = t.t_ref_prestation_id) 
      inner join t_couverture_amc c on (c.t_couverture_amc_id = t.t_couverture_amc_id)
    where c.t_organisme_amc_id is not null
      and (p.code = 'PH4' and t.taux > 70 and c.formule = '021') or c.formule <> '021';                               
              
    /* Mode calcul = 0, code formule sur taux */
    insert into t_cnv_couverture_amc(t_cnv_couverture_amc_id, t_couverture_amc_id)
    select distinct t.t_couverture_amc_id, t.t_couverture_amc_id
    from t_taux_prise_en_charge t
      inner join t_ref_prestation p on (p.t_ref_prestation_id = t.t_ref_prestation_id) 
      inner join t_couverture_amc c on (c.t_couverture_amc_id = t.t_couverture_amc_id)
    where (p.code = 'PH4' and t.taux > 70 and t.formule = '021') or t.formule <> '021';  

  /* Création taux pc pour mode calcul = 0 */
  insert into t_cnv_taux_prise_en_charge(t_cnv_taux_prise_en_charge_id,
                                         t_couverture_amc_id,
                                         t_ref_prestation_id,
                                         taux,
                                         formule)
  select next value for seq_cnv_taux_prise_en_charge, 
         tx.t_couverture_amc_id, 
         tx.t_ref_prestation_id, 
         tx.taux,
         tx.formule
  from t_taux_prise_en_charge tx 
       inner join t_cfg_prestation p on (p.t_ref_prestation_id = tx.t_ref_prestation_id) 
       inner join t_cnv_couverture_amc c on (c.t_couverture_amc_id = tx.t_couverture_amc_id) 
  where p.utilisable_conversion = '1';
  
  update t_client
  set t_cnv_couverture_amc_id = t_couverture_amc_id
  where t_couverture_amc_id in (select t_couverture_amc_id
                                from t_cnv_couverture_amc);  
                                
  /* Mode calcul = 1 */
  if (exists (
    select null
    from t_couverture_amc c
    inner join t_taux_prise_en_charge t on t.t_couverture_amc_id = c.t_couverture_amc_id
    left join t_cnv_couverture_amc cc on cc.t_couverture_amc_id = c.t_couverture_amc_id
    where (c.formule = '021' or t.formule = '021')
    and cc.t_couverture_amc_id is null))  then begin
    for select * from vw_cnv_couverture_amc
      into :strCouvAMC, :c, :strCouvAMO, :intCouvAMODef, :strSV, :chALD do
      begin 
        if (((chALD = '0') and (intCouvAMODef is not null)) or
            ((chALD = '1') and (not exists(select null
                                           from t_couverture_amo_client cc
                                             inner join t_couverture_amo c on (c.t_couverture_amo_id = cc.t_couverture_amo_id)
                                           where cc.t_client_id = :c
                                             and c.t_couverture_amo_id <> :strCouvAMO
                                             and c.ald = '0')))) then
        begin
          strCouvAMCcnv = :strCouvAMC || '_' || coalesce(:strSV, :strCouvAMO);
          if (not exists(select *
                         from t_cnv_couverture_amc
                         where t_cnv_couverture_amc_id = :strCouvAMCcnv)) then 
          begin
            insert into t_cnv_couverture_amc
            values(:strCouvAMCcnv, :strCouvAMC, '02A'); 
            
            execute procedure ps_calculer_taux_couverture_amc(:chALD, :intCouvAMODef, :strCouvAMC, :strCouvAMCcnv);
          end 
          
          update t_client 
          set t_cnv_couverture_amc_id = :strCouvAMCcnv
          where t_client_id = :c;         
        end
      end
    end
    
     execute procedure ps_supprimer_doublon_couv_amc; 

end;

/* ********************************************************************************************** */
create or alter procedure ps_creer_vue_couvertures_ref
as
declare variable strSQL varchar(3000);
declare variable strPrestation varchar(3);
declare variable intPrestationID integer;
begin
  -- 05_3_creation_procedure_conversion.sql 
  -- Couvertures organisme AMO
  strSQL = 'create or alter procedure ps_renvoyer_couvertures_ref(
              ARegime varchar(2),
              ACodeCouverture varchar(5))
            returns(                                               
              "N° de couverture" integer,
              "Libéllé" varchar(40),
              "Code SV" char(8),
              "Exo." char(1)'; 

  for select code
      from t_ref_prestation rp
           inner join t_cfg_prestation cp on (cp.t_ref_prestation_id = rp.t_ref_prestation_id)
      where utilisable_conversion = '1'
      order by priorite
      into :strPrestation do
    strSQL = strSQL || ', ' || strPrestation || ' numeric(3)';

  strSQL = strSQL || ') 
                    as 
                    begin
                      for select distinct c.t_ref_couverture_amo_id,
                                 substring(c.libelle from 1 for 40),
                                 c.code_couverture,
                                 c.justificatif_exo';

  for select code
      from t_ref_prestation rp
           inner join t_cfg_prestation cp on (cp.t_ref_prestation_id = rp.t_ref_prestation_id)
      where utilisable_conversion = '1'
      order by priorite
      into :strPrestation do
    strSQL = strSQL || ', ' || strPrestation || '.taux ';

  strSQL = strSQL || ' from t_ref_couverture_amo c
                           inner join t_ref_couverture_organisme_amo co on (co.t_ref_couverture_amo_id = c.t_ref_couverture_amo_id)
                           inner join t_ref_organisme o on (o.t_ref_organisme_id = co.t_ref_organisme_amo_id)
                           inner join t_ref_regime r on (r.t_ref_regime_id = o.t_ref_regime_id) ';

  for select rp.t_ref_prestation_id,
             rp.code
      from t_ref_prestation rp
           inner join t_cfg_prestation cp on (cp.t_ref_prestation_id = rp.t_ref_prestation_id)
      where utilisable_conversion = '1'
      order by priorite
      into :intPrestationID,
           :strPrestation do
    strSQL = strSQL || 'inner join t_ref_taux_prise_en_charge ' || strPrestation || ' on (' || strPrestation || '.t_ref_couverture_amo_id = c.t_ref_couverture_amo_id and ' || strPrestation || '.t_ref_prestation_id = ' || intPrestationID || ') ';
  
  strSQL = strSQL || 'where r.code = :ARegime
                        and c.code_couverture like :ACodeCouverture
                      order by r.code, c.code_couverture
                      into :"N° de couverture",
                           :"Libéllé",
                           :"Code SV",
                           :"Exo."';

  for select rp.t_ref_prestation_id,
             rp.code
      from t_ref_prestation rp
           inner join t_cfg_prestation cp on (cp.t_ref_prestation_id = rp.t_ref_prestation_id)
      where utilisable_conversion = '1'
      order by priorite
      into :intPrestationID,
           :strPrestation do
    strSQL = strSQL || ', :' || strPrestation;
    
  strSQL = strSQL || ' do suspend; end;';
  execute statement strSQL;
end;

/* ********************************************************************************************** */
create or alter procedure ps_convertir_comptes
as
declare variable intIDCompte varchar(50);
declare variable intNbClient numeric(10);
declare variable lIntCountCdt numeric(10);
declare variable chCollectif char(1);
declare variable intIDClient varchar(50);
declare variable chPayeur char(1);
begin
  -- 05_3_creation_procedure_conversion.sql
  for select t_compte_id
      from t_compte
      into :intIDCompte do
  begin
    intIDClient = null;
    
    /* Si Client > 1 => compte collectif */    
    select count(*)
    from t_compte_client
    where t_compte_id = :intIDcompte
    into intNbClient;
    
    if (intNbClient > 1) then
        begin
      chCollectif = '1';
      chPayeur = 'C';
    end
    else     
    begin
      chCollectif = '0';
      chPayeur = 'A';
       
      if (intNbClient = 1) then
        select t_client_id
        from t_compte_client
        where t_compte_id = :intIDCompte
        into :intIDClient;  
    end     
    
    /* MAJ */
    update t_compte
    set collectif = :chCollectif,        
        t_client_id = :intIDClient,
        payeur = :chPayeur
    where t_compte_id = :intIDCompte;
  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_maj_compte(
  ACompteID varchar(50),
  ARepris char(1),
  ACollectif char(1),
  AClientID varchar(50))
as
declare variable chPayeur char(1);
begin
  -- 05_3_creation_procedure_conversion.sql
  if (ACollectif = '1') then
  begin
    chPayeur = 'C';
    AClientID = null;
  end
  else
    chPayeur = 'A';

    if (AClientID is not null) then
    update t_client
    set activite = (select activite
                    from t_compte
                    where t_compte_id = :ACompteID)
    where t_client_id = :AClientID;

  update t_compte
  set collectif = :ACollectif,
      t_client_id = :AClientID,
      payeur = :chPayeur,
      repris = :ARepris
  where t_compte_id = :ACompteID;
end;


create or alter procedure ps_renvoyer_telephone(
 tel_in dm_telephone)
returns(
 tel_out dm_telephone)
as
declare variable i integer;
declare regex varchar(20);
begin
-- ne garde que les caracteres autorisés 0-9 * + #
regex = '[[:DIGIT:]]|#|\+|\*';
tel_out = '';
i = 1;

  while ( i <= char_length(tel_in) ) do
  begin
     if ( substring(tel_in from i for 1 ) similar to regex escape '\' ) then  
       tel_out = tel_out || substring(tel_in from i for 1)  ;
       i = i +1;
  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_gerer_numeros_telephone   /* certain type de colonne en sont gérer comme numero_appel de fournieeur par ex*/
as
declare variable strTable varchar(31);
declare variable strTableID varchar(31);
declare variable strID varchar(50);
declare variable strTelStandard varchar(20);
declare variable strTelPersonnel varchar(20);
declare variable strTelMobile varchar(20);
declare variable strFax varchar(20);
begin
  for select trim(rdb$relation_name)
      from rdb$relation_fields
      where rdb$system_flag = '0' /* n'est pas une table système,on ne sait jamais ... */
        and rdb$view_context is null      /* est une table pas une vue */
        and rdb$field_name = 'TEL_MOBILE'      /* contient le champ tel_mobile */
        and rdb$relation_name not like '%REF%'  /* ne conserne pas les table de references remplis proprement par nos soins */
      into :strTable do                        /* recoit le nom de la table */
  begin
    execute statement 'select trim(rdb$field_name) 
                       from rdb$relation_fields 
                       where rdb$field_id =0 
                       and rdb$relation_name = ' || '''' || strTable || '''' 
    into :strTableID;
    for execute statement 'select ' || strTableID || ', tel_standard, tel_personnel, tel_mobile, fax
                           from ' || strTable || '
                           where tel_standard <>'' or tel_personnel <>'' or tel_mobile <>'' or fax <>'''
        into :strID,  /* les infos a proprement parler */
             :strTelStandard,
             :strTelPersonnel ,
             :strTelMobile,
             :strFax
       do             

    begin

      execute procedure ps_renvoyer_telephone(:strTelStandard) returning_values :strTelStandard;
      execute procedure ps_renvoyer_telephone(:strTelPersonnel) returning_values :strTelPersonnel;
      execute procedure ps_renvoyer_telephone(:strTelMobile) returning_values :strTelMobile;
      execute procedure ps_renvoyer_telephone(:strFax) returning_values :strFax;

      -- si il n y a pas de de numero de mobile on tente avec tel_personnel 
      if (strTelMobile = '' or strTelMobile is null ) then
       if (strTelPersonnel similar to '(0|33||\+33)[6-7][[:DIGIT:]]{8}' escape '\' ) then
          begin
            strTelMobile = strTelPersonnel;
            strTelPersonnel = null;
          end
      -- si toujours pas de numero de mobile on tente avec tel_standard    
      if (strTelMobile = '' or strTelMobile is null ) then
       if (strTelStandard similar to '(0|33||\+33)[6-7][[:DIGIT:]]{8}' escape '\' ) then
          begin
            strTelMobile = strTelStandard;
            strTelStandard = null;
          end

      execute statement 'update ' || strTable || '
                             set tel_standard = ' || '''' || coalesce(strTelStandard, '') || '''' || ', 
                                 tel_personnel = ' || '''' || coalesce(strTelPersonnel, '') || '''' || ',
                                 tel_mobile = ' || '''' || coalesce(strTelMobile, '') || '''' || ',
                                 fax = ' || '''' || coalesce(strFax, '') || '''' || '
                             where ' || strTableID || ' = ' || '''' || replace(strID, '''', '''' || '''') || '''' ;
    end
  end
 
end;

/* ********************************************************************************************** */
create or alter procedure ps_convertir_cp_ville
as
declare variable t_table varchar(31);
declare variable t_cle_id varchar(50);
declare variable t_table_id varchar(31);
declare variable cp varchar(5);
declare variable ville varchar(30);
declare variable t_ref_cp_ville_id integer;
declare variable d integer;
begin
  /* recherche de toutes les tables qui utilisent un code postal */
  for select trim(rdb$relation_name)
      from rdb$relation_fields
      where rdb$system_flag = '0' /* n'est pas une table système,on ne sait jamais ... */
        and rdb$view_context is null      /* est une table pas une vue */
        and rdb$field_name = 'CODE_POSTAL'      /* contient le champ code postal */
        and rdb$relation_name not like '%REF%'  /* ne conserne pas les table de references remplis proprement par nos soins */
        and rdb$relation_name not like '%CFG%'  
        and rdb$relation_name not like '%OFD%'  
      into :t_table do                        /* recoit le nom de la table */
  begin
    execute statement 'select trim(rdb$field_name) 
                       from rdb$relation_fields 
                       where rdb$field_id =0 
                       and rdb$relation_name = ' || '''' || t_table || '''' 
    into :t_table_id;          /* recoit le nom du champ clé */

    for execute statement 'select ' || t_table_id || ', code_postal, nom_ville
                           from ' || t_table || '
                           where char_length(code_postal)=5'
        into :t_cle_id,  /* les infos a proprement parler */
             :cp,
             :ville do
    begin
      t_ref_cp_ville_id = null;
      
      /* la premiere reponse est la bonne si pas de reponse on ne touche rien*/
      select first 1 t_ref_cp_ville_id, f_distance_chaine(:ville , nom_ville )
      from t_ref_cp_ville
      where code_postal = :cp 
      order by f_distance_chaine(:ville , nom_ville )
      into :t_ref_cp_ville_id, d;
      
      /* y a plus qu a mettre a jour le champs */
      if (t_ref_cp_ville_id is not null) then
      begin
        if (d >= 5) then
          t_ref_cp_ville_id = null;
          
        execute statement 'update ' || t_table || '
                           set  t_ref_cp_ville_id = ' || coalesce(t_ref_cp_ville_id, 'null') || '
                           where ' || t_table_id || ' = ' || '''' || replace(t_cle_id, '''', '''' || '''') || '''' ;
       end                              
    end
  end
end;
/* ********************************************************************************************** */
create or alter procedure ps_convertir_hopitaux
as
declare variable idprat dm_code;
begin
  delete from t_cnv_hopital;
  for select min(t_hopital_id) 
      from t_hopital 
      where char_length(no_finess) = 9
      group by no_finess into :idprat 
      do 
      begin
      insert into t_cnv_hopital 
        select next value for seq_cnv_hopital,
              hop.t_hopital_id,
              null,
              coalesce(ref.nom, hop.nom),
              ref.rue_1,
              ref.rue_2,
              null,
              ref.code_postal,
              ref.nom_ville,
              hop.tel_personnel,          
              ref.telephone,
              hop.tel_mobile,
              ref.fax,
              hop.commentaire, 
              coalesce(ref.numero_finess,hop.no_finess)
           from t_ref_hopital ref
           right join t_hopital hop on hop.no_finess = ref.numero_finess
           where hop.t_hopital_id = :idprat ;   
      end
      

  for select min(t_praticien_id) 
      from t_praticien 
      where char_length(no_finess) = 9
      group by no_finess into :idprat 
      do 
      begin
        insert into t_cnv_hopital 
          select next value for seq_cnv_hopital,
                null,
                hop.t_praticien_id,
                ref.nom,
                ref.rue_1,
                ref.rue_2,
                null,
                ref.code_postal,
                ref.nom_ville,
                hop.tel_personnel,
                ref.telephone,
                hop.tel_mobile,
                ref.fax,
                hop.commentaire, 
                ref.numero_finess
             from t_ref_hopital ref
             inner join t_praticien hop on hop.no_finess = ref.numero_finess
             where hop.t_praticien_id = :idprat 
             and ref.numero_finess not in ( select numero_finess from t_cnv_hopital); 
      
    end


end;