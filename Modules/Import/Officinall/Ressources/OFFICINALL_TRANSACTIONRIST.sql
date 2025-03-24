select
 mem_primkey,
 rek_primkey,
 'A'+cast(pat_primkey as varchar(49)),
 mem_ristorno0,
 mem_ristorno6,
 mem_ristorno12,
 mem_ristorno21,
 0,
 mem_DateChanged,
 '2'
from memopatient
 inner join patient on pat_primkey=mem_pat_primkey
 left JOIN Rekening ON rek_primkey = pat_rek_Primkey  
where mem_type=4
---- mem a laisser ?

union all

SELECT
 rek_primkey,
 rek_primkey,
 '',
 sum(kor_kortBtw1) AS Korting0,
 sum(kor_kortBtw2) AS Korting6,
 sum(kor_kortBtw3) AS Korting12,
 sum(kor_kortBtw4) AS Korting21,
 sum(kor_Totaal) AS KortingTotaal,
 max(kor_DateChanged),
 '0'
FROM  dbo.Korting
	  INNER JOIN Rekening ON rek_primkey = kor_rek_Primkey
WHERE
kor_rek_Primkey > 0 AND kor_ReleaseId=0 
group by rek_primkey
