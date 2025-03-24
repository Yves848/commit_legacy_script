select id,
       cast(debt as float )
 from patients
where cast(debt as float ) <> 0
union 
select id,
       cast(debt as float )
 from collectivities
where cast(debt as float ) <> 0