unit mdlRequeteur;

interface

uses
  SysUtils, Classes, mdlModuleOutils, Menus, JvMenus;

type
  TdmRequeteur = class(TdmModuleOutils)
    mnuOutils: TMenuItem;
    mnuOutilsRequeteur: TMenuItem;
    procedure mnuOutilsRequeteurClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  dmRequeteur: TdmRequeteur;

implementation

uses mdlRequeteurSQL;

{$R *.dfm}

procedure TdmRequeteur.mnuOutilsRequeteurClick(Sender: TObject);
begin
  inherited;

  TfrmRequeteurSQL.Create(Self, Projet).ShowModal;
end;

initialization
  RegisterClasses([TdmRequeteur]);

finalization
  UnRegisterClasses([TdmRequeteur]);

end.
