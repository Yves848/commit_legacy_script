              SELECT 
cli.ccode,
cli.ctypeclie,
cli.ccol_ratt  collectivite,
cli.cnoss,
cli.cnom,    
cli.cprenom,
cli.cnomjf,
case 
  when cli.cjjnaissance>=1 then cast(1900+cli.caanaissance as char(4))||lpad(cast(cli.cmmnaissance as char(2)),2,'0' )||lpad(cast(cli.cjjnaissance as char(2)),2,'0' )
  else null
end,                            
cli.cayantdroit,
cli.cvar rang,
coalesce(cli.cobs,''),
coalesce(cli.cob2,''),
cli.cdatefacture,
cli.csexe,
cli.cdatecreation,
adr.avoie1,
adr.avoie2,
coalesce(adr.acommune,''),
adr.abureau,
adr.acodepostal,
adr.atelephone,
telperso.conta_valeur tel_perso,
telporta.conta_valeur tel_porta,
mail.conta_valeur mail,
coalesce(com.cacomplement[1],''),
coalesce(com.cacomplement[2],''),
coalesce(com.cacomplement[3],''),
coalesce(com.cacomplement[4],''),
coalesce(comc.comc,''),
comc.nottype
FROM public.af04 cli
LEFT JOIN public.af07 adr on ( acode = cli.ccode and adr.atype = 0 )
LEFT JOIN public.af09 com on ( acode = cacode and com.catype = 0 )
LEFT JOIN (select notcode, nottype, array_to_string(array_agg(nottexte order by notnoligne), chr(13)) comc
               from afnota
               where (nottype = 0) or (nottype = 33000) 
               group by notcode, nottype) comc on comc.notcode = cli.ccode
LEFT JOIN afconta telperso on (cast(telperso.conta_nointerne as integer) = cli.ccode and telperso.conta_code = 'TELPERSO' and telperso.conta_entite = 'CLI')
LEFT JOIN afconta telporta on (cast(telporta.conta_nointerne as integer) = cli.ccode and telporta.conta_code = 'TELPORTA' and telporta.conta_entite = 'CLI')
LEFT JOIN afconta mail on (cast(mail.conta_nointerne as integer) = cli.ccode and mail.conta_code = 'MAIL' and mail.conta_entite = 'CLI')

