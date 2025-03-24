SELECT 
cli.ccode,
cli.ctypeclie,
cli.ccol_ratt,
cli.cayantdroit,
cli.ccompte,
cli.cdatereglement,
cli.cdatefacture
FROM public.af04 cli
where cli.ccompte<>0
and cli.ccode <> 32500 -- code du cient fictifs PERTES et PROFITS à ne pas reprendre

