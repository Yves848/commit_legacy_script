-- VINDILIS COUVERTURE AMC
select
couv.serial,
couv.code,
couv.libelle,
couv.taux,
coalesce(tauxPH1.taux , couv.taux ) PH1,
coalesce(tauxPH2.taux , couv.taux ) PH2,
coalesce(tauxPH4.taux , couv.taux ) PH4,
coalesce(tauxPH7.taux , couv.taux ) PH7,
coalesce(tauxAAD.taux , couv.taux ) AAD,
coalesce(tauxPMR.taux , couv.taux ) PMR 
from couvertureamc couv
left join tauxacteamc tauxPH1 on tauxPH1.serialcouvertureamc = couv.serial and tauxPH1.serialacte = ( select act.serial from acte act where code ='PH1')
left join tauxacteamc tauxPH2 on tauxPH2.serialcouvertureamc = couv.serial and tauxPH2.serialacte = ( select act.serial from acte act where code ='PH2')
left join tauxacteamc tauxPH4 on tauxPH4.serialcouvertureamc = couv.serial and tauxPH4.serialacte = ( select act.serial from acte act where code ='PH4')
left join tauxacteamc tauxPH7 on tauxPH7.serialcouvertureamc = couv.serial and tauxPH7.serialacte = ( select act.serial from acte act where code ='PH7')
left join tauxacteamc tauxAAD on tauxAAD.serialcouvertureamc = couv.serial and tauxAAD.serialacte = ( select act.serial from acte act where code ='AAD')
left join tauxacteamc tauxPMR on tauxPMR.serialcouvertureamc = couv.serial and tauxPMR.serialacte = ( select act.serial from acte act where code ='PMR')
