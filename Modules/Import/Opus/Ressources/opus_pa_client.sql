SELECT 
ben.be_code,
sum(pri.lf_quant),
sum(pri.lf_pttal)

FROM privileg pri
LEFT JOIN Assure ASs ON pri.pv_code = ASs.as_cpriv
LEFT JOIN benefice ben ON ben.as_code = ass.as_code 
WHERE pri.pv_etat = 'A' and ben.qu_code = '00'
group by ben.be_code