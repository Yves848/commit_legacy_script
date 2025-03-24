select vrk_pat_Primkey,
       vrk_DatumAflevering,
	     vdp_prd_Cnk from dbo.VerkoopDetailProduct
join Verkoop on vrk_Primkey = vdp_vrk_Primkey
join patient on vrk_pat_Primkey = pat_primkey
where vdp_prd_Cnk in ('5520689','5520705','5520721','5520739','5520788','5521059') and vdp_DateChanged >= '01/01/2007'
order by vdp_DateChanged
