/* creation des depots de base  */ 
insert into t_depot ( t_depot_id , libelle , type_depot) values ( next value for seq_depot , 'PHARMACIE' , 'SUVE');
insert into t_depot ( t_depot_id , libelle , type_depot) values ( next value for seq_depot , 'RESERVE' , 'SUAL_R');