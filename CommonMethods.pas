unit CommonMethods;

interface

uses
  Vcl.Forms, System.SysUtils, System.Classes, System.IOUtils, System.UITypes,
  System.Win.Registry, Winapi.Windows,

  VBCommonValues, RUtils;
//  , MsgDialog_Frm;
//  About_Frm, JclSysInfo;

//type
//  TAboutInfo = class
//  public
//    constructor Create;
//    destructor Destroy; override;
//  end;

function SoapRequestHeader(ApplicationTitle, ConnectionName, UserName, ComputerName, IPAddress: string;
  RequireDelimChar: Boolean): string;

//procedure WriteToRecoveryFile(SL: TStringList);

//function DisplayMsg(FormCaption, MainCaption, {SubCaption,}Msg: string;
//  DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; ShowDetailedMessage: Boolean): Integer;

//procedure ProcessRegistry;
procedure InitialiseUserRights;
function LocalDSServerIsRunning(ServerName: String; var ErrorMsg: string): Boolean;

function ComponentToString(Component: TComponent): string;
function StringToComponent(Value: string): TComponent;

//var
//  ShellResource: TShellResource;

implementation

//constructor TAboutInfo.Create;
//begin
//  if AboutFrm = nil then
//    AboutFrm := TAboutFrm.Create(nil);
//  AboutFrm.ShowModal;
//end;
//
//destructor TAboutInfo.Destroy;
//begin
//  FreeAndNil(AboutFrm);
//end;

function SoapRequestHeader(ApplicationTitle, ConnectionName, UserName, ComputerName, IPAddress: string;
  RequireDelimChar: Boolean): string;
begin
  Result := 'APP_TITLE=' + ApplicationTitle + PIPE;
  // Connect to the relevant DB.
  Result := Result + 'CONNECTION_DEF_NAME=' + ConnectionName + PIPE;
  // Get local user info.
  Result := Result + Format(LOCAL_USER_INFO,
    [UserName,
    ComputerName,
      IPAddress
      ]);

  if RequireDelimChar then
    Result := Result + PIPE;
end;

//procedure WriteToRecoveryFile(SL: TStringList);
//var
//  I, J, FileHandle, StringLength: Integer;
//  Buffer: PAnsiChar;
//  S: AnsiString;
//begin
//  if TFile.Exists(RECOVERY_FILE_NAME) then
//    FileHandle := FileOpen(RECOVERY_FILE_NAME, fmOpenWrite or fmShareDenyNone)
//  else
//    FileHandle := FileCreate(RECOVERY_FILE_NAME);
//
//  // Move pointer to EOF.
//  FileSeek(FileHandle, 0, 2);
//  try
//    for J := 0 to SL.Count - 1 do
//    begin
//      S := SL[J];
//      // Get length of input string.
//      StringLength := Length(S);
//      // Allocate the buffer.
//      GetMem(Buffer, StringLength);
//      // Fill buffer with string.
//      for I := 1 to StringLength do
//        Buffer[I - 1] := S[I];
//
//      // Write the string to file.
//      FileWrite(FileHandle, Buffer^, StringLength);
//      // Add a new line to EOF.
//      FileWrite(FileHandle, sLineBreak, Length(sLineBreak));
//      // Free the buffer for the next line.
//      FreeMem(Buffer, StringLength);
//    end;
//  finally
//    FileClose(FileHandle);
//  end;
//end;

//function DisplayMsg(FormCaption, MainCaption, Msg: string;
//  DlgType: TMsgDlgType; Buttons: TMsgDlgButtons;
//  ShowDetailedMessage: Boolean): Integer;
//var
//  OSVersion: string;
//begin
//  try
//    Screen.Cursor := crHourGlass;
//
//    if MsgDialogFrm = nil then
//      MsgDialogFrm := TMsgDialogFrm.Create(nil);
//
//    MsgDialogFrm.FormCaption := FormCaption;
//    MsgDialogFrm.FMainCaption := MainCaption;
////    MsgDialogFrm.FSubCaption := SubCaption;
//
//    MsgDialogFrm.FShowDetailedMessage := True; //:= ShowDetailedMessage;
//
////    if ShowDetailedMessage then
////    begin
////      case GetWindowsVersion of
////        wvWinXP:
////          OSVersion := 'Windows XP ' + GetOsVersion;
////        wvWin7:
////          begin
////            if IsWindows64 then
////              OSVersion := 'Windows 7 (64 bit) ' + GetOsVersion
////            else
////              OSVersion := 'Windows 7 (32 bit) ' + GetOsVersion
////          end;
////        wvWin8, wvWin81:
////          begin
////            if IsWindows64 then
////              OSVersion := 'Windows 8/8.1 (64 bit) ' + GetOsVersion
////            else
////              OSVersion := 'Windows 8/8.1 (32 bit) ' + GetOsVersion
////          end;
////        wvWin10:
////          OSVersion := 'Windows 10 ' + GetOsVersion
////      end;
////
////      Msg := Msg + CRLF + CRLF +
////        'Date: ' + FormatDateTime('dd/mm/yyyy hh:mm', Now) + CRLF +
////        'Computer: ' + GetComputer + ' (IP =  ' + GetIPAddress(GetComputer) +
////        ')' + CRLF + 'OS Version: ' + OSVersion + CRLF + 'User Name: ' +
////        GetCurrentUserName;
////    end;
//
//    MsgDialogFrm.FMsg := Msg;
//    MsgDialogFrm.FButtons := Buttons;
//    MsgDialogFrm.FMsgType := DlgType;
//    Result := MsgDialogFrm.ShowModal;
//  finally
////    FreeAndNil(MsgDialogFrm);
//  end;
//end;

procedure ProcessRegistry;
var
  RegKey: TRegistry;
begin
  RegKey := TRegistry.Create(KEY_ALL_ACCESS or KEY_WRITE or KEY_WOW64_64KEY);
  try
    RegKey.RootKey := HKEY_CURRENT_USER;
    RegKey.OpenKey(KEY_USER_PREFERENCES, True);

    if not RegKey.ValueExists('Skin Name') then
      RegKey.WriteString('Skin Name', DEFAULT_SKIN_NAME);

    RegKey.CloseKey;
  finally
    RegKey.Free;
  end;
end;

procedure InitialiseUserRights;
//var
//  SL: TStringList;
//  I: Integer;
begin
//  // Assume this user is a picker only.
//  SL := RUtils.CreateStringList(PIPE);
//  try
//    if TFile.Exists(ShellResource.RootFolder + COMMON_FOLDER + 'CurrenUserRight.txt') then
//      SL.LoadFromFile(ShellResource.RootFolder + COMMON_FOLDER + 'CurrenUserRight.txt')
//    else
//      SL.Sorted := True;
//    FUserRight := [];
//
//    for I := 0 to SL.Count - 1 do
//      FUserRight := FUserRight + [StrToInt(SL[I])];
//
//    FLeaveAdministrator := False;
//    FSuperAdmin := (1 in FUserRight);
//
//    if not FSuperAdmin then
//      FLeaveAdministrator := (7 in FUserRight);
//  finally
//    SL.Free;
//  end;
end;

function LocalDSServerIsRunning(ServerName: String; var ErrorMsg: string): Boolean;
var
  SL: TStringList;
  Success: Boolean;
  StartInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
begin
  SL := RUtils.CreateStringList(PIPE);
  try
    Result := True;
    try
      if not RUtils.IsInUse(ServerName) then
        if not TFile.Exists(ServerName) then
        begin
          Result := False;
          ErrorMsg := Application.Title + ' - Datasnap Server Error' + CRLF +
            'The local Datasnap server ' + ServerName + CRLF +
            'could not be found in the expected location.' + CRLF + CRLF +
            'Please ensure that it is located in the correct folder.';
          Exit;
        end
        else
        begin
          FillChar(StartInfo, SizeOf(TStartupInfo), #0);
          FillChar(ProcInfo, SizeOf(TProcessInformation), #0);
          StartInfo.cb := SizeOf(TStartupInfo);
          StartInfo.dwFlags := STARTF_USESHOWWINDOW;
          StartInfo.wShowWindow := SW_SHOW;
          GetStartupInfo(StartInfo);
//          Success := False;
          repeat
            Success := CreateProcess(
              PWideChar(ServerName),
              PWideChar(ServerName { + Args}),
              nil,
              nil,
              False,
              CREATE_NEW_PROCESS_GROUP + NORMAL_PRIORITY_CLASS + {CREATE_BREAKAWAY_FROM_JOB +}STARTF_FORCEONFEEDBACK,
              nil,
              nil,
              StartInfo,
              ProcInfo);
          until
            Success = True;
        end;
    except
      on E: Exception do
      begin
        Result := False;
        ErrorMsg := Application.Title + ' - Datsnap Connection Error' + CRLF +
          'A connection to the Datasnap server could not be established.' + CRLF + CRLF +
          E.Message
          + CRLF + CRLF + 'Please ensure that the local ' + Application.Title + ' Datasnap '
          + CRLF + 'server is running and try again.';
      end;
    end;
  finally
    SL.Free;
  end;
end;

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

{
 Server connections. See CommonValues.pas unit for list of port settings for the
 various Datasnap servers.
 1 = RC Shell
 2 = Leave
 3 = Fourth Shift
 4 = Timesheet
}

end.

