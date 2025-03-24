select substring(convert(varchar(7),vdp_datumaflevering,120),1,7),
       vdp_prd_primkey,
       sum(vdp_aantal),
       count(*)
from verkoopdetailproduct
where vdp_datumaflevering > getdate()-365*2 and vdp_aantal>0
group by vdp_prd_primkey,
         substring(convert(varchar(7),vdp_datumaflevering,120),1,7)
