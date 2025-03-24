select * from 
  (select 1 as type, 
          PRESCRIPTEUR.PERSONNE_ID personneid, 
          note.BLOBCONTENT memo 
  from PRESCRIPTEUR
  left join note on PRESCRIPTEUR.PERSONNE_ID = note.PARENT_ID
  where note.BLOBCONTENT is not null
  order by personneid
  )
  union all
select * from 
  (select 2 as type, 
          personne.PERSONNE_ID personneid, 
          note.BLOBCONTENT memo 
  from note
  left join personne on note.PARENT_ID = personne.PERSONNE_ID
  where personne.personne_id not in (select PERSONNE_ID from prescripteur) and note.BLOBCONTENT is not null
  order by personneid
  )