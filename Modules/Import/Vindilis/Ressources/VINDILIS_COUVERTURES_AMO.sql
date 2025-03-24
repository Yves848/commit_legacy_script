-- VINDILIS COUVERTURE AMO
select
couv.serial,
couv.code,
couv.libelle,
couv.taux,
couv.exoneration,
couv.alsacemoselle,
coalesce(tauxPH1.taux , couv.taux ) PH1,
coalesce(tauxPH2.taux , couv.taux ) PH2,
coalesce(tauxPH4.taux , couv.taux ) PH4,
coalesce(tauxPH7.taux , couv.taux ) PH7,
coalesce(tauxAAD.taux , couv.taux ) AAD,
coalesce(tauxPMR.taux , couv.taux ) PMR --,
-- PH2base.tauxtheorique PH2base,
-- PH4base.tauxtheorique PH4base,
-- PH7base.tauxtheorique PH7base,
-- PMRbase.tauxtheorique PMRbase,
-- AADbase.tauxtheorique AADbase
from couverture couv
left join tauxacte tauxPH1 on tauxPH1.serialcouverture = couv.serial and tauxPH1.serialacte = ( select act.serial from acte act where code ='PH1')
left join tauxacte tauxPH2 on tauxPH2.serialcouverture = couv.serial and tauxPH2.serialacte = ( select act.serial from acte act where code ='PH2')
left join tauxacte tauxPH4 on tauxPH4.serialcouverture = couv.serial and tauxPH4.serialacte = ( select act.serial from acte act where code ='PH4')
left join tauxacte tauxPH7 on tauxPH7.serialcouverture = couv.serial and tauxPH7.serialacte = ( select act.serial from acte act where code ='PH7')
left join tauxacte tauxAAD on tauxAAD.serialcouverture = couv.serial and tauxAAD.serialacte = ( select act.serial from acte act where code ='AAD')
left join tauxacte tauxPMR on tauxPMR.serialcouverture = couv.serial and tauxPMR.serialacte = ( select act.serial from acte act where code ='PMR')
-- left join acte PH2base on PH2base.code = 'PH2'
-- left join acte PH4base on PH4base.code = 'PH4'
-- left join acte PH7base on PH7base.code = 'PH7'
-- left join acte PMRbase on PMRbase.code = 'PMR'
-- left join acte AADbase on AADbase.code = 'AAD'
