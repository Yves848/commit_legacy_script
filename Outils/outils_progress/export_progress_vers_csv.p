DEFINE TEMP-TABLE cumulmois
    FIELD cip AS CHAR
    FIELD annee AS INTEGER
    FIELD mois AS INTEGER
    FIELD qte AS INTEGER
INDEX cle cip annee mois.

FOR EACH phstat NO-LOCK WHERE YEAR(vente) > (YEAR(TODAY) - 2) :
    FIND FIRST cumulmois WHERE cumulmois.cip = phstat.cip AND
        cumulmois.annee = YEAR(phstat.vente) AND
        cumulmois.mois = MONTH(phstat.vente) NO-ERROR.

    IF NOT AVAILABLE cumulmois THEN DO:
        CREATE cumulmois.
        ASSIGN
            cumulmois.cip = phstat.cip
            cumulmois.annee = YEAR(phstat.vente)
            cumulmois.mois = MONTH(phstat.vente)
            cumulmois.qte = phstat.qte.
    END.
    ELSE cumulmois.qte = cumulmois.qte + phstat.qte.
END.

OUTPUT TO VALUE (SESSION:PARAMETER).

FOR EACH cumulmois:
    PUT UNFORM cumulmois.cip ";" cumulmois.annee ";" cumulmois.mois ";" cumulmois.qte ";" SKIP.     
END.

OUTPUT CLOSE.
QUIT.

