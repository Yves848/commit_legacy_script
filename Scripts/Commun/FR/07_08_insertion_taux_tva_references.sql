set sql dialect 3;

insert into t_ref_tva (t_ref_tva_id, taux, soumis_mdl) values (next value for seq_ref_tva,  2.1, '1');
insert into t_ref_tva (t_ref_tva_id, taux, soumis_mdl) values (next value for seq_ref_tva,  5.5, '0');
insert into t_ref_tva (t_ref_tva_id, taux, soumis_mdl) values (next value for seq_ref_tva,  20, '0');
insert into t_ref_tva (t_ref_tva_id, taux, soumis_mdl) values (next value for seq_ref_tva,  0, '0');
insert into t_ref_tva (t_ref_tva_id, taux, soumis_mdl) values (next value for seq_ref_tva,  10, '0');

commit;