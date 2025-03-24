select 
  (select valeur_param
   from dbo.parametre
   where code_param = 'CCENTNOM') nom,
  (select valeur_param
   from dbo.parametre
   where code_param = 'CCENTADRP') adresse_mail,
  (select valeur_param
   from dbo.parametre
   where code_param = 'CCENTADRC') adresse_mail_ccent,
  (select valeur_param
   from dbo.parametre
   where code_param = 'CCENTPOP') serveur_pop,
  (select valeur_param
   from dbo.parametre
   where code_param = 'CCENTSMTP') serveur_smtp,
  (select valeur_param
   from dbo.parametre
   where code_param = 'CCENTLOGIN') login_pop,
  (select valeur_param
   from dbo.parametre
   where code_param = 'CCENTMDP') mdp_pop,
  (select valeur_param
   from dbo.parametre
   where code_param = 'CCENTLOGSM') login_smtp,
  (select valeur_param
   from dbo.parametre
   where code_param = 'CCENTMDPSM') mdp_smtp,
  (select valeur_param
   from dbo.parametre
   where code_param = 'CCENTAPP') app,  
  (select valeur_param
   from dbo.parametre
   where code_param = 'CCENTDELAI') delai
