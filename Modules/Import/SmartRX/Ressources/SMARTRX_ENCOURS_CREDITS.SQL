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
