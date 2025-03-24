SELECT
	code,
	nom,
	adresse1,
	adresse2,
	substr(trim(code_postal),1,5),
	substr(trim(ville),1,30),
	telephone,
	note,
	caissegest,
	centregest,
	grand_regime
FROM CENTRES
	