unit uYZYRecords;

interface
type
  TLogType = (etHeader, etInfo, etSuccess, etWarning, etError, etCritical, etException, etDebug, etTrace, etDone, etCustom1, etCustom2);

  tYZYPOSTProducts = record
    sUrl  : String;
    sFile : String;
  end;

  tYZYResponse = record
    id : String;
  end;

  tYZYLog = record
    sType : tLogType;
    sMessage : String;
  end;

implementation

end.
