select
  c.id_doc, 
  c.page,
  c.content,
  d.content_type,
  replace(m.path_fichier,'/','\') muse_path, -- chemin MUSE'
  nvl(f.t_client_id ,a.id_entity ) id_entity,
  a.comments ||' ex-facture no:'||  f.numero_facture commentaire
from 
  erp.t_doc_asso a
  inner join erp.t_content_doc c on (c.id_doc = a.id_doc)
  inner join erp.t_document d on (d.id_doc = a.id_doc)
  left join erp.t_facture f on ( a.id_entity = f.numero_facture and a.entity_type = 1)
  left join muse.t_fichier m on m.ID = upper(replace(c.id_muse, '-',''))
where a.entity_type in ( 1 ) 
  and m.path_fichier is not null
  and d.content_type = 1
  and a.date_cliche >= to_date('0101' || to_char(sysdate, 'YYYY'), 'DDMMYYYY') -365
  and not( a.entity_type = 1  and f.t_facture_id is null )

order by c.id_doc desc