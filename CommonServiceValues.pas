unit CommonServiceValues;

interface

uses
  Winapi.Windows, Winapi.Messages;

const
  Days: array[1..7] of string = ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

  // XML Formatt specifiers
  EMPTY_STRING = '';
  ONE_SPACE = ' ';
  TWO_SPACE = '  ';
  FOUR_SPACE = '    ';
  SIX_SPACE = '      ';

  CRLF = #13#10;
  COMMA = ',';
  SEMI_COLON = ';';
  PIPE = '|';
  // Field data delimiter character
  DOUBLE_QUOTE = '"';
  SINGLE_QUOTE = '''';
  TELNET_PORT = 'telnet'; // Default telnet port standard = 23
  ESCAPE_CHAR = '\';
  DOUBLE_ESCAPE_CHAR = '\\';
  ALL_FILES_MASK = '*.*';

  // Default registry constants
  // Common keys
  KEY_ROOT = '\Software\Van Brakel';
  KEY_COMMON = {KEY_ROOT + } 'Common\';
  KEY_RESOURCE = KEY_COMMON + 'Resource';
  KEY_DATABASE = KEY_COMMON + 'Database';
  KEY_DATASNAP = KEY_COMMON + 'DataSnap';
  KEY_USER_DATA = KEY_COMMON + 'User Data\';
  KEY_USER_PREFERENCES = KEY_COMMON + 'User Preferences\';
  KEY_TCP = KEY_DATASNAP + '\TCP';
  KEY_EXTERNAL_FILE_ACCESS = KEY_ROOT + 'External File Access\';

  ROOT_FOLDER = 'C:\Data\VB\';
//  ROOT_DATA_FOLDER = ROOT_FOLDER;
  COMMON_FOLDER = 'Common\';
  RC_SHELL_FOLDER = 'VB Shell\';
  EXCEL = 'Excel\';
  PDF_DOCS = 'PDF\';
  DATA_FILES = 'Data Files\';
  RESOURCE = 'Resource\';
  // FireDAC conection definition file.
  CONNECTION_DEFINITION_FILE = ROOT_FOLDER + RESOURCE + 'ConnectionDefinitions.ini';

  // Constants to identify the client application.
  APP_VB_SHELL = 'VB Shell';
  LOCAL_USER_INFO =
    'LOGON_NAME=%s' + PIPE +
    'COMPUTER_NAME=%s' + PIPE +
    'IP_ADDRESS=%s';

  LOCAL_EXECUTABLE_ROOT_FOLDER = 'C:\Data\Delphi\Bin\';
  LOCAL_DEBUG_SERVER = LOCAL_EXECUTABLE_ROOT_FOLDER + 'Servers\VBDSServerDebug.exe';

  // Default localhost port no's for connecting debug SOAP server to local machine.
  VB_SHELL_SERVICE_TCP_PORT = 2010;
  VB_SHELL_SERVICE_HTTP_PORT = 8010;

  VB_SHELLX_SERVICE_TCP_PORT = 2020;
  VB_SHELLX_SERVICE_HTTP_PORT = 8020;

  SQL_ERROR_2601 = 'Duplicate %s: %s not allowed. Transaction was rolled back';
  SQL_ERROR_208 = 'SQL server object name: %s does not exist.';
  SQL_ERROR_515 = 'Server error: %s';

  // Deprecated by CVG on 04/02/2020
//  SQL_STATEMENT = 'SELECT S.SQL_STATEMENT, S.DATASET_NAME FROM VIEW_SCRIPT S WHERE S.SCRIPT_ID = %s';
//  SQL_DATASET_NAME = 'SELECT S.SQL_STATEMENT FROM VIEW_SCRIPT S WHERE S.DATASET_NAME = %s';

  SQL_STATEMENT = 'SELECT S.SQL_STATEMENT, S.DATASET_NAME FROM SCRIPT S WHERE S.ID = %s';
  SQL_DATASET_NAME = 'SELECT S.SQL_STATEMENT FROM SCRIPT S WHERE S.ID = %s';
//  SQL_DATASET_NAME = 'SELECT S.SQL_STATEMENT FROM SCRIPT S WHERE S.DATASET_NAME = %s';
//  SQL_DATASET_NAME = 'SELECT S.SQL_STATEMENT FROM SCRIPT S WHERE S.DATASET_NAME LIKE %%%s%%';

  //----------------------------------------------------------------------------

  // Connection information stored in connection ini file (See above).
  TIME_SHEET_CONNECTION_INFO =
    '[Timesheet]' + CRLF +
    'DriverID=MSSQL' + CRLF +
    'Server=RDI-DB-2012' + CRLF +
//    'Server=192.168.5.5' + CRLF +
  'Database=Timesheet' + CRLF +
    'User_Name=ereq' + CRLF +
    'Password=ereqadmin' + CRLF +
    'MetaDefCatalog=Timesheet' + CRLF +
    'MetaDefSchema=dbo';

  //----------------------------------------------------------------------------

  // Database actions.
  ACTION_INSERT = 1;
  ACTION_MODIFY = 2;
  ACTION_DELETE = -1;

  // Drawing borders around grid cell.
  CM_DRAWBORDER = WM_APP + 300;

implementation

end.

