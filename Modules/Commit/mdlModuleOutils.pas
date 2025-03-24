unit mdlModuleOutils;

interface

uses
  SysUtils, Classes, mdlProjet, Menus, Forms, JvMenus;

type
  TdmModuleOutils = class(TDataModule)
    mnuMenuPrincipale: TJvMainMenu;
  private
    FProjet: TProjet;
    { Déclarations privées }
  public
    { Déclarations publiques }
    property Projet : TProjet read FProjet;
    constructor Create(AOwner : TComponent; AProjet : TProjet); reintroduce; virtual;
  end;
  TdmModuleOutilsClasse = class of TdmModuleOutils;

implementation

{$R *.dfm}

{ TdmModuleOutils }

constructor TdmModuleOutils.Create(AOwner: TComponent; AProjet: TProjet);
begin
  inherited Create(AOwner);

  FProjet := AProjet;
end;

end.
