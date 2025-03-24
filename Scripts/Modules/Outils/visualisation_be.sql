set sql dialect 3;

/* ********************************************************************************************** */
--create index idx_prat_vslt_recherche on t_praticien(nom, prenom);

recreate view v_vslt_compte_ristourne(
  t_compte_id,	
  t_client_id,
  nom,
  prenom,
  nb_cartes,
  soldedisp,
  ristdisp,
  solde0,
  solde1,
  solde2,
  solde3)
as
select c.compte
       ,c.cliid
       ,p.nom
       ,p.prenom1
	   ,(select count(*) from t_carterist cr where cr.compteid=c.compte)
       ,cast((coalesce((select sum(t1.montantrist) from t_transactionrist t1 where c.compte=t1.compteid and t1.typetransact=0),0)-
       coalesce((select sum(t2.montantrist) from t_transactionrist t2 where c.compte=t2.compteid and t2.typetransact=1),0))   as decimal(9,2))
	   ,cast((coalesce((select sum(t1.montantrist) from t_transactionrist t1 where c.compte=t1.compteid and t1.typetransact=2),0)-
       coalesce((select sum(t2.montantrist) from t_transactionrist t2 where c.compte=t2.compteid and t2.typetransact=3),0))   as decimal(9,2))
	   ,cast(coalesce((select sum(t1.montantrist) from t_transactionrist t1 where c.compte=t1.compteid and t1.typetransact=0),0) as decimal(9,2))
	   ,cast(coalesce((select sum(t1.montantrist) from t_transactionrist t1 where c.compte=t1.compteid and t1.typetransact=1),0) as decimal(9,2))
	   ,cast(coalesce((select sum(t1.montantrist) from t_transactionrist t1 where c.compte=t1.compteid and t1.typetransact=2),0) as decimal(9,2))
	   ,cast(coalesce((select sum(t1.montantrist) from t_transactionrist t1 where c.compte=t1.compteid and t1.typetransact=3),0) as decimal(9,2))
from t_compte c
inner join t_client p on c.cliid=p.client
order by p.nom, p.prenom1;
	
recreate view v_vslt_carte_ristourne(
  t_compte_id,	
  nom,
  prenom,
  num_carte,
  dateEmis
  )
as
select c.compteid
       ,p.nom
       ,p.prenom1
	   ,c.numcarte
	   ,c.dateEmis
from t_carterist c
inner join t_client p on c.cliid=p.client
order by p.nom, p.prenom1;