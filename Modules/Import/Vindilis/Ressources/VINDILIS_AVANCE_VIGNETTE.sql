select 
o.serialbeneficiaire,
ben.serial,
datevente,
amm.amm,
lv.codeacte,
a.libellearticle,
a.prixventettc, 
a.prixachatht, 
av.serialarticle, 
vendeurquivalide,
av.quantite, 
a.baseremboursement
from avancevignette av
inner join vente v ON av.serialvente=v.serial
inner join article a ON av.serialarticle=a.serial
inner join lignevente lv ON v.serial=lv.serialvente
inner join amm ON amm.serialarticle=a.serial
left join ordonnance o ON v.serial=o.serialvente
inner join assure ass ON ass.serialclient=av.serialclient
left join beneficiaire ben on ben.serialassure = ass.serial
where av.etat is null and chrono=1 and amm.principal= 'O'
and (o.serialbeneficiaire=ben.serial or (o.serialbeneficiaire is null and qualite='0')) -- On ne prend que les béneficiaires qui correspondent au client. La deuxième partie de la condition filtre dans le cas où il n'y a pas de serial beneficiaire au niveau de l'ordonnance, et prend le serialbeneficiaire où qualite=0