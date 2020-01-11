unit DBControllerDataSnap;

interface

uses
  System.SysUtils, System.Win.Registry, WinApi.Windows,
{$IFDEF VB}
  VBProxyClass,
{$ENDIF}
  FireDAC.Comp.Client, Data.FireDACJSONReflect, FireDAC.Stan.StorageXML,
  FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageBin, FireDAC.Stan.Intf,
  Data.SqlExpr, Data.DBXCommon;

const
  ONE_SPACE = ' ';

type
  TDateOrder = (doMDY, doDMY, doYMD);

//  TDataSetArray = array of TFDMemTable;

  TDBControllerDataSnap = class
  private
    FDataSnapKeyname: string;
    function GetMasterData(DataRequestList, ParameterList, Generatorname, Tablename, DataSetName: string; var Response: string): TFDJSONDataSets;
    procedure SetConnectionProperties(DataSnapKeyname, Hostname, TCPKeyName, TCPPort, HTTPKeyName, HTTPPort: string); overload;
    function GetDateOrder(const DateFormat: string): TDateOrder;
    function GetTCPKeyName: string;
    procedure SetTCPKeyName(const Value: string);
    function GetHostName: String;
    procedure SetHostName(const Value: String);
    function GetTCPPort: String;
    procedure SetTCPPort(const Value: String);
    function GetHTTPKeyame: String;
    procedure SetHTTPKeyame(const Value: String);
    function GetHTTPPort: String;
    procedure SetHTTPPort(const Value: String);
  public
{$IFDEF VB}
    FClient: TVBServerMethodsClient;
{$ENDIF}
    FSQLConnection: TSQLConnection;

    procedure Create(DataSnapKeyname, HostName, TCPKeyName, TCPPort, HTTPKeyName, HTTPPort: string);
    destructor Destroy; override;
    procedure GetData(ID: Integer; DataSet: TFDMemTable; DataSetName,
      ParameterList, FileName, Generatorname, Tablename: string);
    procedure SetConnectionProperties; overload;
    property DataSnapKeyname: string read FDataSnapKeyname write FDataSnapKeyname;
    property HostName: String read GetHostName write SetHostName;
    property TCPKeyName: string read GetTCPKeyName write SetTCPKeyName;
    property TCPPort: String read GetTCPPort write SetTCPPort;
    property HTTPKeyame: String read GetHTTPKeyame write SetHTTPKeyame;
    property HTTPPort: String read GetHTTPPort write SetHTTPPort;
  end;

implementation

{ TDBControllerDataSnap }

procedure TDBControllerDataSnap.Create(DataSnapKeyname, HostName, TCPKeyName, TCPPort,
  HTTPKeyName, HTTPPort: string);
begin
  FSQLConnection := TSQLConnection.Create(nil);
  FSQLConnection.Name := 'sqlConnection';
  FSQLConnection.KeepConnection := True;
  FSQLConnection.LoginPrompt := False;
  SetConnectionProperties(DataSnapKeyname, TCPKeyName, TCPPort, HTTPKeyName, HTTPPort);
end;

destructor TDBControllerDataSnap.Destroy;
begin
  if FSQLConnection <> nil then
    FreeAndNil(FSQLConnection);
end;

procedure TDBControllerDataSnap.GetData(ID: Integer; DataSet: TFDMemTable; DataSetName,
  ParameterList, FileName, Generatorname, Tablename: string);
var
  DataSetList: TFDJSONDataSets;
  IDList, ParamList, Response: string;
begin
  if DataSet.Active then
  begin
    DataSet.Close;
//    DataSet.EmptyDataSet;
  end;

  IDList := 'SQL_STATEMENT_ID=' + ID.ToString;

  if Length(Trim(ParameterList)) = 0 then
    ParamList := 'PARAMETER_LIST=' + ONE_SPACE
  else
    ParamList := 'PARAMETER_LIST=' + ParameterList;

  DataSetList := GetMasterData(IDList, ParamList, Generatorname, Tablename, DataSetName, Response);
  if {F}Response = 'NO_DATA' then
    Exit;

  DataSet.AppendData(TFDJSONDataSetsReader.GetListValueByName(DataSetList, DataSetName));
{$IFDEF DEBUG}
  DataSet.SaveToFile(FileName, sfXML);
{$ENDIF}
end;

function TDBControllerDataSnap.GetDateOrder(const DateFormat: string): TDateOrder;
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

function TDBControllerDataSnap.GetMasterData(DataRequestList, ParameterList, Generatorname,
  Tablename, DataSetName: string; var Response: string): TFDJSONDataSets;
begin
  {F}Response := '';
  Result := FClient.GetData(DataRequestList, ParameterList, Generatorname, Tablename, DataSetName, {F}Response);
end;

procedure TDBControllerDataSnap.SetConnectionProperties(DataSnapKeyname, HostName, TCPKeyName, TCPPort, HTTPKeyName, HTTPPort: string);
var
  RegKey: TRegistry;
begin
  RegKey := TRegistry.Create(KEY_ALL_ACCESS or KEY_WRITE or KEY_WOW64_64KEY);
  RegKey.RootKey := HKEY_CURRENT_USER;
  RegKey.OpenKey(DataSnapKeyname, True);

  try
    if not RegKey.ValueExists('Host Name') then
      RegKey.WriteString('Host Name', 'localhost');

    if not RegKey.ValueExists(HostName) then
      RegKey.WriteString(HostName, HostName);

//    if not RegKey.ValueExists(VB_SHELLX_HTTP_KEY_NAME) then
//      RegKey.WriteString(VB_SHELLX_HTTP_KEY_NAME, VB_SHELLX_HTTP_PORT);

//    FSQLConnection.Params.Values['Port'] := FTCPKeyName;

//    FSQLConnection.Params.Values['DatasnapContext'] := 'DataSnap/';
//    FSQLConnection.Params.Values['CommunicationProtocol'] := 'tcp/ip';
//    FSQLConnection.Params.Values['HostName'] := RegKey.ReadString('Host Name');
    RegKey.CloseKey;
  finally
    RegKey.Free;
  end;
end;

procedure TDBControllerDataSnap.SetConnectionProperties;
begin
//
end;

function TDBControllerDataSnap.GetHostName: String;
begin
//
end;

procedure TDBControllerDataSnap.SetHostName(const Value: String);
begin
//
end;

function TDBControllerDataSnap.GetTCPKeyName: string;
var
  RegKey: TRegistry;
begin
  RegKey := TRegistry.Create(KEY_ALL_ACCESS or KEY_WRITE or KEY_WOW64_64KEY);
  RegKey.RootKey := HKEY_CURRENT_USER;
  RegKey.OpenKey(FDataSnapKeyname, True);

  try
    if not RegKey.ValueExists('Host Name') then
      RegKey.WriteString('Host Name', 'localhost');

    if not RegKey.ValueExists(TCPKeyName) then
      RegKey.WriteString(TCPKeyName, '');

    Result := RegKey.ReadString(TCPKeyName);
//    FSQLConnection.Params.Values['Port'] := RegKey.ReadString(TCPKeyName);
    RegKey.CloseKey;
  finally
    RegKey.Free;
  end;
end;

procedure TDBControllerDataSnap.SetTCPKeyName(const Value: string);
begin
  FSQLConnection.Params.Values['Port'] := Value;
end;

function TDBControllerDataSnap.GetTCPPort: String;
begin
//
end;

procedure TDBControllerDataSnap.SetTCPPort(const Value: String);
begin
//
end;

procedure TDBControllerDataSnap.SetHTTPKeyame(const Value: String);
begin
//
end;

function TDBControllerDataSnap.GetHTTPKeyame: String;
begin
//
end;

function TDBControllerDataSnap.GetHTTPPort: String;
begin
//
end;

procedure TDBControllerDataSnap.SetHTTPPort(const Value: String);
begin
//
end;

end.

