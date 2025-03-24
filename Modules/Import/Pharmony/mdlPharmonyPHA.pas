unit mdlPharmonyPHA;

interface

uses
  SysUtils, Classes, DB, mdlPHA, Dialogs, UIBDataSet, UIB, UIBLib, JvComponent,
  Variants, mydbUnit, FBCustomDataSet, mdlModuleImportPHA, mdlLectureFichierCSV,
  mdlProjet, DateUtils, IniFiles, mdlAttente, mdlTypes, XMLIntf, StrUtils, Generics.Collections,  Contnrs, XSBuiltIns;

type
  TdmPharmonyPHA = class(TdmModuleImportPHA)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Déclarations privées }
    jsonArray   : TList<string>;
    galForms    : TList<string>;
    galFormsSU  : TList<string>;
  public
    { Déclarations publiques }
    function CreerDonnees(AID, APS : string;
      ADonnees : TDonneesCSV; ANombreValeurs : Integer = -1) : TResultatCreationDonnees; overload;
    function CreerDonneesSchema(AID, APS : string;
      ADonnees : TDonneesCSV; ANombreValeurs : Integer = -1) : TResultatCreationDonnees;
    function CreerDonneesSchemaDetail(AID, APS: string; ADonnees: TDonneesCSV;
      ANombreValeurs: Integer): TResultatCreationDonnees;
    function CreerDonneesFichesAnalyse(AID, APS: string; ADonnees: TDonneesCSV;
      ANombreValeurs: Integer): TResultatCreationDonnees;
    function CreerDonnesMagistrales(AID, APS : string; aDonnees : TDonneesCSV; aNombreValeurs : Integer) : TResultatCreationDonnees;
      function iso8601toDate(s : string) : String;
  end;

var
  dmPharmonyPHA : TdmPharmonyPHA;

implementation

{$R *.dfm}

function TdmPharmonyPHA.CreerDonnees(AID, APS: string; ADonnees: TDonneesCSV;
  ANombreValeurs: Integer): TResultatCreationDonnees;
var
  I: Integer;
  V: Variant;
begin
  if jsonArray.IndexOf(AID) > -1 then
  begin
    case jsonArray.IndexOf(AID) of
       0 : Result := CreerDonneesSchema(AID,APS,ADonnees,6); // Schema
       1 : Result := CreerDonneesSchemaDetail(AID,APS,ADonnees,21);// Schemadetail
       2 : Result := CreerDonneesFichesAnalyse(AID,APS,ADonnees,16);// component_analysis_record
       3 : Result := CreerDonnesMagistrales(AID,APS,ADonnees,ANombreValeurs); //Preparations.csv
    end;
  end
  else
  if (ANombreValeurs = -1) or (ADonnees.Valeurs.Count = ANombreValeurs) then
  begin
    V := VarArrayCreate([0, ADonnees.Valeurs.Count], varVariant);
    for I := 0 to ADonnees.Valeurs.Count - 1 do
      if (Trim(ADonnees.Valeurs[I]) = '') or (ADonnees.Valeurs[I] = '""') then
        V[I] := null
      else
        V[I] := ADonnees.Valeurs[I];

    Result := ExecuterPS(AID, APS, V);
  end
  else
    Result := rcdRejetee;
end;

function TdmPharmonyPHA.CreerDonneesFichesAnalyse(AID, APS: string; ADonnees: TDonneesCSV;
  ANombreValeurs: Integer): TResultatCreationDonnees;
{$REGION 'Paramètres'}
  (*
     0 : no_analyse dm_code,
     1 : cnk_produit int,
     2 : no_autorisation varchar(20),
     3 : ReferenceAnalytique varchar(20),
     4 : date_entree date,
     5 : fabricant_id varchar(4),
     6 : grossiste_id varchar(4),
     7 : no_lot varchar(20),
     8 : prix_achat_total float,
     9 : no_bon_livraison varchar(20),
    10 : date_ouverture date,
    11 : date_peremption date,
    12 : date_fermeture date,
    13 : quantite_initial float,
    14 : quantite_restante dm_float7_2,
    15 : unites dm_varchar5,
    16 : remarques varchar(5000),

  *)

  (*
     0 : id
     1 : analysis_number
     2 : auth_number
     3 : certificate
     4 : created_at
     5 : close_date
     6 : component_id
     7 : encoding_date
     8 : expiry_date
     9 : group_id
    10 : laboratory_id
    11 : lot_number
    12 : open_date
    13 : product_code
    14 : purchase_date
    15 : pending
    16 : pharmacy_id
    17 : price
    18 : quantity
    19 : reference
    20 : remark
    21 : remaining_quantity
    22 : status
    23 : supplier_id
    24 : unit
    25 : updated_at
    26 : ui_count
    27 : ui_conversion_count
    28 : ui_conversion_unit
    29 : ui_unit
    30 : valid_status
    31 : code
  *)
{$ENDREGION}
var
  I: Integer;
  V: Variant;
  sDec : Char;

  function sDate(s : string) : String;
  var
     sDay,
     sMonth,
     sYear : String;
  begin
    Result := s + ' 00:00:00.0000';
  end;
begin
  if ADonnees.Valeurs.Count < 32 then
      result := rcdRejetee // Rejeté : ne contient pas de numéro de produit.
   else
   begin
      sdec := DecimalSeparator;
      DecimalSeparator := '.';
      V := VarArrayCreate([0, ANombreValeurs], varVariant);
      V[0] := ADonnees.Valeurs[1]; // no_analyse dm_code
      V[1] := strtointdef(ADonnees.Valeurs[31],0);//1 : cnk_produit int
      V[2] := ADonnees.Valeurs[2]; // no_autorisation varchar(20)
      V[3] := ADonnees.Valeurs[19]; // ReferenceAnalytique varchar(20)
      V[4] := ADonnees.Valeurs[4]; // date_entree date
      V[5] := ADonnees.Valeurs[10]; // fabricant_id varchar(4)
      V[6] := ADonnees.Valeurs[23]; // grossiste_id varchar(4)
      V[7] := ADonnees.Valeurs[11]; // no_lot varchar(20)
      V[8] := ADonnees.Valeurs[17]; // prix_achat_total float
      V[9] := ADonnees.Valeurs[19]; // no_bon_livraison varchar(20)
      V[10] := iso8601toDate(ADonnees.Valeurs[12]); // date_ouverture date
      V[11] := iso8601toDate(ADonnees.Valeurs[8]); // date_peremption date
      V[12] := iso8601toDate(ADonnees.Valeurs[5]); // date_fermeture date
      V[13] := StrToFloatDef(ADonnees.Valeurs[18],0); // quantite_initial float
      V[14] := StrToFloatDef(ADonnees.Valeurs[21],0); // quantite_restante dm_float7_2
      V[15] := ADonnees.Valeurs[24]; // unites dm_varchar5
      V[16] := ADonnees.Valeurs[20]; // remarques varchar(5000)
      DecimalSeparator := sDec;
      Result := ExecuterPS(AID, APS, V);
      //Result := rcdImportee;
      // EXECUTE PROCEDURE "PS_CREER_FICHEANALYSE" ('62bdc447beaff6f4873b011d',588822,'756R02675','4',null,'30216','31591','21H06/V16379',12.6000003814697,'4',null,null,null,500,240,'gr','')
   end;
end;

function TdmPharmonyPHA.CreerDonneesSchema(AID, APS: string; ADonnees: TDonneesCSV;
  ANombreValeurs: Integer): TResultatCreationDonnees;
var
  I: Integer;
  V: Variant;
begin
{$REGION 'Paramètres'}
  (*
     0 : id
     1 : advice
     2 : additional_at
     3 : begin_condition
     4 : chronic
     5 : created_at
     6 : contact_id
     7 : died_at
     8 : day_interval
     9 : end_at
    10 : end_condition
    11 : forced_product
    12 : finish_package
    13 : frequency_type
    14 : group_id
    15 : has_halves
    16 : has_quarters
    17 : internal_code
    18 : inn_cluster_code
    19 : last_daily_average
    20 : lastly_delivered_at
    21 : last_day_index
    22 : needed_advice
    23 : pharmacy_id
    24 : prescription_printing_count
    25 : original_preparation_id
    26 : requested_code
    27 : removed_at
    28 : removed_by_id
    29 : status
    30 : start_at
    31 : updated_at
    32 : reason
    33 : week_neeeded_quarter
    34 : product_id
  *)
{$ENDREGION}
   if ADonnees.Valeurs.Count < 35 then
      result := rcdRejetee // Rejeté : ne contient pas de numéro de produit.
   else
   begin
      V := VarArrayCreate([0, ANombreValeurs], varVariant);
      V[0] := ADonnees.Valeurs[0]; // SchemaID
      if (ADonnees.Valeurs[34] <> '') then
        V[1] := ADonnees.Valeurs[34] // Product ID
      else
        V[1] := null;
      V[2] := ADonnees.Valeurs[6]; // Patient ID
      V[3] := iso8601toDate(ADonnees.Valeurs[5]); // Date Debut
      V[4] := iso8601toDate(ADonnees.Valeurs[27]); // Date Fin
      V[5] := ADonnees.Valeurs[1]; // Commentaire
      //V[6] := 'Schema'; // Libelle
      Result := ExecuterPS(AID, APS, V);
   end;
end;

function TdmPharmonyPHA.CreerDonneesSchemaDetail(AID, APS: string; ADonnees: TDonneesCSV;
  ANombreValeurs: Integer): TResultatCreationDonnees;
    {$REGION 'Paramètres'}
    (*
       0 : SCHEMA_ID dm_code,
       1 : TYPESCHEMA Integer,
    	 2 : FREQUENCE Integer,
    	 3 : TYPE_FREQUENCE Integer,
       4 : FREQUENCE_JOURS varchar(7),
       5 : PRISEAULEVER float,
       6 : SPPDNBAV float,
       7 : SPPDNBPENDANT float,
       8 : SPPDNBAPRES float,
       9 : PRISE10H00 float,
      10 : SPDNNBAV float,
      11 : SPDNNBPENDANT float,
      12 : SPDNNBAPRES float,
      13 : PRISE16H00 float,
      14 : SPSPNBAV float,
      15 : SPSPNBPENDANT float,
      16 : SPSPNBAPRES float,
      17 : PRISE20H float,
      18 : PRISEAUCOUCHER float)
    *)
    (*
       0 : schema_id
       1 : id
       2 : admin_mode
       3 : days
       4 : day_index
       5 : month
       6 : route
       7 : t1
       8 : t2
       9 : t2a
      10 : t2b
      11 : t3
      12 : t4
      13 : t4a
      14 : t4b
      15 : t5
      16 : t6
      17 : t6a
      18 : t6b
      19 : t7
      20 : t8
      21 : frequency_type
      22 : days_interval

      SU :
      Comprimés = 1
      Cuillères à café = 2
      Cuillères à soupe = 3
      Gélule = 4
      Goutte = 5
      Injections = 6
      Pulvérisation = 7
      Suppositoires = 8
      Sachet = 9
      Ampoule = 10
      Application = 11
      Cuillères ou godets mesure = 12
      Ampoule = 13 (Oui, encore 'ampoule', mais je ne sais pas pourquoi, là)
Unité = 14
    *)
  {$ENDREGION}
const
  aJours : array[0..6] of string  = ('1','2','3','4','5','6','7');
var
    V: Variant;
    i : Integer;
    FreqJours : String;
    sdec : Char;
    itypeAdmin : Integer;
begin
  if ADonnees.Valeurs.Count < 23 then
    result := rcdRejetee
  else
  begin
    FreqJours := '0000000';
    V := VarArrayCreate([0, ANombreValeurs], varVariant);
    V[0] := ADonnees.Valeurs[0]; // Id
    itypeAdmin := StrToIntDef(ADonnees.Valeurs[2],103);
    case iTypeAdmin of
      100 : begin
            V[1] := 10;
      end; // "Ampoule",
      101 : begin
            v[1] := 11;
      end; // "Application",
      102 : begin
            V[1] := 1;
      end; // "Cachet",
      103 : begin
             V[1] := 1;
      end; // "Comprimé",
      104 : begin
             V[1] := 2;
      end; // "5ml (C.à café)"
      105 : begin
              V[1] := 2;
      end; // "10ml(C. à dessert)",
      106 : begin
              V[1] := 3;
      end; // "15ml (C. à soupe)",
      107 : begin
              V[1] := 4;
      end; // "Gélule",
      108 : begin
               V[1] := 1;
      end; // "Gomme",
      109 : begin
                V[1] := 5;
      end; // "Goutte",
      110 : begin
                V[1] := 1;
      end; // "Inhalation",
      111 : begin
                V[1] := 6;
      end; // "Injection",
      112 : begin
             V[1] := 11;
      end; // "Lavage",
      113 : begin
             V[1] := 11;
      end; // "Mesure",
      114 : begin
             V[1] := 6;
      end; // "Ovule",
      115 : begin
             V[1] := 11;
      end; // "Patch",
      116 : begin
             V[1] := 1;
      end; // "Perle",
      117 : begin
             V[1] := 1;
      end; // "Pilule",
      118 : begin
             V[1] := 13;
      end; // "Pipette",
      119 : begin
             V[1] := 7;
      end; // "Pulvérisation",
      120 : begin
           V[1] := 9;
      end; // "Sachet",
      121 : begin
            V[1] := 8
      end; // "Suppositoire",

    end;
    V[2] := StrToIntDef(ADonnees.Valeurs[22],1); // Days Interval
    V[3] := ADonnees.Valeurs[21]; // Frequency
    if (Length(ADonnees.Valeurs[3]) > 0) then
    begin
      i := 0;
      while (i <=length(aJours) - 1) do
      begin
        if Pos(aJours[i],ADonnees.Valeurs[3]) > 0 then
        begin
          FreqJours[i+1] := '1';
        end;
        inc(i);
      end;
    end;

    sdec := DecimalSeparator;
    DecimalSeparator := '.';
    V[4] := FreqJours; // jours de la semaine
    v[5] := StrToFloat(ADonnees.Valeurs[7]);// Prise au lever
    v[6] := StrToFloat(ADonnees.Valeurs[10]);// Déjeuner AVANT
    v[7] := StrToFloat(ADonnees.Valeurs[8]);// Déjeuner PENDANT
    v[8] := StrToFloat(ADonnees.Valeurs[9]);// Déjeuner APRES
    v[9] := StrToFloat(ADonnees.Valeurs[11]);// 10H00
    v[10] := StrToFloat(ADonnees.Valeurs[14]);// Dîner AVANT
    v[11] := StrToFloat(ADonnees.Valeurs[12]);// Dîner PENDANT
    v[12] := StrToFloat(ADonnees.Valeurs[13]); // Dîner APRES
    v[13] := StrToFloat(ADonnees.Valeurs[15]); // 16h00
    v[14] := StrToFloat(ADonnees.Valeurs[18]); // Souper AVANT
    v[15] := StrToFloat(ADonnees.Valeurs[16]); // Souper PENDANT
    v[16] := StrToFloat(ADonnees.Valeurs[17]); // Souper APRES
    v[17] := StrToFloat(ADonnees.Valeurs[19]); // 20H
    v[18] := StrToFloat(ADonnees.Valeurs[20]); // Coucher
    DecimalSeparator := sDec;
    Result := ExecuterPS(AID, APS, V);
  end;
end;

function TdmPharmonyPHA.CreerDonnesMagistrales(AID, APS: string; aDonnees: TDonneesCSV;
  aNombreValeurs: Integer): TResultatCreationDonnees;
var
   fg : String;
   fgi : integer;
   V: Variant;
   i : Integer;
   sTemp : string;

   function findFG(s : String) : string;
   var
    ifg : Integer;
   begin
     result := '';
     ifg := 0;
     while ifg <= galForms.Count -1 do
     begin
       if pos(galForms[ifg],s) > 0 then
       begin
         // forme galénique trouvée.
         result := galFormsSU[ifg];
         ifg := galForms.Count;
       end;
       inc(ifg);
     end;

   end;
begin
    V := VarArrayCreate([0, ANombreValeurs], varVariant);
    i := 0;
    for I := 0 to ADonnees.Valeurs.Count - 1 do
      if (Trim(ADonnees.Valeurs[I]) = '') or (ADonnees.Valeurs[I] = '""') then
        V[I] := null
      else
        V[I] := ADonnees.Valeurs[I];
    if VarIsNull(v[3]) then
      fg := ''
    else
       fg := V[3];


    if fg = '' then begin
      // rechercher la forme galénique sur base du libellé
      sTemp := findFG(V[2]);
      if sTemp <> '' then
        v[3] := sTemp
      else
        v[3] := null;
    end
    else
    begin
      fgi := StrToIntDef(fg,-1);
      // convertir la forme galénique Pharmony <> SU
      case fgi of
        8 : begin   // Suppo adulte
            V[3] := '8';
        end;
        10 : begin
            V[3] := '10';
        end;
        30 : begin
            V[3] := '16';
        end;
        20 : begin
          V[3] := '4';
        end;
        15 : begin
          v[3] := '22';
        end;
        1 : begin
          v[3] := '1'
        end;
        40 : begin
          V[3] := '25'
        end;
        27 : begin
          V[3] := '11'
        end;
        90 : begin
          V[3] := '14'
        end;
        71 : begin
          V[3] := '2'
        end;
        21 : begin
          V[3] := '5'
        end;
        else begin
           v[3] := null;
        end;
      end;
    end;

    Result := ExecuterPS(AID, APS, V);
end;

procedure TdmPharmonyPHA.DataModuleCreate(Sender: TObject);
begin
 inherited;
 jsonArray := TList<string>.Create;
 jsonArray.AddRange(['schema.csv','schemadetail.csv','Analyses.csv','#preparations.csv']);
 galForms  := TList<string>.create;
 galForms.AddRange(['Gelules omhuld',
                    'Gelules',
                    'Gel',
                    'Zalf',
                    'Oplossing Inwendig',
                    'Crème',
                    'Oplossing Uitwendig',
                    'Suppo volwassenen',
                    'Pasta',
                    'Poeders mengen',
                    'Oogdruppels',
                    'Ovule',
                    'Poeders verdelen',
                    'Suppo kind',
                    'Oogzalf',
                    'Mondspoeling',
                    'Dermatologische gel',
                    'Druppels uitwendig gebruik',
                    'Orale gel',
                    'Orale druppels']);
 galFormsSU  := TList<string>.create;
 galFormsSU.AddRange(['2',
                    '1',
                    '7',
                    '7',
                    '4',
                    '7',
                    '5',
                    '8',
                    '7',
                    '21',
                    '12',
                    '10',
                    '21',
                    '9',
                    '23',
                    '5',
                    '7',
                    '5',
                    '4',
                    '4']);
 dmPharmonyPHA := Self;
end;

function TdmPharmonyPHA.iso8601toDate(s: string): String;
const
  datef = 'YYYY-MM-DD';
var
  Jour,
  Mois,
  Annee : Integer;
  XSDAte : TXSDate;
  aDate : tDateTime;
begin
  try
    xsDate := tXSDate.Create;
    xsDate.XSToNative(s);
    Jour := xsDate.Day;
    Mois := xsDate.Month;
    Annee := XSDAte.Year;
    try
          aDate := EncodeDate(Annee,Mois,Jour)
    except
          aDate := 0;
    end;

    result := formatDatetime(datef,aDate);
  finally
    xsDate.Free;
  end;
end;

end.


