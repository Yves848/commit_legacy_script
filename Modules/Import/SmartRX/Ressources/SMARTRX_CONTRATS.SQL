select 
csnocontrat,
cslibelle,
csrembt[1] PH1_cent,

case when csmode = 2 then round(csrembt[2]*0.35+65)
else csrembt[2]  
end PH7_blanc,

case when csmode = 2 then round(csrembt[3]*0.7+30)
else csrembt[3] 
end PH4_bleu,

case when csmode = 2 then round(csrembt[6]*0.85+15)
else csrembt[6] 
end PH2_orange,

case when csmode = 2 then round(csrembt[7]*0.4+60)
else csrembt[7]  
end lpp,
csnatassurance,
csjustification,
cstypecontrat,
csmode
from af15