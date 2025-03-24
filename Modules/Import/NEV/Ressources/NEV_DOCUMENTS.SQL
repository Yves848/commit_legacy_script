select 
psdic_numdoc id_document,
psdic_datcre date_creation,
cast(psdic_chemin||psdic_nomdoc as varchar(255)) chemin,
cast(psdic_iddoc as varchar(20))  numero_facture,
cast(psdic_typdoc as varchar(2)) typedoc,
psdic_ident id_client

from afpsdic
where psdic_typdoc in ('OV','OW','OC','VE', 'OL', 'M', 'OA' )
and psdic_ident > ''