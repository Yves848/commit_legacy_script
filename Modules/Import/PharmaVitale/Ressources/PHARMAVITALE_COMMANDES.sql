SELECT id_com,
       code_fournisseur,
       nom_com,
       type_com,
       dtsaisie_com,
       dtenvoi_com,
       dtliv_com,
       montantHT_com,
       comment_com
FROM dbo.com
WHERE etat_com = 'H'
  AND datediff(day, dtsaisie_com, GETDATE()) < 1095