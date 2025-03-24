select 
ben.serial,
max(datevente), 
SUM(montant) 
FROM credit
INNER JOIN vente v ON credit.serialvente=v.serial
INNER JOIN assure ass ON ass.serialclient=credit.serialclient
LEFT JOIN beneficiaire ben on ass.serial = ben.serialassure 
WHERE credit.serial not in (select serialcredit from creditregle)
AND qualite=0
GROUP BY ben.serial
ORDER BY serial asc