select
cli.ccol_ratt  collectivite,
cli.ccode
FROM public.af04 cli
where ctypeclie = 'M' and cli.ccol_ratt <> 0