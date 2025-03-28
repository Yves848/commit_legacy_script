select K.K_KLANTNUMMER,
       VS.VO_DATUM,
       VI.VI_CNKNUMMER from FTBKLANTEN K
right join FTBVOORSCHRIFTEN VS on K.K_KLANTNUMMER = VS.VO_KLANTNUMMER
left join FTBVERKOOPITEMS VI on VS.VO_NUMMER = VI.VI_VSNUMMER
where VI.VI_CNKNUMMER in ('5520689','5520705','5520721',
                          '5520739','5520788','5521059') 
  and VS.VO_DATUM >= '01/01/2007'
order by VS.VO_DATUM