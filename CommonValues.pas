unit CommonValues;

interface

uses
  System.SysUtils, Winapi.Windows, Winapi.Messages;

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
  TDBActions = (acInsert, acEdit, acDelete, acBrowsing);
  TKitStoreTransactionTypes = (ttReceiving, ttIssuing, ttReturn, ttCancel, ttBinTransfer);
  TFileExtensions = (xls, xlsx, doc, docx, mdb, accdb, pdf, jpg, png, bitmap, bmp);
  TReportActions = (raPreview, raPrint, raExcel, raPDF);

  EValidateException = class(Exception);
  EDuplicateException = class(Exception);
  ENoDataException = class(Exception);
  ELaunchException = class(Exception);
  ESelectionException = class(Exception);
  EFileNotFoundException = class(Exception);
  EExecutionException = class(Exception);
  EServerError = class(Exception);
  EMailSendError = class(Exception);

var
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
  KEY_COMMON_ROOT = '\Software\Reutech Communications';
  KEY_COMMON_RESOURCE = KEY_COMMON_ROOT + '\Common Resource';
  KEY_COMMON_SOAP = KEY_COMMON_RESOURCE + '\Soap';
  KEY_COMMON_DATABASE = KEY_COMMON_RESOURCE + '\Database';
  KEY_COMMON_RESOURCE_FILES = KEY_COMMON_RESOURCE + '\Resource Files';
  KEY_COMMON_RESOURCE_USER_DATA = KEY_COMMON_RESOURCE + '\User Data';
  KEY_COMMON_RESOURCE_USER_PREFERENCES = KEY_COMMON_RESOURCE + '\User Preferences';
  KEY_LEAVE_MANAGER = KEY_COMMON_RESOURCE_USER_PREFERENCES + '\Leave Manager';
  KEY_COMMON_TCP = KEY_COMMON_RESOURCE + '\TCP';
  KEY_FOURTH_SHIFT = KEY_COMMON_ROOT + '\Fourth Shift';
  KEY_CREDITOR = KEY_COMMON_RESOURCE_USER_PREFERENCES + '\Creditor';
  KEY_KIT_STORE = KEY_COMMON_RESOURCE_USER_PREFERENCES + '\Kit Store';
  KEY_FS_RECOVERY = KEY_COMMON_ROOT + '\FS Recovery monitor';
  KEY_EXTERNAL_FILE_ACCESS = KEY_COMMON_ROOT + '\External File Access';
  // DataSnap constants
  KEY_COMMON_DATASNAP = KEY_COMMON_RESOURCE + '\DataSnap';

  // Autopick printer listing ocnstants. These are the Reg keys that store the
  // default printers for the Autopick utility.
  AUTOPICK_PRINTER = 'Default Pick List Printer';
//  AUTOPICK_PRINTER_INTERNAL = 'Default Pick List Printer (Internal)';
//  AUTOPICK_PRINTER_CUSTOMER = 'Default Pick List Printer (Customer)';
  LABEL_PRINTER = 'Default Label Printer';
  BULK_PRINTER = 'Default Bulk Printer';

//  RC_APP_FOLDER = 'Reutech Communications\Applications\';
//  APPLICATION64_FOLDER = 'C:\Program Files\Reutech Communications\Applications\';
//  ROOT_DATA_FOLDER = 'C:\ProgramData\Reutech Communications\';
  ROOT_FOLDER = 'C:\RC Data\';
//  ROOT_DATA_FOLDER = 'Reutech Communications\';
  // Modified by CVG on 04/08/2017
  ROOT_DATA_FOLDER = ROOT_FOLDER;
  COMMON_FOLDER = 'Common\';
  RC_SHELL_FOLDER = 'RC Shell\';
  AUTO_PICK_FOLDER = 'AutoPick\';
  FSHIFT_FOLDER = 'Fshift\';
  EXCEL = 'Excel\';
  PDF_DOCS = 'PDF Docs\';
  DATA_FILES = 'Data Files\';
  LEAVE_IMPORT_OUTPUT_FOLDER = 'Leave\';
  PAYROLL_LEAVE = '\\RC-FS-2012\FileServer\Share\Payroll Leave\';
  SHELL_LEAVE = '\\RC-FS-2012\FileServer\Share\Shell Leave\';
  JT_LEAVE = '\\RC-FS-2012\FileServer\Share\Jarrison Leave\';
  FS_USER_FOLDER = 'C:\FSUser\';
  ATTACHMENT_ROOT_FOLDER = 'Attachment\';
  LEAVE_ATTACHMENT_FOLDER = ATTACHMENT_ROOT_FOLDER + 'Leave\';
  {$IFDEF DEBUG}
  FS_RECOVERY_ROOT_FOLDER = 'C:\RCVR\';
  {$ELSE}
  FS_RECOVERY_ROOT_FOLDER = '\\RC-FSHIFT-2012\FShift\RCVR\';
  {$ENDIF}

  // FireDAC conection definition file.
  CONNECTION_DEFINITION_FILE = ROOT_DATA_FOLDER + COMMON_FOLDER + 'ConnectionDefinitions.ini';
  LOCAL_EXECUTABLE_ROOT_FOLDER = 'C:\Data\Delphi\Bin\';
  LOCAL_VB_SHELL_DS_SERVER = LOCAL_EXECUTABLE_ROOT_FOLDER + 'Servers\VBDSServerDebug.exe';
//  LOCAL_LEAVE_DS_SERVER = LOCAL_EXECUTABLE_ROOT_FOLDER + 'Servers\LeaveDSServerDebug.exe';
//  LOCAL_FSHIFT_DS_SERVER = LOCAL_EXECUTABLE_ROOT_FOLDER + 'Servers\FShiftDSServerDebug.exe';

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

  // Database actions.
  ACTION_INSERT = 1;
  ACTION_UPDATE = 2;
  ACTION_DELETE = -1;

  //----------------------------------------------------------------------------

  // First format specifier is the table name
  // Second format specifier is the field name list
  // Third format specifier contains the field values to be inserted
  INSERT_RECORD = ' INSERT INTO %s(%s) VALUES(%s) RETURNING ID';

  // First format specifier is the table name
  // Second format specifier is name/value pair to set the new field values
  // Third format specifier contains the where clause
  UPDATE_RECORD = ' UPDATE %s SET %s %s';

implementation

end.

