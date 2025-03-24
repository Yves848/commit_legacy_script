select rkb_primkey, 
       rkb_rek_primkey,
       max(pat_primkey),
       rkb_DateChanged,
       rkb_Id
from RekeningBarcode
inner join rekening on rek_primkey= rkb_rek_primkey
inner join patient on pat_rek_primkey = rkb_rek_primkey
where isnumeric(substring(rkb_Id,2,13))= 1 
group by rkb_primkey, 
         rkb_rek_primkey,
         rkb_DateChanged,
         rkb_Id