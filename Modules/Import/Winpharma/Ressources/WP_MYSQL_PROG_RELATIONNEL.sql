SELECT
cli.ti,
cli.CartActivId,
cli.CarteAffinityObs,
cli.CarteLafayetteObs,
cli.CarteElsieObs,
cli.CarteApriumObs,
cli.CartePharmaCorpObs,
cli.CarteAlphegaObs
FROM clients0 cli
where
cli.CartActivId<> '' or 
cli.CarteAffinityObs<> '' or 
cli.CarteLafayetteObs<> '' or
cli.CarteElsieObs<> '' or
cli.CarteApriumObs<> '' or
cli.CartePharmaCorpObs<> '' or
cli.CarteAlphegaObs<> ''

/*regarder aussi FIDCLI avec carte en varchar 14 et client +type unique*/
/*
-- reprise de carte santégo par exemple : 
select cli_ti, 
carte , 
null,
null,
null,
null,
null,
null,
null
from FIDCLI
where Flags1=1 and fidtype = 11
*/