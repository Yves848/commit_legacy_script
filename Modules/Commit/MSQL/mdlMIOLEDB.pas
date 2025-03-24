unit mdlMIOLEDB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, mdlProjet, mdlModule, mdlModuleImport, DB, ActnList, ImgList, PdfDoc, PReport,
  Menus, JvMenus, ExtCtrls, mdlPIPanel, JvXPBar, JvXPCore, JvXPContainer,
  JvWizard, JvWizardRouteMapNodes, ComCtrls, Grids, mdlPIStringGrid, DBGrids,
  mdlPIDBGrid, JvExControls, StdCtrls, VirtualTrees, JvExExtCtrls,
  JvNetscapeSplitter;

type
  TfrMIOLEDB = class(TfrModuleImport)
  private
    { Déclarations privées }
  protected
    procedure TraiterDonnee(ATraitement : TTraitement); override;
  public
    { Déclarations publiques }
  end;

implementation

uses mdlMIOLEDBPHA;

{$R *.dfm}

{ TfrOLEDB }


procedure TfrMIOLEDB.TraiterDonnee(ATraitement: TTraitement);
var
   aSql : tStrings;
begin
  if TTraitementBD(ATraitement).RequeteSelection <> '' then
  begin
    aSql := tStringList.create;
    aSql.LoadFromFile(Module.RepertoireRessources + '\' + TTraitementBD(ATraitement).RequeteSelection);
    dmMIOLEDBPHA.qryOLEDB.SQL.Text := aSql.Text;
    aSql.Free;
    inherited TraiterDonnee(ATraitement, dmMIOLEDBPHA.qryOLEDB);
  end
  else
    inherited TraiterDonnee(ATraitement);
end;

end.
