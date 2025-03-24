select 
'PAT-'||patnr  client_id, 
naam nom,
voornaam prenom,
adres adresse,
postnr code_postal,
woonplaats ville,
case 
    when length(geboortedatum)= 10 then to_date(geboortedatum, 'DD/MM/YYYY')  
    when length(geboortedatum)= 8 then to_date(geboortedatum, 'DD/MM/YY') 
    else null
end date_naissance,
telefoonnr telephone,
faxnr fax,
e_mail,
insz num_inscription, 
afdeling departement,
kamernr no_chambre,
datumdringend date_cloture,
dringendeinfo commentaire_urgent,
info commentaire,
gsm,
inschrnr MATOA,
categorie CT1CT2,  
zfnr OA,
case 
    when geslacht= 'V' then 2 -- vrouwelijk / feminin
    when geslacht= 'M' then 1 -- mannelijk / masculin
    else 0
end SEXE, 
aci, 
ci,
eidnr numero_carte_identite 
from import.patient

union 

select
'KLA-'||klantnr  client_id, 
naam nom,
'_' prenom,
adres adresse,
postnr code_postal,
woonplaats ville,
null date_naissance,
telefoonnr telephone,
faxnr fax,
e_mail,
null num_inscription, 
null departement,
null no_chambre,
null date_cloture,
'' commentaire_urgent,
betalingsvw commentaire,
gsm,
null MATOA,
null CT1CT2,  
null,
0, 
null, 
null,
null numero_carte_identite 
from import.klant