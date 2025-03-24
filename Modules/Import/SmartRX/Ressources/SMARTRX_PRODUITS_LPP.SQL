select 
prd.pnocip,
act.tab_zon[1],
prd.ploctarif
from public.afb1 prd  
left join afztab act on (act.tab_codtab = 'ACTSV' and act.tab_codent = '0000'|| prd.pnature )
where prd.ploctarif >   ''