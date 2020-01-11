unit RUtils;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Winapi.ShlObj, Data.DB, System.Variants, System.AnsiStrings, Winapi.ShellApi,
  System.IOUtils, System.DateUtils, Winapi.TlHelp32, Winapi.WinSock,
  Winapi.Messages, System.ZLib;

const
  CRLF = #13#10;
  TAB = #9;
  DOUBLE_QUOTE = '"';
  COMMA = ',';
  PIPE = '|';
  SEMI_COLON = ';';
  DelimChar = PIPE;
  Days: array[1..7] of string = ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');
  ShortDays: array[1..7] of string = ('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun');
  Months: array[1..12] of string = ('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December');
  ShortMonths: array[1..12] of string = ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');

//   Functionality to detect system idle time   ********************************
type
  PLastInputInfo = ^TLastInputInfo;
(*
  typedef struct tagLASTINPUTINFO {
    UINT  cbSize;
    DWORD dwTime;
  } LASTINPUTINFO, *PLASTINPUTINFO;
*)

{$EXTERNALSYM tagLASTINPUTINFO}

  tagLASTINPUTINFO = record
    cbSize: Integer; // The size of the structure, in bytes. This member must be set to sizeof(LASTINPUTINFO)
    dwTime: Cardinal; // The tick count when the last input event was received.
  end;

  TLastInputInfo = tagLASTINPUTINFO;

{$EXTERNALSYM GetLastInputInfo}

//   End of functionality to detect system idle time   *************************

type
  // Used in AddChar function to add a specified character at the beginning, end,
  // or both ends of a string.
  TReplacePosition = (rpBeginning, rpEnd, rpBoth);
  TReturnBuildData = (rbLongFormat, rbShortFormat, rbBuildNoOnly, rbShortVersion);
  TReturnValueType = (vtNumeric, vtString);
  TDayMonthNameType = (ntDay, ntMonth);
  TDayMonthNameFormat = (nfShort, nfLong);

  TOSInfo = class(TObject)
  public
    class function IsWOW64: Boolean;
  end;

  ByteArray = array of byte;

  TStringArray = array of string;

function AddChar(S: string; aChar: Char; Position: TReplacePosition): string;
function BrowseForFolder(var aFolder: string; Title, InitialFolder: string; AHandle: Cardinal): Boolean;
function BrowseForFolderCallBack(Wnd: HWND; uMsg: UINT; lParam, lpData: lParam): Integer stdcall;

function NullToZero(V: Variant): Integer;
function NullToString(V: Variant): string;
function NullToVariant(V: Variant): Variant;

// Return Count characters from the left side of a string
function LStr(const Source: string; Count: Integer): string;
// Return Count characters from the right side of a string
function RStr(const Source: string; Count: Integer): string;
// Return Count characters from within a string starting at Index
function MStr(const Source: string; Index, Count: Integer): string;
// Left oad Source with a specified Char yielding a string of SLength
function LPad(SourceString: string; aChar: Char; SLength: Integer): string;
// Right pad Source with a specified Char yielding a string of SLength
function RPad(SourceString: string; aChar: Char; SLength: Integer): string;
// Convert string to proper case
function ProperCase(Source: AnsiString): string;
// Get the current version & build info for app.
function GetBuildInfo(const Filename: string; ReturnBuildInfo: TReturnBuildData): string;
procedure AddXMLStandardDef(var SL: TStringList);
function FormatXMLString(S: string): string;
function GetComputer: string;
function GetIPAddress(HostName: string): string;
function FindTheFile(const Filename: string; var Path: string): Boolean;
function ChangeDateFormat(aDate: TDateTime; WantMinutes: Boolean; FromToTime: Integer): string; overload;
function ChangeDateFormat(aDate: TDateTime): string; overload;
function CopyFolder(FromFolder, ToFolder: string): Boolean;
procedure DeleteDirectory(FolderName: string);
function DeleteFolder(FolderName: string): Boolean;
function MoveFolder(FromLocation, ToLocation: string): Boolean;
procedure EmptyDirectory(FolderName, FileMask: string; IncludeSubDirectories: Boolean; AHandle: Cardinal);
//procedure DeleteFolder(FolderName: string);
function GetShellFolderName(ShellFolderID: Integer): string;
function StringOccurs(SearchString, SourceString: string): Integer;
// Check if a file is in use
function IsInUse(Filename: string): Boolean;
function IsProcessRunning(ProcessName: string): Boolean;
procedure KillProcess(hWindowHandle: HWND);
function KillProcessByName(ExeFileName: string): Integer;
// Swap two values
procedure SwapValue(var X, Y: Variant);
// Check to see if a process is running
function ProcessIsRunning(ExeName: string): Boolean;
// Execute a process and wait for it to complete before executing next code.
function ShellExecuteAndWait(Filename, Params: string; ShowState: Integer): Boolean;

function ColourToHex(Colour: TColor): string;
function HexToColour(Colour: string): TColor;
function StringToFloat(S: string): Extended;
function StringToBoolean(S: string): Boolean;
function BooleanToString(B: Boolean): string;
function BooleanToInteger(B: Boolean): Integer;
function IntegerToBoolean(I: Integer): Boolean;
function GetOsVersion: string;
function CountSubstring(const aString, aSubstring: string): Integer;

function IIF(aValue: Variant; ValueType: TReturnValueType): Variant;
function CreateStringList(DelimiterCharacter: WideChar; QuoteCharacter: WideChar = '"'): TStringList;
function GetWindowsSystemDirectory: string;
function GetWinDirectory: string;
function GetCurrentUserName: string;
procedure PressKey(Key: Word; const Shift: TShiftState; SpecialKey: Boolean);
//function GetFileInfo: TFileVersionInfo;
function FormatXMLText(XMLText: string): string;
function RemoveCRLF(S: string): string;
function ExecuteProcess(const Executable: string; const AParams: string = ''; AJob: Boolean = True): THandle;
procedure LogError(Msg, ServerMsg, DebugInfo, Folder: string);
function CompressString(aText: string; aCompressionLevel: TZCompressionLevel): string;
function DecompressString(aText: string): string;

function ByteArrayToStr(bArray: array of byte): string;
function StrToByteArray(Buffer: string): ByteArray;
function ExtractFileNameNoExt(Filename: string): string;
function BinSearch(Strings: TStringArray; SubStr: string): Integer;
// File operations
procedure FileOperation(Source, Dest: string; Operation, OpFlags: Integer);
function SetFormatSettings: TFormatSettings;
function GetMyDocumentsFolder(DefaultPath: string): string;
//   Functionality to detect system idle time   ********************************
function GetLastInputInfo(var ALastInputInfo: TLastInputInfo): Integer; stdcall;
function GetSystemIdleTime(ReturnFormatType: Integer; var StrFormat: string): Cardinal;
//procedure SetRegistryPermission(Sender: TObject);
function EscapeString(InputStr: string; EscapeChar: Char): string;
function MapNetworkDrive(const handle: THandle; const uncPath: string): string;
function ReplaceString(const SourceString, OldPattern, NewPattern: string; Flags: TReplaceFlags): string;
function TrimAll(Value: string): string;
function YearInt(ADate: TDateTime): Integer;
function YearStr(ADate: TDateTime): string;
function MonthInt(ADate: TDateTime): integer;
function MonthStr(Pad: Boolean; PadLength: Integer): string;
function DayInt(ADate: TDateTime): Integer;
function DayStr(Pad: Boolean; PadLength: Integer): string;
function DayMonthName(ADate: TDateTime; NameType: TDayMonthNameType; NameFormat: TDayMonthNameFormat): string;
function CurrentPeriod(ADate: TDateTime): Integer;
function GetMonthEndDate(Period: Integer): TDateTime;

implementation

var
  dwI, dwJ: DWord;
  InitialDir: string;

function GetLastInputInfo; stdcall; external 'user32.dll';

function AddChar(S: string; aChar: Char; Position: TReplacePosition): string;
begin
  Result := S;
  if (Length(S) > 0) then
  begin
    case Position of
      // Add aChar to beginning of string
      rpBeginning:
        begin
          if S[1] <> aChar then
            Result := aChar + S;
        end;

      // Add aChar to end of string
      rpEnd:
        begin
          if S[Length(S)] <> aChar then
            Result := S + aChar;
        end;

      // Add aChar to beginning AND end of string
      rpBoth:
        begin
          if S[1] <> aChar then
            Result := aChar + S;

          if S[Length(S)] <> aChar then
            Result := Result + aChar;
        end;
    end;
  end;
end;

function BrowseForFolderCallBack(Wnd: HWND; uMsg: UINT; lParam, lpData: lParam): Integer stdcall;
begin
  if uMsg = BFFM_INITIALIZED then
    SendMessage(Wnd, BFFM_SETSELECTION, 1, Integer(@InitialDir[1]));
  Result := 0;
end;

function BrowseForFolder(var aFolder: string; Title, InitialFolder: string; AHandle: Cardinal): Boolean;
var
  BrowseInfo: TBrowseInfo;
  ItemIDList: PItemIDList;
  DisplayName: array[0..MAX_PATH] of Char;
begin
  Result := False;
  FillChar(BrowseInfo, SizeOf(BrowseInfo), #0);
  InitialDir := InitialFolder;
  BrowseInfo.hwndOwner := AHandle;
  BrowseInfo.pszDisplayName := @DisplayName[0];
  BrowseInfo.lpszTitle := PChar(Title);
  BrowseInfo.ulFlags := BIF_RETURNONLYFSDIRS;
  // Set initil folder for browsing.
  if InitialFolder <> '' then
    BrowseInfo.lpfn := BrowseForFolderCallBack;
  ItemIDList := SHBrowseForFolder(BrowseInfo);

  if Assigned(ItemIDList) then
    if SHGetPathFromIDList(ItemIDList, DisplayName) then
    begin
      aFolder := DisplayName;
      Result := True;
    end;
end;

function NullToZero(V: Variant): Integer;
begin
  if VarIsNull(V) then
    Result := 0
  else
    Result := V;
end;

function NullToString(V: Variant): string;
begin
  if VarIsNull(V) then
    Result := ''
  else
    Result := V;
end;

function NullToVariant(V: Variant): Variant;
begin
  if VarIsNull(V) then
    Result := 0
  else
    Result := V;
end;

function LStr(const Source: string; Count: Integer): string;
begin
  Result := Copy(Source, 1, Count);
end;

function RStr(const Source: string; Count: Integer): string;
begin
  Result := Copy(Source, Length(Source) - Count + 1, Count);
end;

function MStr(const Source: string; Index, Count: Integer): string;
begin
  Result := Copy(Source, Index, Count);
end;

function LPad(SourceString: string; aChar: Char; SLength: Integer): string;
var
  I: Integer;
begin
  Result := SourceString;
  if Length(Result) >= SLength then
    Exit;

  for I := Length(SourceString) to SLength - 1 do
    Result := aChar + Result;
end;

function RPad(SourceString: string; aChar: Char; SLength: Integer): string;
var
  I: Integer;
begin
  Result := SourceString;
  if Length(Result) >= SLength then
    Exit;

  for I := Length(SourceString) to SLength - 1 do
    Result := Result + aChar;
end;

function ProperCase(Source: AnsiString): string;
var
  Len, Index: Integer;
begin
  Len := Length(Source);
  Source := Uppercase(MidStr(Source, 1, 1)) + Lowercase(MidStr(Source, 2, Len));

  for Index := 0 to Len do
  begin
    if MidStr(Source, Index, 1) = ' ' then
      Source := MidStr(Source, 0, Index) + Uppercase(MidStr(Source, Index + 1, 1)) + Lowercase(MidStr(Source, Index + 2, Len));
  end;
  Result := string(Source);
end;

function GetBuildInfo(const Filename: string; ReturnBuildInfo: TReturnBuildData): string;
// Builds the verson info (if available) of a specified fileName.
// The version info is returned in dotted decimal string format:
// MajorVer.MinorVer.Release.Build

// ReturnBuildInfo:
// rbLongFormat = Return long format of version info: x.x.x Build x
// rbShortFormat = Return short format of version info: x.x.x.x
// rbBuildNoOnly = Only return the build no: x
var
  VerInfo: Pointer;
  VerValue: PVSFixedFileInfo;
begin
  Result := '';
  dwI := GetFileVersionInfoSize(PChar(Filename), dwJ);
  if dwI > 0 then
  begin
    VerInfo := nil;
    try
      GetMem(VerInfo, dwI);
      GetFileVersionInfo(PChar(Filename), 0, dwI, VerInfo);
      VerQueryValue(VerInfo, '\', Pointer(VerValue), dwJ);
      with VerValue^ do
      begin
        case ReturnBuildInfo of
          rbLongFormat, rbShortFormat:
            begin
              Result := IntToStr(dwFileVersionMS shr 16) + '.';
              Result := Result + IntToStr(dwFileVersionMS and $FFFF) + '.';
              Result := Result + IntToStr(dwFileVersionLS shr 16);
              if ReturnBuildInfo = rbLongFormat then
                Result := Result + ' Build ' + IntToStr(dwFileVersionLS and $FFFF)
              else
                Result := Result + '.' + IntToStr(dwFileVersionLS and $FFFF)
            end;
          rbBuildNoOnly: Result := IntToStr(dwFileVersionLS and $FFFF);
          rbShortVersion:
            begin
              Result := IntToStr(dwFileVersionMS shr 16) + '.';
              Result := Result + IntToStr(dwFileVersionMS and $FFFF) + '.';
              Result := Result + IntToStr(dwFileVersionLS shr 16);
            end;
        end;
      end;
    finally
      FreeMem(VerInfo, dwI);
    end;
  end;
end;

// Add XML standards for character formatting for parsing XML strings

procedure AddXMLStandardDef(var SL: TStringList);
begin
  //  SL.Add('<?xml version="1.0" encoding="UTF-8" ?>');

  // Pre-declared entities. Don't need to declare these in the XML standards header
  // & &amp;
  // < &lt;
  // > &gt;
  // " &quot;
  // ' &apos

  SL.Add('<?xml version="1.0"?>');
  SL.Add('<!DOCTYPE names [');
  SL.Add('<!ENTITY excl "&#33;">'); // !
  SL.Add('<!ENTITY sl "&#47;">'); // /
  SL.Add('<!ENTITY bsl "&#92;">'); // \
  SL.Add('<!ENTITY hsh "&#35;">'); // #
  SL.Add('<!ENTITY dollar "&#36;">'); // $
  SL.Add('<!ENTITY per "&#37;">'); // %
  SL.Add('<!ENTITY comma "&#44;">'); // ,
  SL.Add('<!ENTITY equal "&#61;">'); // =
  SL.Add('<!ENTITY quest "&#63;">'); // ?
  SL.Add('<!ENTITY at "&#64;">'); // @
  SL.Add(']>');
end;

// This function returns a string formatted acceptable for XML

function FormatXMLString(S: string): string;
begin
  Result := S;
  // Pre-declared
  // MUST replace the & character first since it used to define placeholders
  // for all other characters
  Result := ReplaceString(Result, '&', '&#38;', [rfReplaceAll, rfIgnoreCase]);
  Result := ReplaceString(Result, '<', '&#60;', [rfReplaceAll, rfIgnoreCase]);
  Result := ReplaceString(Result, '>', '&#62;', [rfReplaceAll, rfIgnoreCase]);
  Result := ReplaceString(Result, '"', '&#34;', [rfReplaceAll, rfIgnoreCase]);
  Result := ReplaceString(Result, '''', '&#39;', [rfReplaceAll, rfIgnoreCase]);

  // Declared in XML standards header
  Result := ReplaceString(Result, '!', '&#33;', [rfReplaceAll, rfIgnoreCase]);
  Result := ReplaceString(Result, '/', '&#47;', [rfReplaceAll, rfIgnoreCase]);
  Result := ReplaceString(Result, '\', '&#92;', [rfReplaceAll, rfIgnoreCase]);
  Result := ReplaceString(Result, '$', '&#36;', [rfReplaceAll, rfIgnoreCase]);
  Result := ReplaceString(Result, '%', '&#37;', [rfReplaceAll, rfIgnoreCase]);
  Result := ReplaceString(Result, ',', '&#44;', [rfReplaceAll, rfIgnoreCase]);
  Result := ReplaceString(Result, '=', '&#61;', [rfReplaceAll, rfIgnoreCase]);
  Result := ReplaceString(Result, '?', '&#63;', [rfReplaceAll, rfIgnoreCase]);
  Result := ReplaceString(Result, '@', '&#64;', [rfReplaceAll, rfIgnoreCase]);
  Result := ReplaceString(Result, '(', '&#40;', [rfReplaceAll, rfIgnoreCase]);
  Result := ReplaceString(Result, ')', '&#41;', [rfReplaceAll, rfIgnoreCase]);

  //  Result := AnsiReplaceText(Result, #13, ' ');
  //  Result := AnsiReplaceText(Result, #10, ' ');

  //  Result := AnsiReplaceText(Result, '&', '&#38;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := AnsiReplaceText(Result, '<', '&#60;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := AnsiReplaceText(Result, '>', '&#62;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := AnsiReplaceText(Result, '"', '&#34;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := AnsiReplaceText(Result, '''', '&#39;', [rfReplaceAll, rfIgnoreCase]);
  //
  //  // Declared in XML standards header
  //  Result := AnsiReplaceText(Result, '!', '&#33;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := AnsiReplaceText(Result, '/', '&#47;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := AnsiReplaceText(Result, '\', '&#92;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := AnsiReplaceText(Result, '#', '&#35;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := AnsiReplaceText(Result, '$', '&#36;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := AnsiReplaceText(Result, '%', '&#37;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := AnsiReplaceText(Result, ',', '&#44;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := AnsiReplaceText(Result, '=', '&#61;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := AnsiReplaceText(Result, '?', '&#63;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := AnsiReplaceText(Result, '@', '&#64;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := AnsiReplaceText(Result, '(', '&#40;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := AnsiReplaceText(Result, ')', '&#41;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := AnsiReplaceText(Result, #13, '', [rfReplaceAll, rfIgnoreCase]);
  //  Result := AnsiReplaceText(Result, #10, ' ', [rfReplaceAll, rfIgnoreCase]);

  //  Result := StringReplace(Result, '&', '&amp;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := StringReplace(Result, '<', '&lt;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := StringReplace(Result, '>', '&gt;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := StringReplace(Result, '"', '&quot;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := StringReplace(Result, '''', '&apos;', [rfReplaceAll, rfIgnoreCase]);
  //
  //  // Declared in XML standards header
  //  Result := StringReplace(Result, '!', '&excl;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := StringReplace(Result, '/', '&sl;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := StringReplace(Result, '\', '&bsl;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := StringReplace(Result, '#', '&hsh;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := StringReplace(Result, '$', '&dollar;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := StringReplace(Result, '%', '&per;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := StringReplace(Result, ',', '&comma;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := StringReplace(Result, '=', '&equal;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := StringReplace(Result, '?', '&quest;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := StringReplace(Result, '@', '&at;', [rfReplaceAll, rfIgnoreCase]);
  //  Result := StringReplace(Result, CRLF, '&32;', [rfReplaceAll, rfIgnoreCase]);
end;

function GetComputer: string;
begin
  dwI := MAX_PATH;
  SetLength(Result, MAX_PATH + 1);
  if GetComputerName(PChar(Result), dwI) then
    SetLength(Result, dwI)
  else
    SetLength(Result, 0);
end;

function GetIPAddress(HostName: string): string;
var
{$IFDEF MSWINDOWS}
  R: Integer;
  WSAData: TWSAData;
{$ENDIF MSWINDOWS}
  HostEnt: PHostEnt;
  Host: AnsiString;
  SockAddr: TSockAddrIn;
begin
  Result := '';
{$IFDEF MSWINDOWS}
  WSAData.wVersion := 0;
  R := WSAStartup(MakeWord(1, 1), WSAData);
  if R = 0 then
    try
{$ENDIF MSWINDOWS}
      Host := AnsiString(HostName);
      if Host = '' then
      begin
        SetLength(Host, MAX_PATH);
        GetHostName(PAnsiChar(Host), MAX_PATH);
      end;
      HostEnt := GetHostByName(PAnsiChar(Host));
      if HostEnt <> nil then
      begin
        SockAddr.Sin_Addr.S_Addr := LongInt(PLongint(HostEnt^.h_addr_list^)^);
// Error on next line for incompatible types WinApi.WinSock.in_addr and OverbyteIcsWinSock.in_addr
        Result := string(AnsiString(inet_ntoa(SockAddr.Sin_Addr)));
      end;
{$IFDEF MSWINDOWS}
    finally
      WSACleanup;
    end;
{$ENDIF MSWINDOWS}
end;

function FindTheFile(const Filename: string; var Path: string): Boolean;
{Recursively search Path and all sub-directories for a user specified file name.}
var
  I, J: Integer;
  SearchRec: TSearchRec;
  NextPath, FilePath, ResultPath: string;
  Flag: Boolean;
begin
  J := 1;
  Result := False;
  Path := Trim(Path);
  repeat
    Flag := False;
    I := Pos(string(Path), ';', J);

    if I = 0 then
      I := Length(Path) + 1;

    NextPath := MStr(string(Path), J, I - J);
    J := I + 1;

    if Length(NextPath) > 0 then
    begin
      if NextPath[Length(NextPath)] = '*' then
      begin
        Flag := True;
        SetLength(NextPath, Length(NextPath) - 1);
      end;
      AddChar(string(NextPath), '\', rpEnd)
    end;

    if FindFirst(NextPath + Filename, faAnyFile, SearchRec) = 0 then
    begin
      ResultPath := NextPath;
      FindClose(SearchRec);
    end;

    if Flag or (Length(ResultPath) = 0) then
    begin
      if FindFirst(string(NextPath) + '*.*', faDirectory, SearchRec) = 0 then
      begin
        repeat
          if (SearchRec.Attr and faDirectory <> 0) and
            (SearchRec.Name[1] <> '.') then
          begin
            FilePath := string(NextPath) + SearchRec.Name + '\';
            if Flag then
              FilePath := FilePath + '*';
            Result := FindTheFile(Filename, FilePath);
            if Result then
            begin
              if Flag then
              begin
                if Length(ResultPath) > 0 then
                  ResultPath := ResultPath + ';';
                ResultPath := ResultPath + FilePath;
                Result := False;
              end
              else
                ResultPath := FilePath;
            end;
          end;
        until Result or (FindNext(SearchRec) <> 0);
        FindClose(SearchRec);
      end;
    end;
  until Result or (J > Length(Path));
  if Length(ResultPath) > 0 then
  begin
    Result := True;
    Path := ResultPath;
  end;
end;

function ChangeDateFormat(aDate: TDateTime): string;
var
  aYear, aMonth, aDay: Word;
begin
  DecodeDate(aDate, aYear, aMonth, aDay);

  Result :=
    IntToStr(aYear) + '-' +
    RUtils.LPad(IntToStr(aMonth), '0', 2) + '-' +
    RUtils.LPad(IntToStr(aDay), '0', 2);
end;

function ChangeDateFormat(aDate: TDateTime; WantMinutes: Boolean; FromToTime: Integer): string; overload;
var
  aYear, aMonth, aDay: Word;
begin
  DecodeDate(aDate, aYear, aMonth, aDay);

  Result :=
    IntToStr(aYear) + '-' +
    RUtils.LPad(IntToStr(aMonth), '0', 2) + '-' +
    RUtils.LPad(IntToStr(aDay), '0', 2);

  if WantMinutes then
  begin
    case FromToTime of
      0: Result := Result + ' 00:00:00'; // Set from time to 1 sec past midnight
      1: Result := Result + ' 23:59:59'; // Set to time to 1 sec before midnight
    end;
  end;
end;

function CopyFolder(FromFolder, ToFolder: string): Boolean;
var
  FOS: TSHFileOpStruct;
begin
  ZeroMemory(@FOS, SizeOf(FOS));
  FOS.wFunc := FO_COPY;
  FOS.fFlags := FOF_FILESONLY or FOF_SILENT or FOF_NOCONFIRMMKDIR or FOF_NOCONFIRMATION;
  FOS.pFrom := PChar(FromFolder + #0);
  FOS.pTo := PChar(ToFolder);
  Result := (0 = ShFileOperation(FOS));
end;

//function DeleteFolder(Folder: string): Boolean;
//var
//  FOS: TSHFileOpStruct;
//begin
//  ZeroMemory(@FOS, SizeOf(FOS));
//  begin
//    FOS.wFunc := FO_DELETE;
//    FOS.fFlags := FOF_SILENT or FOF_NOCONFIRMATION or FOF_NOCONFIRMMKDIR;
////    FOS.fFlags := FOF_SILENT or FOF_NOCONFIRMATION or FOF_NOCONFIRMMKDIR or FOF_NO_UI; // FOF_ALLOWUNDO
////    FOS.fFlags := FOF_SILENT or FOF_NOCONFIRMATION;
//    FOS.pFrom := PChar(Folder + #0);
//  end;
//  Result := (0 = ShFileOperation(FOS));
//end;

function GetShellFolderName(ShellFolderID: Integer): string;
var
  Path: LPWSTR;
begin
  Result := '';
  Path := StrAlloc(MAX_PATH);
  try
    if SHGetSpecialFolderPath(0, Path, ShellFolderID, False) then
      Result := AddChar(Path, '\', rpEnd);
  finally
    StrDispose(Path);
  end;
end;

procedure DeleteDirectory(FolderName: string);
var
  F: TSearchRec;
begin
  if FindFirst(FolderName + '\*', faAnyFile, F) = 0 then
  begin
    try
      repeat
        if (F.Attr and faDirectory <> 0) then
        begin
          if (F.Name <> '.') and (F.Name <> '..') then
          begin
            DeleteDirectory(FolderName + '\' + F.Name);
          end;
        end
        else
        begin
          DeleteFile(FolderName + '\' + F.Name);
        end;
      until FindNext(F) <> 0;
    finally
      FindClose(F);
    end;
    RemoveDir(FolderName);
  end;
end;

function DeleteFolder(FolderName: string): Boolean;
var
  FOS: TSHFileOpStruct;
begin
  ZeroMemory(@FOS, SizeOf(FOS));
  with FOS do
  begin
    wFunc := FO_DELETE;
    fFlags := FOF_SILENT or FOF_NOCONFIRMATION;
    pFrom := PChar(FolderName + #0);
  end;
  Result := (0 = ShFileOperation(FOS));
end;

function MoveFolder(FromLocation, ToLocation: string): Boolean;
var
  FOS: TSHFileOpStruct;
begin
  ZeroMemory(@FOS, SizeOf(FOS));
  with FOS do
  begin
    wFunc := FO_MOVE;
    fFlags := FOF_FILESONLY or FOF_SILENT or FOF_NOCONFIRMATION;
    pFrom := PChar(FromLocation + #0);
    pTo := PChar(ToLocation)
  end;
  Result := (0 = ShFileOperation(FOS));
end;

procedure EmptyDirectory(FolderName, FileMask: string; IncludeSubDirectories: Boolean; AHandle: Cardinal);
var
  SourceLst: string;
  FOS: TSHFileOpStruct;
begin
  FillChar(FOS, SizeOf(FOS), 0);
  FOS.Wnd := AHandle;
  FOS.wFunc := FO_DELETE;
  SourceLst := FolderName + '\' + FileMask + #0;
  FOS.pFrom := PChar(SourceLst);
  if not IncludeSubDirectories then
    FOS.fFlags := FOS.fFlags or FOF_FILESONLY;
  // Remove the next line if you want a confirmation dialog box
  FOS.fFlags := FOS.fFlags or FOF_NOCONFIRMATION;
  // Add the next line for a "silent operation" (no progress box)
  // FOS.fFlags := FOS.fFlags OR FOF_SILENT;
  ShFileOperation(FOS);
end;

function StringOccurs(SearchString, SourceString: string): Integer;
var
  Offset: Integer;
begin
  Result := 0;
  Offset := Pos(SearchString, SourceString, 1);
  while Offset <> 0 do
  begin
    Inc(Result);
    Offset := Pos(SearchString, SourceString, Offset + Length(SearchString));
  end;
end;

function IsInUse(Filename: string): Boolean;
var
  HFileRes: HFILE;
begin
  Result := False;

  if not TFile.Exists(Filename) then
    Exit;

  HFileRes := CreateFile(PChar(Filename),
    GENERIC_READ or GENERIC_WRITE,
    0,
    nil,
    OPEN_EXISTING,
    FILE_ATTRIBUTE_NORMAL,
    0);
  Result := (HFileRes = INVALID_HANDLE_VALUE);
//    if not Result then
  CloseHandle(HFileRes);
end;

function IsProcessRunning(ProcessName: string): Boolean;
var
  ContinueSearch: Boolean;
  handle: THandle;
  Process: TProcessEntry32;
begin
{
  The TProcessEntry32 record structure looks like this:

  tagPROCESSENTRY32 = packed record
    dwSize: DWORD;
    cntUsage: DWORD;
    th32ProcessID: DWORD;       // this process
    th32DefaultHeapID: DWORD;
    th32ModuleID: DWORD;        // associated exe
    cntThreads: DWORD;
    th32ParentProcessID: DWORD; // this process's parent process
    pcPriClassBase: Longint;    // Base priority of process's threads
    dwFlags: DWORD;
    szExeFile: array[0..MAX_PATH - 1] of Char;// Path
  end;
}

  handle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  Process.dwSize := SizeOf(Process);
  // Start iterating through all running processes.
  ContinueSearch := Process32First(handle, Process);
  Result := False;
  while ContinueSearch do
  begin
    // Compare ProcessName parameter to next item in list.
    if ((Uppercase(ExtractFileName(Process.szExeFile)) =
      Uppercase(ProcessName)) or (Uppercase(Process.szExeFile) =
      Uppercase(ProcessName))) then
    begin
      Result := True; // Found process.
    end;
    // Process the next item in the list.
    ContinueSearch := Process32Next(handle, Process);
  end;
  // Close the handle.
  // This MUST happen!!
  CloseHandle(handle);
end;

procedure KillProcess(hWindowHandle: HWND);
var
  hprocessID: Integer;
  processHandle: THandle;
  DWResult: DWord;
begin
// Look at possibly using this alternative. Need to do some R&D.
// SendNotifyMessage

//  SendMessageTimeout(hWindowHandle, WM_CLOSE, 0, 0,
//    SMTO_ABORTIFHUNG or SMTO_NORMAL, 5000, DWResult);
  SendMessageTimeout(hWindowHandle, WM_CLOSE, 0, 0,
    SMTO_ABORTIFHUNG or SMTO_NORMAL, 5000, @DWResult);

  if isWindow(hWindowHandle) then
  begin
    // PostMessage(hWindowHandle, WM_QUIT, 0, 0);
    // Get the process identifier for the window
    GetWindowThreadProcessID(hWindowHandle, @hprocessID);
    if hprocessID <> 0 then
    begin
      // Get the process handle
      processHandle := OpenProcess(PROCESS_TERMINATE or PROCESS_QUERY_INFORMATION,
        False, hprocessID);
      if processHandle <> 0 then
      begin
        // Terminate the process
        TerminateProcess(processHandle, 0);
        CloseHandle(processHandle);
      end;
    end;
  end;
end;

function KillProcessByName(ExeFileName: string): Integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  while Integer(ContinueLoop) <> 0 do
  begin
    if ((Uppercase(ExtractFileName(FProcessEntry32.szExeFile)) =
      Uppercase(ExeFileName)) or (Uppercase(FProcessEntry32.szExeFile) =
      Uppercase(ExeFileName))) then
      Result := Integer(TerminateProcess(
        OpenProcess(PROCESS_TERMINATE,
        BOOL(0),
        FProcessEntry32.th32ProcessID),
        0));
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

procedure SwapValue(var X, Y: Variant);
begin
  X := X + Y;
  Y := X - Y;
  X := X - Y;

  // This also works
//  X := X * Y;
//  Y := X / Y;
//  X := X / Y;
end;

function ProcessIsRunning(ExeName: string): Boolean;
var
  ContinueLoop: BOOL;
  SnapshotHandle: THandle;
  ProcessEntry32: TProcessEntry32;
begin
  SnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  ProcessEntry32.dwSize := SizeOf(ProcessEntry32);
  ContinueLoop := Process32First(SnapshotHandle, ProcessEntry32);
  Result := False;
  while Integer(ContinueLoop) <> 0 do
  begin
    if ((Uppercase(ExtractFileName(ProcessEntry32.szExeFile)) =
      Uppercase(ExeName))
      or (Uppercase(ProcessEntry32.szExeFile) = Uppercase(ExeName))) then
      Result := True;
    ContinueLoop := Process32Next(SnapshotHandle, ProcessEntry32);
  end;
  CloseHandle(SnapshotHandle);
end;

function ShellExecuteAndWait(Filename, Params: string; ShowState: Integer): Boolean;
var
  ExecutableInfo: TShellExecuteInfo;
  processHandle: DWord;
begin
  FillChar(ExecutableInfo, SizeOf(ExecutableInfo), 0);
  ExecutableInfo.cbSize := SizeOf(ExecutableInfo);
  ExecutableInfo.fMask := SEE_MASK_NOCLOSEPROCESS or SEE_MASK_FLAG_DDEWAIT;
  ExecutableInfo.Wnd := GetActiveWindow();
  ExecutableInfo.lpVerb := 'open';
  ExecutableInfo.lpParameters := PChar(Params);
  ExecutableInfo.lpFile := PChar(Filename);
  ExecutableInfo.nShow := ShowState;

  if ShellExecuteEx(@ExecutableInfo) then
    processHandle := ExecutableInfo.hProcess
  else
  begin
    Result := True;
    Exit;
  end;

//  while WaitForSingleObject(ExecutableInfo.hProcess, 50) <> WAIT_OBJECT_0 do
//    Application.ProcessMessages;

  WaitForSingleObject(ExecutableInfo.hProcess, INFINITE);
  CloseHandle(processHandle);

  Result := True;
end;

function ColourToHex(Colour: TColor): string;
begin
  Result :=
    IntToHex(GetRValue(Colour), 2) +
    IntToHex(GetGValue(Colour), 2) +
    IntToHex(GetBValue(Colour), 2);
end;

function HexToColour(Colour: string): TColor;
begin
  Result :=
    RGB(
    StrToInt('$' + Copy(Colour, 1, 2)),
    StrToInt('$' + Copy(Colour, 3, 2)),
    StrToInt('$' + Copy(Colour, 5, 2)));
end;

function StringToFloat(S: string): Extended;
var
  TempS: string;
begin
  TempS := S;
  TempS := Trim(S);
  if Length(TempS) > 0 then
  begin
    TempS := ReplaceString(TempS, ',', '', [rfReplaceAll, rfIgnoreCase]);
    TempS := ReplaceString(TempS, ' ', '', [rfReplaceAll, rfIgnoreCase]);
    try
      Result := StrToFloat(TempS);
    except
      Result := 0;
    end;
  end
  else
    Result := 0;
end;

function StringToBoolean(S: string): Boolean;
var
  TempS: string;
begin
  Result := False;
  TempS := Trim(S);
  if (Length(TempS) = 0) or (Length(TempS) > 1) then
    Exit;
  Result := TempS = '1';
end;

function BooleanToString(B: Boolean): string;
const
  BooleanStrings: array[Boolean] of string = ('0', '1');
begin
  Result := BooleanStrings[B];
end;

function BooleanToInteger(B: Boolean): Integer;
begin
  if B then
    Result := 1
  else
    Result := 0;
end;

function IntegerToBoolean(I: Integer): Boolean;
begin
  Result := True;
  if I = 0 then
    Result := False
end;

function GetOsVersion: string;
var
  OSVerInfo: TOsVersionInfo;
  dw: DWord;
begin
  Result := '';
  OSVerInfo.dwOSVersionInfoSize := SizeOf(OSVerInfo);
  if GetVersionEx(OSVerInfo) then
  begin
    Result := IntToStr(OSVerInfo.dwMajorVersion) + '.' + IntToStr(OSVerInfo.dwMinorVersion);
    dw := OSVerInfo.dwBuildNumber and $FFFF;
    if dw <> 0 then
      Result := Result + ' (' + IntToStr(dw) + ')';
  end;
//  Result := Result + ' Platform: ' + JclSysInfo.GetWindowsVersionString;
//  Result := Result + ' Platform: ' + OSVerInfo.dwPlatformId.ToString;
end;

class function TOSInfo.IsWOW64: Boolean;
type
  TIsWow64Process = function(
    handle: THandle;
    var Res: BOOL
    ): BOOL; stdcall;
var
  IsWow64Result: BOOL;
  IsWow64Process: TIsWow64Process;
begin
  IsWow64Process := GetProcAddress(
    GetModuleHandle('kernel32'), 'IsWow64Process'
    );
  if Assigned(IsWow64Process) then
  begin
    if not IsWow64Process(GetCurrentProcess, IsWow64Result) then
      raise Exception.Create('Bad process handle');
    Result := IsWow64Result;
  end
  else
    Result := False;
end;

function CountSubstring(const aString, aSubstring: string): Integer;
var
  Posn: Integer;
begin
  Result := 0;
  Posn := Pos(aSubstring, aString);
  while Posn <> 0 do
  begin
    Inc(Result);
    Posn := Pos(aSubstring, aString, Posn + Length(aSubstring));
  end;
end;

function IIF(aValue: Variant; ValueType: TReturnValueType): Variant;
begin
  if VarIsNull(aValue) then
    case ValueType of
      vtNumeric: Result := 0;
      vtString: Result := '';
    end
  else
    Result := aValue;
end;

//function CreateStringList(DelimiterCharacter: WideChar): TStringList;

function CreateStringList(DelimiterCharacter: WideChar; QuoteCharacter: WideChar = '"'): TStringList;
begin
  Result := TStringList.Create;
  Result.Delimiter := DelimiterCharacter;
  Result.QuoteChar := QuoteCharacter;
  Result.StrictDelimiter := True;
end;

function GetWindowsSystemDirectory: string;
begin
  // This seems to be recursive!! Check it out.
//  Result := GetWindowsSystemDirectory;

//  GetSystemDirectory(Dir, MAX_PATH);
//  Result := StrPas(Dir);
end;

function GetWinDirectory: string;
var
  WinDir: PChar;
begin
  WinDir := StrAlloc(MAX_PATH);

  GetWindowsDirectory(WinDir, MAX_PATH);
  Result := string(WinDir);
  if Result[Length(Result)] <> '\' then
    Result := Result + '\';
  StrDispose(WinDir);
end;

procedure PressKey(Key: Word; const Shift: TShiftState; SpecialKey: Boolean);
//Parameters:
// key:
// virtual keycode of the key to send. For printable keys this is simply
// the ANSI code (Ord(character)).

// shift:
// state of the modifier keys. This is a set, so you can set several of these keys
// (shift, control, alt, mouse buttons) in tandem. The TShiftState type is
// declared in the Classes Unit.

// SpecialKey:
// normally this should be False. Set it to True to specify a key on the numeric
// keypad, for example.

// Description:
// Uses keybd_Event declared in Windows.pas to manufacture a series of key events
// matching the passed parameters. The events go to the control with focus.
// Note that for characters key is always the upper-case version of the character.
// Sending without any modifier keys will result in a lower-case character,
// sending it with [ ssShift ] will result in an upper-case character!

type
  TShiftKeyInfo = record
    Shift: byte;
    vkey: byte;
  end;

  ByteSet = set of 0..7;

const
  ShiftKeys: array[1..3] of TShiftKeyInfo =
    ((Shift: Ord(ssCtrl); vkey: VK_CONTROL),
    (Shift: Ord(ssShift); vkey: VK_SHIFT),
    (Shift: Ord(ssAlt); vkey: VK_MENU));
var
  Flag: DWord;
  bShift: ByteSet absolute Shift;
  I: Integer;
begin
  for I := 1 to 3 do
  begin
    if ShiftKeys[I].Shift in bShift then
      Keybd_Event(ShiftKeys[I].vkey, MapVirtualKey(ShiftKeys[I].vkey, 0), 0, 0);
  end;

  if SpecialKey then
    Flag := KEYEVENTF_EXTENDEDKEY
  else
    Flag := 0;

  Keybd_Event(Key, MapVirtualKey(Key, 0), Flag, 0);
  Flag := Flag or KEYEVENTF_KEYUP;
  Keybd_Event(Key, MapVirtualKey(Key, 0), Flag, 0);

  for I := 3 downto 1 do
  begin
    if ShiftKeys[I].Shift in bShift then
      Keybd_Event(ShiftKeys[I].vkey, MapVirtualKey(ShiftKeys[I].vkey, 0), KEYEVENTF_KEYUP, 0);
  end;
end;

function FormatXMLText(XMLText: string): string;
var
  S: string;
  I: Integer;
begin
  // *********  WARNING!  *********  WARNING!  *********  WARNING!  ************
  // Replacing the & MUST BE DONE FIRST!!!
  S := XMLText;
  Result := '';

  for I := 1 to Length(S) do
    case S[I] of
//      '&': Result := Result + '&#38;';
      '&': Result := Result + '&amp;';
      '!': Result := Result + '&#33;';
      '"': Result := Result + '&#34;';
      '#': Result := Result + '&#35;';
      '$': Result := Result + '&#36;';
      '%': Result := Result + '&#37;';
      '''': Result := Result + '&#39;';
      ',': Result := Result + '&#44;';
      '/': Result := Result + '&#47;';
      ';': Result := Result + '&#59;';
      '<': Result := Result + '&lt;';
      '>': Result := Result + '&gt;';
//      '<': Result := Result + '&#60;';
//      '>': Result := Result + '&#62;';
      '?': Result := Result + '&#63;';
      '@': Result := Result + '&#64;';
    else
      Result := Result + S[I];
    end;
end;

function RemoveCRLF(S: string): string;
begin
  // Remove trailing CR/LF
  Result := S;
  while (Length(Result) > 0)
    and ((Result[Length(Result)] = #13)
    or (Result[Length(Result)] = #10)) do
    Result := Copy(Result, 1, Length(Result) - 1);
end;

function ExecuteProcess(const Executable: string; const AParams: string = ''; AJob: Boolean = True): THandle;
var
  SI: TStartupInfo;
  PI: TProcessInformation;
  AFlag: Cardinal;
begin
  Result := INVALID_HANDLE_VALUE;
  FillChar(SI, SizeOf(SI), 0);
  SI.cb := SizeOf(SI);

  if AJob then
    AFlag := CREATE_NEW_PROCESS_GROUP + NORMAL_PRIORITY_CLASS {+ CREATE_BREAKAWAY_FROM_JOB}
  else
    AFlag := 0;

//  if CreateProcess(
//    PChar(Executable), //nil,
//    PChar(Executable + ' ' + AParams),
//    nil,
//    nil,
//    False,
//    AFlag,
//    nil,
//    nil,
//    SI,
//    PI
//    ) then

  if CreateProcess(
    nil,
    PChar(Executable + ' '),
//    PChar(Executable + ' ' + AParams),
    nil,
    nil,
    False,
    AFlag,
    nil,
    nil,
    SI,
    PI
    ) then
  begin
   { close thread handle }
    CloseHandle(PI.hThread);
    Result := PI.hProcess;
  end;
end;

procedure LogError(Msg, ServerMsg, DebugInfo, Folder: string);
var
  AppName, LogFileName: string;
  SL, SLDebug: TStringList;
begin
  SL := CreateStringList(PIPE);
  SLDebug := CreateStringList(PIPE);
  try
    TDirectory.CreateDirectory(Folder);
{$IFDEF DLL}
    AppName := ChangeFileExt(ExtractFileName(GetModuleName(HInstance)), '');
{$ELSE}
    AppName := ChangeFileExt(ExtractFileName(AppName), '');
{$ENDIF}
    LogFileName := AddChar(Folder, '\', rpEnd) + AppName + '.csv';

    if TFile.Exists(LogFileName) then
    begin
      SL.LoadFromFile(LogFileName);
      // Only retain the most recent 500 lines.
      if SL.Count > 501 then
        repeat
          SL.Delete(SL.Count - 1);
        until
          SL.Count < 501;
    end

    else
    begin
      SL.Clear;
      SL.Insert(0,
        'Event Date' + DelimChar +
        'Error' + DelimChar +
        'Server Msg' + DelimChar +
        'Applicaiton' + DelimChar +
        'Debug Info Unit' + DelimChar +
        'Debug Info Method' + DelimChar +
        'Debug Info Line No');
    end;
    SLDebug.DelimitedText := DebugInfo;
    SL.Insert(1,
      FormatDateTime('yyyy-mm-dd hh:mm:ss', Now) + DelimChar +
      Msg + DelimChar +
      ServerMsg + DelimChar +
      SLDebug.Values['APPLICATION'] + DelimChar +
      SLDebug.Values['UNIT'] + DelimChar +
      SLDebug.Values['METHOD'] + DelimChar +
      SLDebug.Values['LINE_NO'] + DelimChar);
    SL.SaveToFile(LogFileName);
  finally
    SL.Free;
    SLDebug.Free;
  end;
end;

function GetCurrentUserName: string;
var
  UserName: string;
  NameLength: DWord;
begin
  NameLength := 255;
  SetLength(UserName, NameLength);
  if GetUserName(PChar(UserName), NameLength) then
    Result := Copy(UserName, 1, NameLength - 1)
  else
    Result := 'Unknown';
end;

function ExtractFileNameNoExt(Filename: string): string;
begin
  Result := '';
  if Length(Trim(Filename)) = 0 then
    Exit;
  Result := ChangeFileExt(ExtractFileName(Filename), '');
end;

function BinSearch(Strings: TStringArray; SubStr: string): Integer;
var
  FirstItem, LastItem, CurrentItem: Integer;
  Found: Boolean;
begin
  FirstItem := low(Strings); //Sets the First item in the range
  LastItem := high(Strings); //Sets the Last item in the range
  Found := False; //Initializes the Found flag - Assume not yet found
  Result := -1; //Initializes the Result - Assume item searched for not found.

  //If FirstItem > LastItem then the searched item doesn't exist
  //If the item is found the loop will stop
  while (FirstItem <= LastItem) and (not Found) do
  begin
    //Gets the middle of the selected range
    CurrentItem := (FirstItem + LastItem) div 2;
    //Compares the String in the middle with the searched one
    if Strings[CurrentItem] = SubStr then
    begin
      Found := True;
      Result := CurrentItem;
    end
    //If the Item in the middle has a bigger value than
    //the searched item, then select the FirstItem half
    else if Strings[CurrentItem] > SubStr then
      LastItem := CurrentItem - 1
        //else select the second half
    else
      FirstItem := CurrentItem + 1;
  end;
end;

//----------------------   String compression   --------------------------------

function CompressString(aText: string; aCompressionLevel: TZCompressionLevel): string;
var
  InputStr, OutputStr: TStringStream;
  Compressor: TZCompressionStream;
begin
  Result := '';
  InputStr := TStringStream.Create(aText);
  OutputStr := TStringStream.Create;
  InputStr.Position := 0;
  OutputStr.Position := 0;
  try
    Compressor := TZCompressionStream.Create(OutputStr {, aCompressionLevel});
    try
      Compressor.CopyFrom(InputStr, InputStr.Size);
    finally
      Compressor.Free;
    end;
    Result := OutputStr.DataString;
  finally
    InputStr.Free;
    OutputStr.Free;
  end;
end;

function DecompressString(aText: string): string;
var
  InputStr, OutputStr: TStringStream;
  Decompressor: TZDecompressionStream;
begin
  Result := '';
  InputStr := TStringStream.Create(aText);
  OutputStr := TStringStream.Create;
  InputStr.Position := 0;
  OutputStr.Position := 0;
  try
    Decompressor := TZDecompressionStream.Create(InputStr);
    try
      OutputStr.CopyFrom(Decompressor, Decompressor.Size);
    finally
      Decompressor.Free;
    end;
    Result := OutputStr.DataString;
  finally
    InputStr.Free;
    OutputStr.Free;
  end;
end;

function ByteArrayToStr(bArray: array of byte): string;
begin
  SetLength(Result, SizeOf(bArray));
  CopyMemory(@Result[1], @bArray[0], SizeOf(bArray));
end;

function StrToByteArray(Buffer: string): ByteArray;
begin
  SetLength(Result, lstrlen(PChar(Buffer)));
  CopyMemory(@Result[0], @Buffer[1], Length(Buffer));
end;

function SetFormatSettings: TFormatSettings;
var
  FS: TFormatSettings;
begin
  FS := TFormatSettings.Create;
  FS.ThousandSeparator := ',';
  FS.DecimalSeparator := '.';
  FS.DateSeparator := '-';
  FS.TimeSeparator := ':';
  FS.ListSeparator := ',';
  FS.ShortDateFormat := 'yyyy-MM-dd';
  FS.ShortTimeFormat := 'HH:mm';
  FS.LongTimeFormat := 'HH:mm:ss';
  Result := FS;
end;

{
Notes to developer:

Extract from Delphi help file on using the SHFileOperation Function

--------------------------------------------------------------------------------

Copies, moves, renames, or deletes a file system object.

Syntax

int SHFileOperation(LPSHFILEOPSTRUCT lpFileOp);
Parameters

lpFileOp
[in] Pointer to an SHFILEOPSTRUCT structure that contains information this
function needs to carry out the specified operation. This parameter must contain
a valid value that is not NULL. You are responsibile for validating the value.
If you do not validate it, you will experience unexpected results.

Return Value: Returns zero if successful, or nonzero otherwise.

Remarks

1. - You should use fully-qualified path names with this function. Using it with
relative path names is not thread safe.

2. - With two exceptions, you cannot use SHFileOperation to move special folders from
a local drive to a remote computer by specifying a network path. The exceptions
are the My Documents and My Pictures folders (CSIDL_PERSONAL and CSIDL_MYPICTURES,
respectively).

3. - When used to delete a file, SHFileOperation permanently deletes the file unless
you set the FOF_ALLOWUNDO flag in the fFlags member of the SHFILEOPSTRUCT structure
pointed to by lpFileOp. Setting that flag sends the file to the Recycle Bin. If
you want to delete a file and guarantee that it is not placed in the Recycle Bin,
use DeleteFile.

4. - If a copy callback handler is exposed and registered, SHFileOperation calls it
unless you set a flag such as FOF_NOCONFIRMATION in the fFlags member of the
structure pointed to by lpFileOp. See ICopyHook::CopyCallback for details on
implementing copy callback handlers.

5. - File deletion is recursive unless you set the FOF_NORECURSION flag in lpFileOp.

Connecting Files

With Microsoft Windows 2000 or later, it is possible to connect an HTML file with
a folder that contains related files such as Graphics Interchange Format (GIF)
images or style sheets. If file connection is enabled, when you move or copy the
HTML file, the folder and all of its files are moved or copied as well. Conversely,
if you move the folder with the related files, the HTML file is also moved.

The HTML file must have a .htm or .html extension. You create the connection to
the related files by placing the folder that contains them into the same folder
as the HTML file. The name of the folder that contains the connected files must
be the same as the name of the HTML file followed by "_files" or ".files" (this
is case sensitive; for example, ".Files" does not work). An example is given here.

Create a file named Test.htm in the C:\Files directory (C:\Files\Test.htm).
Create a new folder named Test.files in the C:\Files directory (C:\Files\Text.files).
Populate the folder with a few files. Any file placed in this folder is connected
to Test.htm.
Move or copy the Test.htm file to the C:\Files2 directory.
Note that the Test.files directory is now found in the C:\Files2 directory as well.

File connection is enabled by default. It can be disabled by adding a REG_DWORD
value, NoFileFolderConnection, to this registry key.

HKEY_CURRENT_USER
Software
Microsoft
Windows
CurrentVersion
Explorer
NoFileFolderConnection

Setting NoFileFolderConnection to 1 disables file connection. If the value is set
to zero or is missing, file connection is enabled.

To move only specified files from a group of connected files, set the
FOF_NO_CONNECTED_ELEMENTS flag in the fFlags member of the structure pointed to
by lpFileOp.

Note that the use of a folder with a name like "MyFile_files" to define a
connection may not be valid for localized versions of Microsoft Windows NT. The
term "files" may need to be replaced by the equivalent word in the local language.

Windows 95/98/Me: SHFileOperation is supported by the Microsoft Layer for Unicode
(MSLU). To use this, you must add certain files to your application, as outlined
in Microsoft Layer for Unicode on Windows Me/98/95 Systems.

Function Information
}

procedure FileOperation(Source, Dest: string; Operation, OpFlags: Integer);
var
  OpStruct: TSHFileOpStruct;
  SourceStr, DestStr: string;
begin
  FillChar(OpStruct, SizeOf(OpStruct), #0);
  SourceStr := Source + #0#0;
  DestStr := Dest + #0#0;
  OpStruct.Wnd := 0;
  OpStruct.wFunc := Operation;
  OpStruct.pFrom := PChar(SourceStr);
  OpStruct.pTo := PChar(DestStr);
  OpStruct.fFlags := OpFlags;
  ShFileOperation(OpStruct);
end;

function GetSystemIdleTime(ReturnFormatType: Integer; var StrFormat: string): Cardinal;
var
  LastInput: TLastInputInfo;
  IdleTime, Hours, Minutes, Seconds: Cardinal;
begin
  LastInput.cbSize := SizeOf(TLastInputInfo);
  LastInput.dwTime := 0;
  Result := 0;

  if GetLastInputInfo(LastInput) <> 0 then
    IdleTime := GetTickCount - LastInput.dwTime
  else
    IdleTime := 0;

  Hours := IdleTime div (60 * 60 * 1000);
  if Hours > 0 then
    IdleTime := IdleTime - (Hours * 60 * 60 * 1000);

  Minutes := IdleTime div (60 * 1000);
  if Minutes > 0 then
    IdleTime := IdleTime - (Minutes * 60 * 1000);

  Seconds := IdleTime div 1000;
//  StrFormat := Format('%.2d:%.2d:%.2d', [Hours, Minutes, Seconds]);
  StrFormat := Format('%.2d:%.2d', [Minutes, Seconds]);
  case ReturnFormatType of
    0: Result := Seconds;
    1: Result := Minutes;
    2: Result := Hours;
  end;
end;

function GetMyDocumentsFolder(DefaultPath: string): string;
var
  FoundFolder: BOOL;
  FolderPath: array[0..MAX_PATH] of Char;
begin
  Result := DefaultPath;
  FoundFolder := SHGetSpecialFolderPath(0, FolderPath, CSIDL_Personal, False);
  if FoundFolder then
    Result := AddChar(FolderPath, '\', rpEnd);
end;

function EscapeString(InputStr: string; EscapeChar: Char): string;
var
  S: string;
  I: Integer;
begin
  S := InputStr;
  Result := '';

  for I := 1 to Length(S) do
  begin
//    if S[I] in ['[', ']', '/', '\', '*' {, '_'}] then
    if CharInSet(S[I], ['[', ']', '/', '\', '*' {, '_'}]) then
      Result := Result + '\' + S[I]
    else
      Result := Result + S[I];
  end;
end;

function MapNetworkDrive(const handle: THandle; const uncPath: string): string;
//returns mapped drive ("z:") on success
//or uncPath on failure / cancel
var
  cds: TConnectDlgStruct;
  netResource: TNetResource;
begin
  Result := uncPath;

  ZeroMemory(@netResource, SizeOf(TNetResource));
  netResource.dwType := RESOURCETYPE_DISK;
  netResource.lpRemoteName := PChar(uncPath);

  cds.cbStructure := SizeOf(TConnectDlgStruct);
  cds.hwndOwner := handle;
  cds.lpConnRes := @netResource;
  cds.dwFlags := CONNDLG_PERSIST;

  if WNetConnectionDialog1(cds) = NO_ERROR then
  begin
    Result := Chr(-1 + Ord('A') + cds.dwDevNum) + DriveDelim;
  end;
end;

function ShellOpenFile(WindowHandle: HWND; AFileName, AParams, ADefaultDir: string): Integer;
begin
  Result := Winapi.ShellApi.ShellExecute(WindowHandle,
    'open',
    PChar(AFileName),
    PChar(AParams),
    PChar(ADefaultDir),
    SW_SHOWDEFAULT);
    {x.lpFile := PChar(AFileName);
    x.nShow := SW_SHOWDEFAULT;
    x.Wnd := WindowHandle;
    x.lpVerb := 'open';
    ShellExecuteEx(@x);
    Result := GetLastError;}
//  finally
  case Result of
    0:
      raise Exception.Create('The operating system is out of memory or resources.');
    ERROR_FILE_NOT_FOUND:
      raise Exception.Create('The specified file was not found.');
    ERROR_PATH_NOT_FOUND:
      raise Exception.Create('The specified path was not found.');
    ERROR_BAD_FORMAT:
      raise Exception.Create('The .EXE file is invalid (non-Win32 .EXE or error ' +
        'in .EXE image).');
    SE_ERR_ACCESSDENIED:
      raise Exception.Create('The operating system denied access to the specified file.');
    SE_ERR_ASSOCINCOMPLETE:
      raise Exception.Create('The filename association is incomplete or invalid.');
    SE_ERR_DDEBUSY:
      raise Exception.Create('The DDE transaction could not be completed because ' +
        'other DDE transactions were being processed.');
    SE_ERR_DDEFAIL:
      raise Exception.Create('The DDE transaction failed.');
    SE_ERR_DDETIMEOUT:
      raise Exception.Create('The DDE transaction could not be completed because the ' +
        'request timed out.');
    SE_ERR_DLLNOTFOUND:
      raise Exception.Create('The specified dynamic-link library was not found.');
    SE_ERR_NOASSOC:
      raise Exception.Create('There is no application associated with the given ' +
        'filename extension.');
    SE_ERR_OOM:
      raise Exception.Create('There was not enough memory to complete the operation.');
    SE_ERR_SHARE:
      raise Exception.Create('A sharing violation occurred.');
  end;
end;

procedure OpenExplorer(Foldername: string);
begin
  ShellExecute(Application.Handle,
    PChar('explore'),
    PChar(FolderName),
    nil,
    nil,
    SW_SHOWNORMAL);
end;

//function GetApplicationHandle: THandle;
//begin
////{$IFNDEF no_gui}
////  Result := Application.Handle;
////{$ELSE}
////  Result := 0;
////{$ENDIF}
//end;

procedure ExploreFolder(AFolderName: string);
begin
//  ShellOpenFile(GetApplicationHandle, AFolderName, '', AFolderName);
  ShellOpenFile(Application.handle, AFolderName, '', AFolderName);
end;

function ReplaceString(const SourceString, OldPattern, NewPattern: string; Flags: TReplaceFlags): string;
var
  SearchStr, Patt, NewStr: string;
  Offset: Integer;
begin
  if rfIgnoreCase in Flags then
  begin
    SearchStr := Uppercase(SourceString);
    Patt := Uppercase(OldPattern);
  end
  else
  begin
    SearchStr := SourceString;
    Patt := OldPattern;
  end;
  NewStr := SourceString;
  Result := '';
  while SearchStr <> '' do
  begin
    Offset := Pos(Patt, SearchStr);
    if Offset = 0 then
    begin
      Result := Result + NewStr;
      Break;
    end;
    Result := Result + Copy(NewStr, 1, Offset - 1) + NewPattern;
    NewStr := Copy(NewStr, Offset + Length(OldPattern), MaxInt);
    if not (rfReplaceAll in Flags) then
    begin
      Result := Result + NewStr;
      Break;
    end;
    SearchStr := Copy(SearchStr, Offset + Length(Patt), MaxInt);
  end;
end;

function TrimAll(Value: string): string;
begin
  Result := Trim(Value);
end;

function CurrentPeriod(ADate: TDateTime): Integer;
var
  Day, Month, Year: Word;
begin
  DecodeDate(ADate, Year, Month, Day);
  Result := Year * 100 + Month;
end;

function YearInt(ADate: TDateTime): Integer;
var
  aYear, aMonth, aDay: Word;
begin
  DecodeDate(ADate, aYear, aMonth, aDay);
  Result := aYear;
end;

function YearStr(ADate: TDateTime): string;
var
  aYear, aMonth, aDay: Word;
begin
  DecodeDate(ADate, aYear, aMonth, aDay);
  Result := aYear.ToString;
end;

function MonthInt(ADate: TDateTime): Integer;
var
  aYear, aMonth, aDay: Word;
begin
  DecodeDate(ADate, aYear, aMonth, aDay);
  Result := aMonth;
end;

function MonthStr(Pad: Boolean; PadLength: Integer): string;
var
  aYear, aMonth, aDay: Word;
begin
  DecodeDate(Date, aYear, aMonth, aDay);
  Result := aMonth.ToString;

  if Pad then
    Result := LPad(Result, '0', PadLength);
end;

function DayInt(ADate: TDateTime): Integer;
var
  aYear, aMonth, aDay: Word;
begin
  DecodeDate(ADate, aYear, aMonth, aDay);
  Result := aDay;
end;

function DayStr(Pad: Boolean; PadLength: Integer): string;
var
  aYear, aMonth, aDay: Word;
begin
  DecodeDate(Date, aYear, aMonth, aDay);
  Result := aDay.ToString;

  if Pad then
    Result := LPad(Result, '0', PadLength);
end;

function DayMonthName(ADate: TDateTime; NameType: TDayMonthNameType; NameFormat: TDayMonthNameFormat): string;
var
  aYear, aMonth, aDay, WeekDay: Word;
begin
  DecodeDate(ADate, aYear, aMonth, aDay);
  case NameType of
    ntDay:
      begin
        WeekDay := DayOfTheWeek(ADate);
        case NameFormat of
          nfShort: Result := ShortDays[WeekDay];
          nfLong: Result := Days[WeekDay];
        end;
      end;

    ntMonth:
      begin
        case NameFormat of
          nfShort: Result := ShortMonths[aMonth];
          nfLong: Result := Months[aMonth];
        end;
      end;
  end;
end;

function GetMonthEndDate(Period: Integer): TDateTime;
var
  AYear, AMonth, Aday: Word;
begin
  Ayear := Period div 100;
  AMonth := Period mod 100;
  ADay := DaysInAMonth(AYear, AMonth);
  Result := EncodeDate(Ayear, Amonth, Aday);
end;

end.

