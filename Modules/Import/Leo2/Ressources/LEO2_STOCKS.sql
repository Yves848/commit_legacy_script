SELECT 
  stk.Bes_Id,
  stk.Lst_Id,
  stk.stp_quantite,
  CASE 
    WHEN COUNT(zg.zg_id) = 1 THEN max(zg.zg_id) -- S'il n'y a qu'un seul ZG, on le prend, sinon, on ne prend pas de ZG, dans la mesure où un produit ne peut être que dans une seule ZG par dépot
    ELSE NULL
  END AS zg_id,
  MIN(stk.Stp_SeuilReappro) AS mini,
  MAX(stk.Stp_Capacite) AS maxi
FROM 
  dbo.Bes_Asso_Lst stk
  INNER JOIN dbo.BesGestionDeStock gds ON gds.Bes_Id = stk.Bes_Id
  INNER JOIN LieuDeStockage lds ON lds.lst_id = stk.Lst_Id
  LEFT JOIN (
    SELECT ban.noe_id zg_id, ban.Bes_Id bes_id
    FROM Bes_Asso_Noe ban 
    LEFT JOIN Noeud noe ON noe.Noe_Id = ban.Noe_Id
    WHERE noe.tar_id = 4
  ) zg ON zg.bes_id = stk.Bes_Id
WHERE 
  stk.stp_quantite > 0 AND gds.Gds_IsTenueEnStock = 1
GROUP BY 
  stk.Bes_Id,
  stk.Lst_Id,
  stk.stp_quantite
  order by stk.bes_id