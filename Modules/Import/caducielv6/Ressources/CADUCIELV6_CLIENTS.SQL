select
  c.cli_num_id,
  c.cli_car_nom,
  iif(q.qual_num_code = '0', a.ass_car_insee, ass.ass_car_insee),
  q.qual_num_code,
  a.ass_num_rang,
  a.ass_car_naissance,
  a.ass_num_primaire_fk,  
  a.ass_num_regprim_fk,
  a.ass_num_regald_fk,
  a.ass_dte_prim_deb_droit,  
  a.ass_dte_prim_fin_droit,  
  a.ass_dte_debut_droits_ald,
  a.ass_dte_fin_droits_ald,
  a.ass_car_adhspsante,
  a.ass_car_numspsante,
  mc.dmut_num_mut_fk dmut_num_mut_c,
  mc.dmut_num_regmut_fk dmut_num_regmut_c,
  mc.dmut_dte_debutdroit dmut_dte_debutdroit_c,
  mc.dmut_dte_findroit dmut_dte_findroit_c,
  md.dmut_num_mut_fk dmut_num_mut_d,
  md.dmut_num_regmut_fk dmut_num_regmut_d,
  md.dmut_dte_debutdroit dmut_dte_debutdroit_d,
  md.dmut_dte_findroit dmut_dte_findroit_d,
  mf.dmut_num_mut_fk dmut_num_mut_f,
  mf.dmut_num_regmut_fk dmut_num_regmut_f,
  mf.dmut_dte_debutdroit dmut_dte_debutdroit_f,
  mf.dmut_dte_findroit dmut_dte_findroit_f,
  s.sexe_car_abrev,
  a.ass_car_nomjf,
  c.cli_car_adresse1,
  c.cli_car_adresse2,
  c.cli_car_adresse3,
  c.cli_car_adresse4,
  c.cli_car_adresse5,
  cp.cpos_car_codepostal,
  cp.cpos_car_ville,
  c.cli_tel_telephone,
  c.cli_tel_portable,
  c.cli_tel_fax,
  c.cli_dte_datecreation,
  c.cli_car_remarque,
  c.cli_mem_memo,
  c.cli_bol_estcompte,
  c.cli_num_compte_fk,
  del.date_dern_vis
from tbl_client c
     left join tbl_assure a on (a.ass_num_idclient_pk = c.cli_num_id)
     left join tbl_assure ass on (ass.ass_num_idclient_pk = a.ass_num_assure_fk)
     left join tbl_donnees_mutuelle mc on (mc.dmut_num_id = a.ass_num_donneesmut_carte_fk)
     left join tbl_donnees_mutuelle md on (md.dmut_num_id = a.ass_num_donneesmut_dexia_fk)
     left join tbl_donnees_mutuelle mf on (mf.dmut_num_id = a.ass_num_donneesmut_fichier_fk)
     left join tbl_qualite q on (q.qual_num_id = a.ass_num_qualite_benef_fk)
     left join tbl_sexe s on (s.sexe_num_id = a.ass_num_sexe_fk)
     left join tbl_codepostal cp on (cp.cpos_num_id = c.cli_num_cpos_fk)
     left join (select del_num_cli_fk, max(del_mod_dermodif)  date_dern_vis
                from tbl_delivrance
                group by del_num_cli_fk) del on (del.del_num_cli_fk = c.cli_num_id)
where c.cli_bol_deleted = 0 