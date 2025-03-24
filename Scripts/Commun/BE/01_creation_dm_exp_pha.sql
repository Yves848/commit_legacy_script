set sql dialect 3;

create domain dm_ChiffreNotNull numeric(1) check ((value is not null) and (value >= 0) and (value < 10));
create domain dm_code2 varchar(100);
create domain dm_commentaire2 varchar(500) default '';
create domain dm_float6_2 numeric(6,2);
create domain dm_float6_3 numeric(6,3);
create domain dm_float7_2 numeric(7,2);
create domain dm_float5_3 numeric(5,3);
create domain dm_numpos1 numeric(1) check((value is null) or ((value >= 0) and (value < 10)));
create domain dm_numpos2 numeric(2) check((value is null) or ((value >= 0) and (value < 100)));
create domain dm_numpos3 numeric(3) check((value is null) or ((value >= 0) and (value < 1000)));
create domain dm_Int Integer check((value is null) or ((value >= 0) and (value < 10000000000)));
create domain dm_monetaire numeric(10, 2) check (((value >= 0) and (value < 10000000000)) or (value is null));
create domain dm_monetaire2 numeric(10, 2) check (((value > -10000000000) and (value < 10000000000)) or (value is null));
create domain dm_monetaire3 numeric(9,6) check (((value > -10000000000) and (value < 10000000000)) or (value is null));

create domain dm_msgerreur varchar(1000) default '';
create domain dm_varchar11 varchar(11) default '';
create domain dm_varchar16 varchar(16) default '';
create domain dm_varchar24 varchar(24) default '';
create domain dm_varchar32 varchar(32) default '';
create domain dm_varchar35 varchar(35) default '';
create domain dm_varchar40 varchar(40) default '';
create domain dm_varchar200 varchar(200) default '';
create domain dm_varchar250 varchar(250) default '';
create domain dm_varchar1000 varchar(1000) default '';
create domain dm_numeric7 numeric(7) check (((value >= -1000000) and (value < 10000000)) or (value is null));

commit;
