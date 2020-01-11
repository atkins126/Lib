unit DBController;

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

  TDBController = class
  private
    FDataSnapKeyname: string;
    FSQLConnection: TSQLConnection;
    function GetMasterData(DataRequestList, ParameterList, Generatorname, Tablename, DataSetName: string; var Response: string): TFDJSONDataSets;
    function GetDateOrder(const DateFormat: string): TDateOrder;
  public
{$IFDEF VB}
    FClient: TVBServerMethodsClient;
{$ENDIF}
    constructor Create(Drivername, DatasnapContext, CommunicationProtocol, HostName, TCPPort, HTTPPort: string);
    destructor Destroy; override;
    procedure GetData(ID: Integer; DataSet: TFDMemTable; DataSetName,
      ParameterList, FileName, Generatorname, Tablename: string);

    property DataSnapKeyname: string read FDataSnapKeyname write FDataSnapKeyname;
    property SQLConnection: TSQLConnection read FSQLConnection write FSQLConnection;
  end;

implementation

{ TDBController }

constructor TDBController.Create(Drivername, DatasnapContext, CommunicationProtocol, HostName, TCPPort, HTTPPort: string);
begin
  FSQLConnection := TSQLConnection.Create(nil);

//  FSQLConnection.Params.Values['Driver'] := Drivername;
  FSQLConnection.DriverName := Drivername;
  FSQLConnection.Params.Values['DatasnapContext'] := DatasnapContext;
  FSQLConnection.Params.Values['CommunicationProtocol'] := CommunicationProtocol;
  FSQLConnection.Params.Values['HostName'] := HostName;
  FSQLConnection.Params.Values['Port'] := TCPPort;
  FSQLConnection.KeepConnection := True;
  FSQLConnection.LoginPrompt := False;

//  FSQLConnection.Open;
//  FClient := TVBServerMethodsClient.Create(FSQLConnection.DBXConnection);
end;

destructor TDBController.Destroy;
begin
  FreeAndNil(FSQLConnection);
end;

procedure TDBController.GetData(ID: Integer; DataSet: TFDMemTable; DataSetName,
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

function TDBController.GetDateOrder(const DateFormat: string): TDateOrder;
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

function TDBController.GetMasterData(DataRequestList, ParameterList, Generatorname,
  Tablename, DataSetName: string; var Response: string): TFDJSONDataSets;
begin
  {F}Response := '';
  Result := FClient.GetData(DataRequestList, ParameterList, Generatorname, Tablename, DataSetName, {F}Response);
end;

end.

