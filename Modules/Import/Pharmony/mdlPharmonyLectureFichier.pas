  unit mdlPharmonyLectureFichier;

interface

uses
  Windows, SysUtils, Classes, DateUtils, Dialogs, mdlLectureFichierBinaire, mdlLectureFichierCSV,
  xmlintf, StrUtils, Contnrs, mdlTypes, Generics.Collections, JclUnicode;

type
  TQuantiteDelivree = array[0..2] of Byte;

  TFichierPharmony = class(TFichierCSV)
  protected
  public
    constructor Create(AFichier: string;
      AParametres : Pointer = nil); override;
  end;

  
implementation

uses
  mdlPharmonyPHA;

type
  TSensException = (seAucun, se8Premier, se8Dernier, seAutomatique);

{ TFichierPharmony }

{ TFichierPharmony }

constructor TFichierPharmony.Create(AFichier: string; AParametres: Pointer);
begin
  inherited;

end;

end.
