SELECT
cli.ti,
groupTi

FROM clients0 cli
left join memores com on (com.ti = cli.memo_ti and com.tbln =1 and cli.memo_ti>0 )
left join memores gsm on (gsm.ti = cli.ti and gsm.tbln =6015 )
where ((1 & clitype = 1) or  ( ( CliType >>3)&1 = 1  ))
and groupTi > 0