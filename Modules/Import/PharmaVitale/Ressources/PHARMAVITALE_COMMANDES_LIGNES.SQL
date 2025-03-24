SELECT id_com,
       num_ligcom,
       code_uv,
       etat_ligcom,
       qtecom_ligcom,
       qterec_ligcom,
       prixcat_ligcom, 
       txremg_ligcom,
       prixremht_ligcom,
       qteug_ligcom,
       pxpub_ligcom 
FROM [PharmaVitaleBD].[dbo].[ligcom]
WHERE id_com in ( SELECT id_com FROM com 
                  where etat_com = 'H' 
                  and  datediff(day, dtsaisie_com, GETDATE()) < 1095 )