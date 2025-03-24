select 
index_payeur, --index_assure si pb
max(DateFacture),
sum(MontantTTC - partamoreel - partamcreel - reglement_assure ) reste_du 
from factures
where   index_typefacture IN ( 0,2,6,7)      
AND (MontantTTC - partamoreel - partamcreel - reglement_assure ) <> 0
group by index_payeur