unit Base_DM;

{-------------------------------------------------------------------------------
NOTES.
 1. FireDAC forces the parsing of date types wherea ADO dos NOT!! Make sure that
    you get the correct format of the datetime to pass this value as parameters
    when using dates as parameters in stored procedures.

    Thie following has been implemented.

    a) A type, TDateOrder, has been declared. Three enumerated values are
       currently declared of this type:
       doMDY - Corresponds to mm/dd/yyyy
       doDMY - Corresponds to dd/mm/yyyy
       doYMD - Corresponds to yyyy-mm-dd (Note the dashes)

    b) The method GetDateOrder establishes the shortdate format setting of the
       local machine according to the TDateOrder result (See a) above).

    c) A property - FDateOrder registers the short date format on the local
       machine. This is needed to pass the date correctly to the SOAP server so
       that is can parse this string correctly.

 2. Implement this functionality before executing stored procedures where dates
    are involved.

-------------------------------------------------------------------------------}

interface

uses
  System.SysUtils, System.Classes, Winapi.Windows, Data.DB, Vcl.Dialogs,
  Vcl.Forms, {System.Win.Registry, }Vcl.Controls, DataSnap.DBClient, Vcl.ImgList,
  Data.DBXDataSnap, Data.DBXCommon, IPPeerClient, Data.SqlExpr, System.ImageList,
  System.Threading,

//  VBProxyClass,

  Data.FireDACJSONReflect, DataSnap.DSCommon,

  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.StorageBin,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,

  cxImageList, cxGraphics, cxDBData, cxGridDBBandedTableView,
  FireDAC.Stan.StorageXML, FireDAC.Stan.StorageJSON;

type
  TDateOrder = (doMDY, doDMY, doYMD);

  TDataSetArray = array of TFDMemTable;

  TBaseDM = class(TDataModule)
    sqlConnection: TSQLConnection;
    // Custom methods
    function GetDateOrder(const DateFormat: string): TDateOrder;
    procedure DataModuleCreate(Sender: TObject);
//    function UpdatesPending(DataSetArray: TDataSetArray): Boolean;
    procedure SetConnectionProperties({ServerIndex: Integer; }ReleaseVersion: Boolean);
//    function GetMasterData(DataRequestList, ParameterList: string): TFDJSONDataSets;
//    procedure GetData(ID: Integer; DataSet: TFDMemTable; DataSetName, ParameterList, FileName: string);

    function GetDelta(DataSetArray: TDataSetArray): TFDJSONDeltas;
    procedure ApplyUpdates(DataSetArray: TDataSetArray);
    procedure CancelUpdates(DataSetArray: TDataSetArray);
    function ExecuteSQLCommand(Request: string): string;
  private
    { Private declarations }
  public
    { Public declarations }
//    FClient: TLeaveServerMethodsClient;
//    FTheUpdateAction: Integer;
//    FSuccess: Boolean;
//    FDateFormatSettings: TFormatSettings;
    FDateOrder: TDateOrder;
//    FBeepFreq: Integer;
//    FBeepDuration: Integer;
    FAFormatSettings: TFormatSettings;
    FDateStringFormat: string;
//    FDataSetArray: TDataSetArray;
//    FServerErrorMsg: string;
//    FNavigatorIndex: Integer;
//    FMadeChanges: Boolean;
////
////    property Client: TLeaveServerMethodsClient read FClient write FClient;
////    property TheUpdateAction: Integer read FTheUpdateAction write FTheUpdateAction;
////    property Success: Boolean read FSuccess write FSuccess;
////    property DateFormatSettings: TFormatSettings read FDateFormatSettings write FDateFormatSettings;
//    property DateOrder: TDateOrder read FDateOrder write FDateOrder;
////    property BeepFreq: Integer read FBeepFreq write FBeepFreq;
////    property BeepDuration: Integer read FBeepDuration write FBeepDuration;
//    property AFormatSettings: TFormatSettings read FAFormatSettings write FAFormatSettings;
//    property DateStringFormat: string read FDateStringFormat write FDateStringFormat;
////    property DataSetArray: TDataSetArray read FDataSetArray write FDataSetArray;
////    property ServerErrorMsg: string read FServerErrorMsg write FServerErrorMsg;
////    property MadeChanges: Boolean read FMadeChanges write FMadeChanges;
////    property ToolbarIndex: Integer read FNavigatorIndex write FNavigatorIndex;
  end;

var
  BaseDM: TBaseDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
//  MsgDialog_Frm,
  VBCommonValues,
  RUtils;

{$R *.dfm}

{ TBaseDM }

//function TBaseDM.GetMasterData(DataRequestList, ParameterList: string): TFDJSONDataSets;
//begin
//  inherited;
////  if FClient = nil then
////    FClient := TLeaveServerMethodsClient.Create(BaseDM.sqlConnection.DBXConnection);
////
////  Result := FClient.GetData(DataRequestList, ParameterList);
//end;

//procedure TBaseDM.GetData(ID: Integer; DataSet: TFDMemTable; DataSetName, ParameterList, FileName: string);
////var
////  DataSetList: TFDJSONDataSets;
////  IDList, ParamList: string;
//begin
////  if DataSet.Active then
////    DataSet.EmptyDataSet;
////
////  IDList := 'SQL_STATEMENT_ID=' + ID.ToString;
////
////  if Length(Trim(ParameterList)) = 0 then
////    ParamList := 'PARAMETER_LIST='
////  else
////    ParamList := 'PARAMETER_LIST=' + ParameterList;
////
////  DataSetList := GetMasterData(IDList, ParamList);
////  DataSet.AppendData(TFDJSONDataSetsReader.GetListValueByName(DataSetList, DataSetName));
////  {$IFDEF DEBUG}
////  DataSet.SaveToFile(FileName, sfXML);
////  {$ENDIF}
//////  DataSet.CancelUpdates;
//end;

function TBaseDM.GetDateOrder(const DateFormat: string): TDateOrder;
var
  I: Integer;
begin
  Result := doMDY;
  I := Low(string);
  while I <= High(DateFormat) do
  begin
    case Chr(Ord(DateFormat[I]) and $DF) of
      'E': Result := doYMD;
      'Y': Result := doYMD;
      'M': Result := doMDY;
      'D': Result := doDMY;
    else
      Inc(I);
      Continue;
    end;
    Exit;
  end;
end;

//function TBaseDM.UpdatesPending(DataSetArray: TDataSetArray): Boolean;
////var
////  I: Integer;
//begin
////  Result := False;
////  for I := 0 to Length(DataSetArray) - 1 do
////  begin
////    Result := DataSetArray[I].UpdatesPending;
////    if Result then
////      Break
////  end;
//end;

procedure TBaseDM.DataModuleCreate(Sender: TObject);
begin
//  FBeepFreq := 800;
//  FBeepDuration := 300;
  // GetLocaleFormatSettings deprecated
//  GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, FAFormatSettings);

  FAFormatSettings := TFormatSettings.Create('');
  FDateOrder := GetDateOrder(FAFormatSettings.ShortDateFormat);
  case FDateOrder of
    doDMY: FDateStringFormat := 'dd/mm/yyyy';
    doMDY: FDateStringFormat := 'mm/dd/yyyy';
    doYMD: FDateStringFormat := 'yyyy-mm-dd';
  end;
end;

procedure TBaseDM.SetConnectionProperties({ServerIndex: Integer; }ReleaseVersion: Boolean);
//var
//  RegKey: TRegistry;
begin
//  RegKey := TRegistry.Create(KEY_ALL_ACCESS or KEY_WRITE or KEY_WOW64_64KEY);
//  RegKey.RootKey := HKEY_CURRENT_USER;
//  RegKey.OpenKey(KEY_DATASNAP, True);
//
//  if not RegKey.ValueExists('Host Name') then
//    RegKey.WriteString('Host Name', 'localhost');
//
//  if not RegKey.ValueExists(VB_SHELLX_TCP_KEY_NAME) then
//    RegKey.WriteString(VB_SHELLX_TCP_KEY_NAME, VB_SHELLX_TCP_PORT);
//
//  if not RegKey.ValueExists(VB_SHELLX_HTTP_KEY_NAME) then
//    RegKey.WriteString(VB_SHELLX_HTTP_KEY_NAME, VB_SHELLX_HTTP_PORT);
//
//  sqlConnection.Params.Values['Port'] := RegKey.ReadString(VB_SHELLX_TCP_KEY_NAME);
//
//  sqlConnection.Params.Values['DatasnapContext'] := 'DataSnap/';
//  sqlConnection.Params.Values['CommunicationProtocol'] := 'tcp/ip';
//  sqlConnection.Params.Values['HostName'] := 'localhost';
//
//  if ReleaseVersion then
//    sqlConnection.Params.Values['HostName'] := RegKey.ReadString('Host Name');
//
////  BaseDM.sqlConnection.Params.Values['DriverAssemblyLoader'] := 'Borland.Data.TDBXClientDriverLoader,Borland.Data.DbxClientDriver,Version=24.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b';
////  BaseDM.sqlConnection.Params.Values['Filters'] := '{}';
end;

function TBaseDM.ExecuteSQLCommand(Request: string): string;
begin
//  Result := BaseDM.FClient.ExecuteSQLCommand(Request);
end;

procedure TBaseDM.ApplyUpdates(DataSetArray: TDataSetArray);
//var
//  DeltaList: TFDJSONDeltas;
//  I: Integer;
begin
////  I := fdsPerson.ChangeCount;
////  I := fdsContactDetail.ChangeCount;
////  I := fdsContactType.ChangeCount;
//  DeltaList := GetDelta(DataSetArray);
//  try
//    FServerErrorMsg := BaseDM.FClient.ApplyDataUpdates(DeltaList);
//    for I := 0 to Length(DataSetArray) - 1 do
//      DataSetArray[I].CancelUpdates;
//
////    cdsShutDownPeriod.CancelUpdates;
////    cdsShutDownCalendar.CancelUpdates;
////    cdsEarlyFridayGroup.CancelUpdates;
////    cdsEarlyFridayCalendar.CancelUpdates;
//
////    fdsPerson.UpdatesPending;
////    if fdsPerson.UpdateStatus in [usModified, usInserted, usDeleted] then
////      btnOpenPersonClick(btnOpenPerson);
//////    fdsPerson.ApplyUpdates(-1);
//////    fdsPerson.CommitUpdates;
//////    fdsPerson.Refresh;
//////    if fdsPerson.ChangeCount > 0 then
//////      btnOpenPersonClick(btnOpenPerson);
//////      [rtUnModified, rtModified, rtInserted, rtDeleted, rtHasErrors];
//////    fdsPerson.Refresh;
//////    fdsContactDetail.Refresh;
//////    fdsContactType.Refresh;
//  except
//    on E: TDSServiceException do
////    on E: Exception do
//      raise Exception.Create('Error Applying Updates: ' + E.Message)
//  end;
end;

function TBaseDM.GetDelta(DataSetArray: TDataSetArray): TFDJSONDeltas;
var
  I: Integer;
begin
  // Create a delta list
  Result := TFDJSONDeltas.Create;

  for I := 0 to Length(DataSetArray) - 1 do
  begin
    // Post if edits pending
    if DataSetArray[I].State in dsEditModes then
      DataSetArray[I].Post;

    // Add deltas
    if DataSetArray[I].UpdatesPending then
      TFDJSONDeltasWriter.ListAdd(Result, DataSetArray[I].Name, DataSetArray[I]);
  end;
end;

procedure TBaseDM.CancelUpdates(DataSetArray: TDataSetArray);
//var
//  I: Integer;
begin
//  for I := 0 to Length(DataSetArray) - 1 do
//  begin
//    if DataSetArray[I].UpdatesPending then
//      DataSetArray[I].CancelUpdates;
//  end;
end;

end.

