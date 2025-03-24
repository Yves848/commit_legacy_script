select distinct caisse_primaire, code_ald[1], code_situation_benef[1]
from client
where caisse_primaire <> '' and code_situation_benef[1] <> ''
union
select distinct caisse_primaire, code_ald[2], code_situation_benef[2] 
from client
where caisse_primaire <> '' and code_situation_benef[2] <> ''
union
select distinct caisse_primaire, code_ald[3], code_situation_benef[3] 
from client
where caisse_primaire <> '' and code_situation_benef[3] <> ''
union
select distinct caisse_primaire, code_ald[4], code_situation_benef[4] 
from client
where caisse_primaire <> '' and code_situation_benef[4] <> ''
union
select distinct caisse_primaire, code_ald[5], code_situation_benef[5] 
from client
where caisse_primaire <> '' and code_situation_benef[5] <> ''
union
select distinct caisse_primaire, risque_aldman, risque_man 
from client
where caisse_primaire <> '' and risque_man <> ''