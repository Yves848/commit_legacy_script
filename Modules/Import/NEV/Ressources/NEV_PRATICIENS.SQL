select
prat.mnomedecin,
prat.mnom,
prat.minsee finess,
prat.mcodespecialite,
prat.mrpps,
adr.avoie1,
adr.avoie2,
coalesce(adr.acommune,''),
adr.abureau,
adr.acodepostal,
adr.atelephone,
coalesce(com.cacomplement[1],''),
coalesce(com.cacomplement[2],''),
coalesce(com.cacomplement[3],''),
coalesce(com.cacomplement[4],'')
FROM public.af05 prat
LEFT JOIN public.af07 adr on ( acode = mnomedecin and adr.atype = 32000 )
left join public.af09 com on (  mnomedecin = cacode and com.catype = 32000 )
