select cnk, 
       denomination,
       code_langue,
       code_synonyme
from   mag11
where  code_synonyme = 0 and code_langue = 'F'