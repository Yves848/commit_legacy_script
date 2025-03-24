select 
fidrx_card_nocli,
fidrx_card_carte
--,coalesce(fidrx_card_dtact, current_date)
from fidrxcartes
where fidrx_card_nocli ~ '^[0-9]+$'