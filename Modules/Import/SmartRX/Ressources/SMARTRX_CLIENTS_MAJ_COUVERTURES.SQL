SELECT 
ben_asn||ben_asc,
substring(ben_dts_nais from 1 for 8),
ben_rge,
ben_qua,
ben_nusu, 
ben_pre,
ben_couv[1],
substring(ben_dts_debcouv[1] from 1 for 8),
substring(ben_dts_fincouv[1] from 1 for 8 )
-- ben_dts_debmut,
-- ben_dts_finmut,
-- ben_identmut,
-- ben_numserie

FROM public.afsben
union
SELECT 
ben_asn||ben_asc,
substring(ben_dts_nais from 1 for 8),
ben_rge,
ben_qua,
ben_nusu, 
ben_pre,
ben_couv[2],
substring(ben_dts_debcouv[2] from 1 for 8),
substring(ben_dts_fincouv[2] from 1 for 8 )
-- ben_dts_debmut,
-- ben_dts_finmut,
-- ben_identmut,
-- ben_numserie

FROM public.afsben