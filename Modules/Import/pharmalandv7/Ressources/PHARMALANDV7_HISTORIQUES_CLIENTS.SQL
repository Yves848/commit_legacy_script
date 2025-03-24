select
  l.lfffcleunik,
  l.lfnum,
  f.ffdtfac date_histo,
  f.ffdtord date_ordo,
  l.lfclient,
  l.lfnumligne,
  l.lfcip,
  l.lfcodeacte,
  l.lflibforme,
  l.lfvente,
  l.lfqte,
  f.fftocod
from ffacture f
  left join lfacture l on l.lfffcleunik = f.ffcleunik 
where
  lfclient <> ''
and lfdjou >= add_months(sysdate,-24) 