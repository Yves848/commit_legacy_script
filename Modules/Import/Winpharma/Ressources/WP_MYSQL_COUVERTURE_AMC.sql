select
  code,
  code_muturemb
from
  mutuel
union
select
  mutu_code,
  CodeMRembt
from 
  MutuRemb
order by 1, 2