select
  l.serial,
  l.serialhistocmde,
  stk.serialarticle,
  l.qtecommande,
  l.qtelivree,
  l.qteug,
  l.qteuglivree,
  l.prixachatbase,
  l.prixachatnet,
  l.prixventettc,
  l.colisage
from lignehistocmde l
inner join stock stk on stk.serial = l.serialstock