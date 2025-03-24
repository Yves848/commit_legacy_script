inherited dmOutilsERPERP_fr: TdmOutilsERPERP_fr
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 235
  Width = 456
  inherited mnuMenuPrincipale: TJvMainMenu
    Left = 336
    Top = 136
  end
  object qryOrgStat: TOraQuery
    SQL.Strings = (
      'select'
      '  type_organisme,'
      '  nom,'
      '  identifiant_national,'
      '  nb_clients'
      'from migration.v_stat_clients_par_organismes')
    ReadOnly = True
    Left = 112
    Top = 80
    object qryOrgStatTYPE_ORGANISME: TStringField
      Alignment = taCenter
      DisplayLabel = 'Type org.'
      FieldName = 'TYPE_ORGANISME'
      Size = 3
    end
    object qryOrgStatNOM: TStringField
      DisplayLabel = 'Nom'
      FieldName = 'NOM'
      Size = 50
    end
    object qryOrgStatIDENTIFIANT_NATIONAL: TStringField
      DisplayLabel = 'Id. nat.'
      FieldName = 'IDENTIFIANT_NATIONAL'
      Size = 9
    end
    object qryOrgStatNB_CLIENTS: TFloatField
      DisplayLabel = 'Nb. cli.'
      FieldName = 'NB_CLIENTS'
    end
  end
  object qryProdStat: TOraQuery
    SQL.Strings = (
      'select'
      '  taux_tva,'
      '  sum(nb_produits) nb_produits,'
      '  sum(nb_unites) nb_unites,'
      '  sum(total_prix_achat_catalogue) total_prix_achat_catalogue,'
      '  sum(total_prix_vente) total_prix_vente,'
      '  sum(total_pamp) total_pamp'
      'from'
      '  migration.v_stat_inventaire_produits'
      'group by'
      '  taux_tva'
      'order by taux_tva'
      '')
    ReadOnly = True
    Left = 40
    Top = 80
    object qryProdStatTAUX_TVA: TFloatField
      DisplayLabel = 'TVA'
      FieldName = 'TAUX_TVA'
      Required = True
    end
    object qryProdStatNB_PRODUITS: TFloatField
      DisplayLabel = 'Nb. produits'
      FieldName = 'NB_PRODUITS'
    end
    object qryProdStatNB_UNITES: TFloatField
      DisplayLabel = 'Nb. unit'#233's'
      FieldName = 'NB_UNITES'
    end
    object qryProdStatTOTAL_PRIX_ACHAT_CATALOGUE: TFloatField
      DisplayLabel = 'Tot. PA HT'
      FieldName = 'TOTAL_PRIX_ACHAT_CATALOGUE'
    end
    object qryProdStatTOTAL_PRIX_VENTE: TFloatField
      DisplayLabel = 'Tot. PV TTC'
      FieldName = 'TOTAL_PRIX_VENTE'
    end
    object qryProdStatTOTAL_PAMP: TFloatField
      DisplayLabel = 'Tot. PAMP'
      FieldName = 'TOTAL_PAMP'
    end
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
  object qryNoLot: TOraQuery
    SQLUpdate.Strings = (
      'begin'
      '  migration.pk_organismes.maj_numero_lot('
      '    :t_destinataire_id,'
      '    :numero_lot);'
      'end;')
    SQLRefresh.Strings = (
      'select '
      '  t_destinataire_id,'
      '  nom,'
      '  numero_lot'
      'from v_numero_lot'
      'where t_destinataire_id = :t_destinataire_id')
    SQL.Strings = (
      'select '
      '  t_destinataire_id,'
      '  nom,'
      '  numero_lot'
      'from v_numero_lot')
    AfterClose = qryNoLotAfterClose
    AfterPost = qryNoLotAfterPost
    Left = 32
    Top = 136
    object qryNoLotT_DESTINATAIRE_ID: TFloatField
      FieldName = 'T_DESTINATAIRE_ID'
    end
    object qryNoLotNOM: TStringField
      DisplayLabel = 'Nom'
      FieldName = 'NOM'
      Size = 50
    end
    object qryNoLotNUMLOT: TFloatField
      DisplayLabel = 'N'#176' de lot'
      FieldName = 'NUMERO_LOT'
    end
  end
end
