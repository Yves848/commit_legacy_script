select
  IDSchemaPAtient,
  typeschema, -- 1 = Quotidien 2 = Hebdomadaire / Mensuelle
  TousLes_nbr,
  TousLes_Type, -- 1 = Jours 2 = Semaines 3 = Mois
  joursprise [1] as jourPrise1,
  joursprise [2] as jourPrise2,
  joursprise [3] as jourPrise3,
  joursprise [4] as jourPrise4,
  joursprise [5] as jourPrise5,
  joursprise [6] as jourPrise6,
  joursprise [7] as jourPrise7,
  cast (PriseAuLever as integer),   --nb au Lever
  SPPDnbAv,       --Petit déjeuner - Avant
  SPPDnbPendant,  --Petit Déjeuner - Pendant
  SPPDnbApres,    --Petit Déjeuner - Après
  Prise10h00,     --10h00
  SPDNnbAv,       --Dîner - Avant
  SPDNnbPendant,  --Dîner - Pendant
  SPDNnbApres,    --Dîner - Après
  Prise16h00,     --16h00
  SPSPnbAv,       --Souper - Avant
  SPSPnbPendant,  --Souper - Pendant
  SPSPnbApres,    --Souper - Après
  Prise20H,       --nb à 20H
  PriseAuCoucher  --nb au coucher
from
  SchemaPatient