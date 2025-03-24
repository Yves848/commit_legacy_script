SELECT
	 IDAttestationsPatients
	,IDPatient
	,Cnk
	,Numattest
	,trim(cast(DateFinValid as varchar(10)))
	,CatRemb
	,CondRemb
	,QtAutorisée
	,QtMax
FROM AttestationsPatients
WHERE DateFinValid>=add_months(sysdate,-1)