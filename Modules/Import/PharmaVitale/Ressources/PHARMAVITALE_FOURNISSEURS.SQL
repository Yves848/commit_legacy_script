select
  f.code_fournisseur,
  f.nom_fournisseur,
  f.adresse1,
  f.adresse2,
  f.codePostal,
  f.ville,
  f.telephone,
  f.fax,
  f.siteweb,
  f.direct,
  f.commentaire,
  ml.idfourn_fpml,
  ml.codfourn_fpml,
  ml.adrurl_fpml,
  ml.adrurlsec_fpml,
  ml.nocli_fpml,
  ml.clefcli_fpml,
  ml.adrenv_fpml
from
  dbo.fournisseur f
  left join dbo.FournPML ml on (ml.code_fournisseur = f.code_fournisseur)