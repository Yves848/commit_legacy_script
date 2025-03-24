select 
cpt.serial,
max(datevente), 
SUM(montant) 
FROM credit
INNER JOIN vente v ON credit.serialvente=v.serial
INNER JOIN client cli ON cli.serial=credit.serialclient
inner join clientencompte cpt on cpt.serialclient = cli.serial 
WHERE credit.serial not in (select serialcredit from creditregle)
GROUP BY cpt.serial
ORDER BY serial asc