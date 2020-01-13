unit MyClasses;

interface

uses
  Winapi.Messages, System.Classes, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

const
  // Used to draw border of highlighted cell in DX grid & tree components.
  CM_DRAWBORDER = WM_APP + 300;
  CRLF = #13#10;
  // Pattern used for PW encryption.
//  PATN = 'rcaPPLICAITONSsHELL'; // Deliberately used this case format.

type
//  TcxDateEditAccess = class(TcxDateEdit);

  // Control user rights.
  // Note: A set cannot have more than 256 characters!~
  TUserRights = 1..255;
  TUserRightSet = set of TUserRights;
  TActionArray = array of Boolean;

  TShellResource = record
    ShellResourceFileFolder: string;
    RootFolder: string;
    SkinName: string;
    RemoteServerName: string;
    ConnectionDefinitionFileLocation: string;
    ConnectionDefinitionFileName: string;
    ApplicationFolder: string;
    ExcelFolder: String;
    PDFFolder: String;
//    ApplicationRootFolder: string;
//    DataRootFolder: string;
//    SkinName: string;
//    ConnectionDefinitionFileLocation: string;
//    ConnectionDefinitionFileName: string;
  end;

//  TShellResource = record
//    ShellResourceFileFolder: string;
//    RootFolder: string;
//    SkinName: string;
//    SOAPServerName: string;
//    ConnectionDefinitionFileLocation: string;
//    ConnectionDefinitionFileName: string;
//    ApplicationFolder: string;
//  end;
//

  TUserData = record
    UserName: string; // Login name
    EmployeeName: string; // Official employee name
    EmployeeID: Integer; // Internal DB record ID
    JTEmployeeID: Integer;
    EmployeeNo: string; // Employee No
    Department: string; // Department
    CoEmailAddress: string; // Company email address
    EmailAddress: string; // Personal email address
    IDNO: string; // ID/Passport number
    ComputerName: string;
    IPAddress: string;
    EmployeeStatus: string;
    SiteID: Integer;
  end;

  TData = class
  private
//    function GetFishPicture: TBitmap;
  public
    constructor Create;
    destructor Destroy; override;
//    property FishPicture: TBitmap read GetFishPicture;
  end;

function ComponentToString(Component: TComponent): string;
function StringToComponent(Value: string): TComponent;

// Used to generate an array of constants for use in the Format function. In
// particular, this method is used when passing parameters to SQL commands.
type
  TVarRecordArray = array of TVarRec;

function BuildFormatArray(ArrayLength: Integer; ParameterList: TStringList): TVarRecordArray;

implementation

{ TData }

constructor TData.Create;
begin
  inherited
    Create;
end;

destructor TData.Destroy;
begin
//
  inherited;
end;

{ Common classes }

function ComponentToString(Component: TComponent): string;
var
  BinStream: TMemoryStream;
  StrStream: TStringStream;
  s: string;
begin
  BinStream := TMemoryStream.Create;
  try
    StrStream := TStringStream.Create(s);
    try
      BinStream.WriteComponent(Component);
      BinStream.Seek(0, soFromBeginning);
      ObjectBinaryToText(BinStream, StrStream);
      StrStream.Seek(0, soFromBeginning);
      Result := StrStream.DataString;
    finally
      StrStream.Free;
    end;
  finally
    BinStream.Free
  end;
end;

function StringToComponent(Value: string): TComponent;
var
  StrStream: TStringStream;
  BinStream: TMemoryStream;
begin
  StrStream := TStringStream.Create(Value);
  try
    BinStream := TMemoryStream.Create;
    try
      ObjectTextToBinary(StrStream, BinStream);
      BinStream.Seek(0, soFromBeginning);
      Result := BinStream.ReadComponent(nil);
    finally
      BinStream.Free;
    end;
  finally
    StrStream.Free;
  end;
end;

function BuildFormatArray(ArrayLength: Integer; ParameterList: TStringList): TVarRecordArray;
var
  I: Integer;
  S: String;
begin
  SetLength(Result, ArrayLength);
  for I := 0 to ParameterList.Count - 1 do
  begin
      Result[I].VType := vtUnicodeString;
      S :=  ParameterList[I];
      Result[I].VUnicodeString := Pointer(S);
    // This code also works but is not necessary when using UniCode Strings.
//      string(Result[I].VUnicodeString) := string(Pointer(S));
  end;
end;

end.

