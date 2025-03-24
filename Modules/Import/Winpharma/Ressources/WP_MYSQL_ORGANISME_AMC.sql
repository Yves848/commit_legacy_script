SELECT
	code,
	nom,
	adresse1,
	adresse2,
	substr(trim(code_postal),1,5),
	substr(trim(ville),1,30),
	telephone,
	substr(fax,1,20),
	code_muturemb,
	note,
	substr(telecode,1,12),
	typecontrat,
	cetip,
    codevitale
FROM MUTUEL
	