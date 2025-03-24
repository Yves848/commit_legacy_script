select 
fou.labnolabo,
fou.labtype,
fou.labnom,
fou.labrepresentant,
fou.labtelrepres,
coalesce(fou.labcomment,''),
coalesce(nfo.grocomment,''),
nfo.gro_idfclient,
nfo.grotel,
nfo.gronorme,
nfo.gro_idrepart,
nfo.gro_coderepart,
nfo.gro_loginhttp,
nfo.gro_motpassehttp,
nfo.gro_cle_md5,
nfo.gro_url_un,
nfo.gro_url_deux,
adr.avoie1,
adr.avoie2,
coalesce(adr.acommune,''),
adr.abureau,
adr.acodepostal,
adr.atelephone,
coalesce(com.cacomplement[1],''),
coalesce(com.cacomplement[2],''),
coalesce(com.cacomplement[3],''),
coalesce(com.cacomplement[4],''),
coalesce(comc.comc,'')
from public.afb5 fou
left join af30 nfo on labnolabo=gronofour
LEFT JOIN public.af07 adr on ( acode = labnolabo and adr.atype = 31000 )
LEFT JOIN public.af09 com on ( cacode = labnolabo and com.catype = 31000 )
LEFT JOIN (select notcode, array_to_string(array_agg(nottexte order by notnoligne), chr(13)) comc
               from afnota
               where nottype = 31000 
               group by notcode) comc on comc.notcode = fou.labnolabo
--pas de doubnlon sur af07, af09 et af30 à priori
