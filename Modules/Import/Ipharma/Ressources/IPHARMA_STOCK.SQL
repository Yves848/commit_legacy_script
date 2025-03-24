select
  stk.stock_id,
  stk.tar_id,
  stk.stock_reel,
  stk.stock_reserve,
  stk.stock_minimal,
  stk.stock_ideal,
  stk.rangement,
  stk.fournisseur_preferentiel,
  stk.fournisseur_report,
  stk.seuil_alerte,
  stk.date_peremption
from
  stock stk  