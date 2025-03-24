set sql dialect 3;

/* ********************************************************************************************** */
create table t_cfg_prestation(
t_ref_prestation_id dm_cle not null,
utilisable_conversion dm_boolean,
constraint pk_cfg_prestation primary key(t_ref_prestation_id));

commit;
