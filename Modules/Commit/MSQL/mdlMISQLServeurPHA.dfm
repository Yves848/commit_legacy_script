inherited dmMISQLServeurPHA: TdmMISQLServeurPHA
  OldCreateOrder = False
  inherited dbOLEDB: TADOConnection
    CommandTimeout = 0
    Provider = 'SQLOLEDB.1'
  end
  inherited qryOLEDB: TADOQuery
    CommandTimeout = 120
  end
end
