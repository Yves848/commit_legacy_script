select 
  fg.fg_id,
  fg.fg_naam$$, --ou fg_naam$$ pour NL
  fg.fg_adres,
  pc.pc_nummer,
  pc.pc_gemeente,
  fg.fg_telefoonnummer,
  fg.fg_btwnummer,
  fg.fg_taal,
  fg.fg_email
from 
  ftbfactgroepen fg
  left join ftbpostcodes pc on pc.pc_id = fg.fg_pc_id
order by 
  fg.fg_id