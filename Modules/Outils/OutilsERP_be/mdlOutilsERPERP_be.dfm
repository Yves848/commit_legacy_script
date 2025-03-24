inherited dmOutilsERPERP_be: TdmOutilsERPERP_be
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 235
  Width = 456
  inherited mnuMenuPrincipale: TJvMainMenu
    Left = 336
    Top = 136
  end
  object sp: TOraStoredProc
    StoredProcName = 'migration.PK_SUPPRIMER.INITIALISER_SEQUENCE'
    SQL.Strings = (
      'begin'
      
        '  migration.PK_SUPPRIMER.INITIALISER_SEQUENCE(:ASEQUENCE, :ADEBU' +
        'T);'
      'end;')
    Left = 288
    Top = 24
    ParamData = <
      item
        DataType = ftString
        Name = 'ASEQUENCE'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'ADEBUT'
        ParamType = ptInput
      end>
  end
  object qryNoOrdo: TOraQuery
    SQLRefresh.Strings = (
      'select '
      '  t_destinataire_id,'
      '  nom,'
      '  numero_lot'
      'from v_numero_lot'
      'where t_destinataire_id = :t_destinataire_id')
    AfterClose = qryNoOrdoAfterClose
    AfterPost = qryNoOrdoAfterPost
    Left = 88
    Top = 64
    object qryNoOrdoT_DESTINATAIRE_ID: TFloatField
      FieldName = 'T_DESTINATAIRE_ID'
    end
    object qryNoOrdoNOM: TStringField
      DisplayLabel = 'Nom'
      FieldName = 'NOM'
      Size = 50
    end
    object qryNoOrdoNUMLOT: TFloatField
      DisplayLabel = 'N'#176' de lot'
      FieldName = 'NUMERO_LOT'
    end
  end
end
