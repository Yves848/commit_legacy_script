SELECT
    p.Prs_Id,
    cf.Cfi_CodeBarre,
    cf.Fid_Id
FROM CarteFidelitee cf 
INNER JOIN Personne p ON cf.Prs_Id = p.Prs_Id 
inner join ProgrammeFidelite pf on pf.Fid_Id = cf.Fid_Id 
where pf.Fid_IsActif =1
                        