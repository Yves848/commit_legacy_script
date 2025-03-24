select cast(t_operateur_id as varchar2(50)),
       codeoperateur,
       nom,
       prenom,
       motdepasse,
       activationoperateur,
       graviteint
from erp.t_operateur
where codeoperateur <> '.'