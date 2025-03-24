IF NOT CAN-FIND (FIRST _user WHERE _userid = "sysprogress") THEN DO:
    CREATE _user.
    ASSIGN
        _userid = "sysprogress"
        _password = encode("sysprogress").
END.
QUIT.

