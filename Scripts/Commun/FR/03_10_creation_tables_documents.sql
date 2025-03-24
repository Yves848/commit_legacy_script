set sql dialect 3;

-- create table t_document_client(
--   t_document_client_id dm_cle not null,
--   t_client_id dm_code not null,
--   libelle dm_libelle not null,
--   document varchar(1024) not null,
--   commentaire dm_commentaire,
--   constraint pk_document_client primary key (t_document_client_id),
--   constraint fk_docli_client foreign key (t_client_id) references t_client(t_client_id) on delete cascade);
  
-- create sequence seq_document_client;
-- create index idx_client_doc on t_document_client(t_client_id);  

/*
TYPE_ENTITY
1 Ordonnance : NUM_FACTURE -- une ordo doit etre lié à une facture donc on le transfert en 2, lié au client comme un scan mutuelle
2 Attestation mutuelle d'un patient : ID_AAD
3 Facture BL : NUM_COMMANDE
4 ordonnance rattachée à un dossier de location : ID_FACTURE
5 documents propres aux fournisseur, FSP_3115("FS Pharmacien" : NUM_FACTURE
6 catalogues et conditions commerciales : ID_FOURNISSEUR
7 promotions et nouveautés : ID_FOURNISSEUR
8 contact : ID_FOURNISSEUR
9 documentation et autre : null donc inutilisé
10 SCOR_TICKET_VITALE, Ticket vitale : NUM_FACTURE
11 SCOR_AUTRE_PIECE, Autre pièce : NUM_FACTURE
12 SCOR_AUTRE_PIECELOC, Autre pièce dossier : ID_FACTURE
13 AAD_PIP, Enquêtes : ID_AAD    
14 Document produit : ID_PRODUIT    
15 AAD_AUTRE, Autre document : ID_AAD    
16 FOURNISSEUR_AUTRE, Documentation / Autre : ID_FOURNISSEUR
*/    

create table t_document(
  t_document_id dm_cle not null,
  type_entite dm_liste2 not null,
  content_type integer,
  t_entite_id dm_code not null,
  libelle dm_libelle not null,
  document varchar(512) not null,
  t_date dm_date default null,
  commentaire dm_commentaire,
  constraint unique_document unique (document, t_entite_id),
  constraint pk_document_fournisseur primary key(t_document_id),
  constraint chk_doc_type_entite check(type_entite in ('1', '2', '3', '16')));

  
create sequence seq_document;  