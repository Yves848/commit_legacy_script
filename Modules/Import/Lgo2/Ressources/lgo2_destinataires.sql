select 
ci, 
substring(nom from 1 for 50), --nom
substring(smtp from 1 for 50), --serv_smtp
substring(pop from 1 for 50), --serv_pop3
substring(login from 1 for 100), --utilisateur_pop3
substring(psw from 1 for 50), --mot_de_passe_pop3
substring(balrsp from 1 for 50), --adresse_bal
--substring(balloi from 1 for 50), 
substring(mailb2 from 1 for 50), --email_oct
--substring(mailloi from 1 for 50), 
substring(numdest from 1 for 50), --num_det_oct
substring(application from 1 for 2) --application_oct
from "LGO2".oct
