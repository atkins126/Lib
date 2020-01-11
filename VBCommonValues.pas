unit VBCommonValues;

interface

uses
  Winapi.Windows, Winapi.Messages;

//  WinApi.Windows, WinApi.Messages;

type
  // Record to store user data
  TUserData = record
    UserName: string; // Login name
    EmployeeName: string; // Official employee name
    EmployeeID: Integer; // Internal DB record ID
    JTEmployeeID: Integer;
    EmployeeNo: string; // Employee No
    Department: string; // Department
//    BadgeNo: Int64; // Company badge number
    CoEmailAddress: string; // Company email address
    EmailAddress: string; // Personal email address
    IDNO: string; // ID/Passport number
    ComputerName: string;
    IPAddress: string;
    EmployeeStatus: string;
    SiteID: Integer;
  end;

  TShellResource = record
    ShellResourceFileFolder: string;
    RootFolder: string;
    SkinName: string;
    SOAPServerName: string;
    ConnectionDefinitionFileLocation: string;
    ConnectionDefinitionFileName: string;
    ApplicationFolder: string;
  end;

  TActionArray = array of Boolean;
  TUserRights = 1..255;
  TUserRightSet = set of TUserRights;
  TZCompressionLevel = (zcNone, zcFastest, zcDefault, zcMax);
  TDBActions = (acInsert, acModify, acDelete);
  TKitStoreTransactionTypes = (ttReceiving, ttIssuing, ttReturn, ttCancel, ttBinTransfer);
  TFileExtensions = (xls, xlsx, doc, docx, mdb, accdb, pdf, jpg, png, bitmap, bmp);

var
  DBAction: TDBActions;
  FileExtension: TFileExtensions;

{
  $0080BFFF - Orange
  $00FFB3B3 - Light Mauve
  $009D9DFF - Light Pink
  $80       - Maroon
  $C6       - Red/Maroon
  $C6FFC6 - Light Green
  $B6EDFA - Light Yellow
}
const
  Days: array[1..7] of string = ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');
  LongMonths: array[1..12] of string = ('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December');
  ShortMonths: array[1..12] of string = ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');

  // XML Formatt specifiers
  EMPTY_STRING = '';
  ONE_SPACE = ' ';
  TWO_SPACE = '  ';
  FOUR_SPACE = '    ';
  SIX_SPACE = '      ';
  // Carriage return/Line feed character.
  CRLF = #13#10;
  COMMA = ',';
  SEMI_COLON = ';';
  PIPE = '|';
  DOUBLE_QUOTE = '"';
  SINGLE_QUOTE = '''';
  TELNET_PORT = 'telnet'; // Default telnet port standard = 23
  ESCAPE_CHAR = '\';
  DOUBLE_ESCAPE_CHAR = '\\';
  ALL_FILES_MASK = '*.*';
  // Drawing borders around grid cell.
  CM_DRAWBORDER = WM_APP + 300;

// Genrate case insensitive queries in SQL Server.
  SQL_COLLATE = ' COLLATE SQL_Latin1_General_CP1_CI_AS ';

  // Default skin name
  DEFAULT_SKIN_NAME = 'MoneyTwins';
  SKIN_RESOURCE_FILE = 'AllSkins.skinres';

  // Default registry constants
  // Common keys
  KEY_COMMON_ROOT = '\Software\van Brakel';
  KEY_COMMON = KEY_COMMON_ROOT + '\Common';
  KEY_COMMON_RESOURCE = KEY_COMMON_ROOT + '\Common Resource';
  KEY_COMMON_DATABASE = KEY_COMMON_RESOURCE + '\Database';
  KEY_COMMON_RESOURCE_FILES = KEY_COMMON_RESOURCE + '\Resource Files';
  KEY_COMMON_RESOURCE_USER_DATA = KEY_COMMON_RESOURCE + '\User Data';
  KEY_COMMON_RESOURCE_USER_PREFERENCES = KEY_COMMON_RESOURCE + '\User Preferences';
  KEY_COMMON_TCP = KEY_COMMON_RESOURCE + '\TCP';
  KEY_EXTERNAL_FILE_ACCESS = KEY_COMMON_ROOT + '\External File Access';
  // DataSnap constants
  KEY_DATASNAP = KEY_COMMON + '\DataSnap';

  ROOT_FOLDER = 'C:\Data\VB\';
//  ROOT_DATA_FOLDER = 'Reutech Communications\';
  // Modified by CVG on 04/08/2017
  ROOT_DATA_FOLDER = ROOT_FOLDER;
  COMMON_FOLDER = 'Common\';
  RESOURCE_FOLDER = 'Resource\';
  VB_SHELL_FOLDER = 'VB Shell\';
  EXCEL_DOCS = 'Excel\';
  PDF_DOCS = 'PDF\';
  DATA_FILES = 'Cache Data\';
  ATTACHMENT_ROOT_FOLDER = 'Attachment\';

  // FireDAC conection definition file.
  CONNECTION_DEFINITION_FILE = ROOT_DATA_FOLDER + COMMON_FOLDER + 'ConnectionDefinitions.ini';

  FILE_TYPE_APPLICATION = 1;
  FILE_TYPE_INSTALLER = 2;
  FILE_TYPE_RESOURCE = 3;
  FILE_TYPE_DOCUMENT = 4;

  // Constants to identify the client application.
  APP_VB_SHELL = 'VB Shell';
  APP_TIMESHEET_MANAGER = 'Timesheet Manager';
  LOCAL_USER_INFO =
    'LOGON_NAME=%s' + PIPE +
    'COMPUTER_NAME=%s' + PIPE +
    'IP_ADDRESS=%s';

  LOCAL_EXECUTABLE_ROOT_FOLDER = 'C:\Data\Delphi\Bin\';
  LOCAL_VB_SHELL_DS_SERVER = LOCAL_EXECUTABLE_ROOT_FOLDER + 'Servers\VBDSServerDebug.exe';

  // Default localhost port no's for connecting debug SOAP server to local machine.
  VB_SHELL_TCP_PORT = '2010';
  VB_SHELL_HTTP_PORT = '6010';

  VB_SHELLX_TCP_PORT = '3010';
  VB_SHELLX_HTTP_PORT = '7010';

  VB_SHELL_TCP_KEY_NAME = 'VB Shell TCP Port';
  VB_SHELL_HTTP_KEY_NAME = 'VB Shell HTTP Port';

  VB_SHELLX_TCP_KEY_NAME = 'VB ShellX TCP Port';
  VB_SHELLX_HTTP_KEY_NAME = 'VB ShellX HTTP Port';

//-------------------    SQL Server Errror Messages     ------------------------
{ Error No  Severity Message
  2601      16       Cannot insert duplicate key row in object '%.*ls' with unique index '%.*ls'.
  208       16       Invalid object name '%.*ls'.
  515       16       Cannot insert the value NULL into column '%.*ls', table '%.*ls'; column does not allow nulls. %ls fails.
}
  SQL_ERROR_2601 = 'Duplicate %s: %s not allowed. Transaction was rolled back';
  SQL_ERROR_208 = 'SQL server object name: %s does not exist.';
  SQL_ERROR_515 = 'Server error: %s';

  //----------------------------------------------------------------------------

  // Connection information stored in connection ini file (See above).
  COMMON_DATA_CONNECTION_INFO =
    '[CommonData]' + CRLF +
    'DriverID=MSSQL' + CRLF +
    'Server=RDI-DB-2012' + CRLF +
    'Database=CommonData' + CRLF +
    'User_Name=AuthUser' + CRLF +
    'Password=authadmin' + CRLF +
    'MetaDefCatalog=CommonData' + CRLF +
    'MetaDefSchema=dbo';

  TIME_SHEET_CONNECTION_INFO =
    '[Timesheet]' + CRLF +
    'DriverID=MSSQL' + CRLF +
    'Server=RDI-DB-2012' + CRLF +
    'Database=Timesheet' + CRLF +
    'User_Name=ereq' + CRLF +
    'Password=ereqadmin' + CRLF +
    'MetaDefCatalog=Timesheet' + CRLF +
    'MetaDefSchema=dbo';

  FSHIFT_CONNECTION_INFO =
    '[FShift]' + CRLF +
    'DriverID=MSSQL' + CRLF +
    'Server=RDI-3GATE' + CRLF +
    'Database=FShift' + CRLF +
    'User_Name=3gateshell' + CRLF +
    'Password=rdi3gate' + CRLF +
    'MetaDefCatalog=FShift' + CRLF +
    'MetaDefSchema=dbo';

  //----------------------------------------------------------------------------

  // Database actions.
  ACTION_INSERT = 1;
  ACTION_UPDATE = 2;
  ACTION_DELETE = -1;

implementation

end.

