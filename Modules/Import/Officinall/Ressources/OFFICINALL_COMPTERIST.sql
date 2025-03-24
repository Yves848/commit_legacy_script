-- Liste des client avec un compte
select cast(rek_primkey as varchar(50)),
       max(pat_primkey),
       1,--liberation à un certain montant
       (select ini_value 
        from inifile 
        where ini_Identifier='WaarschuwenVanafVoorGescandBedrag' 
        and ini_computername='SERVEUR'),
       1
from Rekening
inner join patient on rek_primkey = pat_rek_primkey
where rek_primkey<>0
group by rek_primkey

union all

--On ajoute les client qui ont montant de libéré mais sans compte apparent
select 'A'+cast(pat_primkey as varchar(49)),
       pat_primkey,
       1,--liberation à un certain montant
       (select ini_value 
        from inifile 
        where ini_Identifier='WaarschuwenVanafVoorGescandBedrag' 
        and ini_computername='SERVEUR'),
       1
from memopatient 
inner join patient on pat_primkey=mem_pat_primkey
where mem_type=4 and pat_rek_primkey=0
group by pat_primkey