unit mdlAuditHomeo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, ExtCtrls, ComCtrls, mdlPIDBGrid, Menus,
  mdlDialogue, ImgList, ToolWin, uib, ActnList, DBClient, JvMenus;

type
  TfrmAuditHomeo = class(TfrmDialogue)
    pCtrlAuditHomeo: TPageControl;
    tShAdHCIP: TTabSheet;
    tShAdHFournisseur: TTabSheet;
    tShAdHForcage: TTabSheet;
    pmnuForcageTypeHomeo: TJvPopupMenu;
    mnuForcagePetitPx: TMenuItem;
    mnuForcagePetitGd: TMenuItem;
    mnuForcageAucunPx: TMenuItem;
    grdAHForcage: TPIDBGrid;
    pnlAudHFourPetitPx: TPanel;
    grdAHFourPetitPrix: TPIDBGrid;
    pnlAutHFourGrandPx: TPanel;
    grdAHFourGrandPrix: TPIDBGrid;
    pnlAudHCIPPetitPx: TPanel;
    grdAHCIPPetitPrix: TPIDBGrid;
    pnlAudHCIPGrandPx: TPanel;
    grdAHCIPGrandPrix: TPIDBGrid;
    dsHGrandPrix: TDataSource;
    cdsHGrandPrix: TClientDataSet;
    cdsHPetitPrix: TClientDataSet;
    dsHPetitPrix: TDataSource;
    mnuSeparateur_1: TMenuItem;
    dsFournisseursDirect: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure pCtrlAuditHomeoChange(Sender: TObject);
    procedure mnuForcageTypeHomeoClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

const
  C_PAGE_AUDITHOMEO_CIP = 0;
  C_PAGE_AUDITHOMEO_FOURNISSEUR = 1;
  C_PAGE_AUDITHOMEO_FORCAGE = 2;

var
  frmAuditHomeo: TfrmAuditHomeo;

implementation
{$R *.dfm}

uses mdlOutilsPHAPHA_be;

procedure TfrmAuditHomeo.FormCreate(Sender: TObject);
begin
  inherited;

  pCtrlAuditHomeo.ActivePageIndex := C_PAGE_AUDITHOMEO_CIP;
  pCtrlAuditHomeoChange(Self);
end;

procedure TfrmAuditHomeo.pCtrlAuditHomeoChange(Sender: TObject);

  procedure InitDataSet(ADataSet : TClientDataSet);
  begin
    if ADataSet.Active then
    begin
      if not ADataSet.IsEmpty then
        ADataSet.EmptyDataSet;
      ADataSet.Close;
    end;

    if ADataSet.Fields.Count > 0 then ADataSet.Fields.Clear;
    if ADataSet.FieldDefs.Count > 0 then ADataSet.FieldDefs.Clear;
  end;

  procedure ChargerDataSet(ASource : TDataset; ADestinataire : TClientDataSet; AFiltre : string);
  var
    i : Integer;
    lStrChampFiltre, lStrValeurFiltre : string;
    lIntPos : Integer;
    lBoolOkPourCopie : Boolean;
    lChamp : TField;
  begin
    // Ananlyse du filtre
    lIntPos := Pos('=', AFiltre);
    if lIntPos > 0 then
    begin
      lStrChampFiltre := Trim(Copy(AFiltre, 1, lIntPos - 1));
      lStrValeurFiltre := Trim(Copy(AFiltre, lIntPos + 1, Length(AFiltre)));
    end
    else
      lStrChampFiltre := '';

    // Copie
    ASource.Open;
    for i := 0 to ASource.FieldCount - 1 do
      if ASource.Fields[i].Visible then
        with TFieldClass(ASource.Fields[i].ClassType).Create(ADestinataire) do
        begin
          Name := ADestinataire.Name + ASource.Fields[i].FieldName;
          FieldName := ASource.Fields[i].FieldName;
          DataSet := ADestinataire;
          DisplayLabel := ASource.Fields[i].DisplayLabel;
          Size := ASource.Fields[i].Size;
          Required := ASource.Fields[i].Required;
        end;
    ADestinataire.CreateDataSet;

    while not ASource.EOF do
    begin
      // Application du filtre
      if lStrChampFiltre = '' then
        lBoolOkPourCopie := True
      else
      begin
        lChamp := ASource.FindField(lStrChampFiltre);
        if Assigned(lChamp) then
          lBoolOkPourCopie := lChamp.AsString = lStrValeurFiltre
        else
          lBoolOkPourCopie := True;
      end;

      if lBoolOkPourCopie then
      begin
        ADestinataire.Append;
        for i := 0 to ADestinataire.FieldCount - 1 do
          ADestinataire.Fields[i].Value := ASource.FieldByName(ADestinataire.Fields[i].FieldName).Value;
        ADestinataire.Post;
      end;
      ASource.Next;
    end;
    ASource.Close;
  end;

  procedure MiseEnFormeGrille(AGrille : TPIDBGrid);
  var
    i : Integer;
  begin
    with AGrille do
    begin
      DataSource.DataSet.First;
      AjusterLargeurColonnes;
      for i := 0 to Columns.Count - 1 do
        Columns[i].Title.Alignment := taCenter;
    end;
  end;

begin
  inherited;

  InitDataSet(cdsHPetitPrix);
  InitDataSet(cdsHGrandPrix);
  case pCtrlAuditHomeo.ActivePageIndex of
    C_PAGE_AUDITHOMEO_CIP :
      begin
        dmOutilsPHAPHA_be.trDataset.StartTransaction;
        ChargerDataSet(dmOutilsPHAPHA_be.setAuditHomeoCIP, cdsHPetitPrix, 'type_homeo = 2'); MiseEnFormeGrille(grdAHCIPPetitPrix);
        ChargerDataSet(dmOutilsPHAPHA_be.setAuditHomeoCIP, cdsHGrandPrix, 'type_homeo = 1'); MiseEnFormeGrille(grdAHCIPGrandPrix);
        dmOutilsPHAPHA_be.trDataset.Commit;
      end;

    C_PAGE_AUDITHOMEO_FOURNISSEUR :
      begin
        dmOutilsPHAPHA_be.trDataset.StartTransaction;
        ChargerDataSet(dmOutilsPHAPHA_be.setAuditHomeoFD, cdsHPetitPrix, 'type_homeo = 2'); MiseEnFormeGrille(grdAHFourPetitPrix);
        ChargerDataSet(dmOutilsPHAPHA_be.setAuditHomeoFD, cdsHGrandPrix, 'type_homeo = 1'); MiseEnFormeGrille(grdAHFourGrandPrix);
        dmOutilsPHAPHA_be.trDataset.Commit;        
      end;

    C_PAGE_AUDITHOMEO_FORCAGE :
      begin
        dmOutilsPHAPHA_be.setFournisseursDirect.Open;
      end;
  end;
end;

procedure TfrmAuditHomeo.mnuForcageTypeHomeoClick(Sender: TObject);
begin
  inherited;

  with dmOutilsPHAPHA_be, sp do
  begin
    Transaction.StartTransaction;
    BuildStoredProc('ps_utl_pha_forcer_homeo');
    Params.ByNameAsInteger['ATYPEHOMEO'] := (Sender as TMenuItem).Tag;
    Params.ByNameAsString['AFOURNISSEURDIRECTID'] := setFournisseursDirectID.AsString;
    Execute;
    Transaction.Commit;
  end;
end;

end.
