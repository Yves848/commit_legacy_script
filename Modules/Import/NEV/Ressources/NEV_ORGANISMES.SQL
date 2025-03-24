select
otypeorg,
otype,
ocode,
otypetrans,
onom,
oregime,
onational,
substring(omutzone1||omutzone2 from '........$' ),
0 santepharma,
ocmu,                        
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
from af50
LEFT JOIN public.af07 adr on ( :otype||'_'||:ocode = :atype||'_'||:acode and adr.atype not in (0, 31000,32000))
LEFT JOIN public.af09 com on ( :catype||'_'||:cacode = :atype||'_'||:acode and com.catype not in (0, 31000,32000))
-- pas de doublon à priori sur la liaison af07 donc pas de traitement spécifique
