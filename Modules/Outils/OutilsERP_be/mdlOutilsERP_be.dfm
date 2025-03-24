inherited dmOutilsERP_be: TdmOutilsERP_be
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 293
  Width = 283
  inherited mnuMenuPrincipale: TJvMainMenu
    object OutilsERP1: TMenuItem
      Caption = 'Outils &ERP'
      object Sequenceordonanciersfactures1: TMenuItem
        Caption = '&Enr. Num. Ordonannce'
        OnClick = mnuERPToolsSeqOrdoClick
      end
      object EnrNumBlocTUH: TMenuItem
        Caption = 'Enr. Num. &Bloc/sch'#233'ma TUH '
        OnClick = EnrNumBlocTUHClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Gestiondescartesristournes1: TMenuItem
        Caption = '&Gestion des cartes ristournes'
        OnClick = mnuERPToolsGestionCartesRistournes
      end
    end
  end
end
