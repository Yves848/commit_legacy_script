select 
p.serial,
ben.serial,
v.datevente,
s.serial,
p.qtepromise
FROM promis p
INNER JOIN vente v ON p.serialvente=v.serial
INNER JOIN article a ON p.serialarticle=a.serial
inner join stock s on s.serialarticle = a.serial
INNER JOIN assure ass ON ass.serialclient=v.serialclient
LEFT JOIN beneficiaire ben on ass.serial = ben.serialassure 
WHERE qualite=0
and (p.etat = '1' or p.etat is null)