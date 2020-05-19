unit SendEmail;

interface

uses
  System.SysUtils, System.Win.ComObj, Vcl.OleCtrls;

type
  TSendEmail = class
  private
    FFromEmail: string;
    FEmail: Variant;
    FRecipient: string;
    FGreeting: string;
    FSubject: string;
    FBody: string;
    FContactPerson: string;
    FCC: string;
  public
    property FromEmail: string read FFromEmail write FFromEmail;
    property Recipient: string read FRecipient write FRecipient;
    property CC: string read FCC write FCC;
    property Subject: string read FSubject write FSubject;
    property Greeting: string read FGreeting write FGreeting;
    property ContactPerson: string read FContactPerson write FContactPerson;
    property Body: string read FBody write FBody;

    constructor Create;
    destructor Destroy; override;
    procedure AddAttachment(FileName: string);
    function SendMailMsg: Boolean;
  end;

const
  CRLF = #13#10;

implementation

{ TSendEmail }

constructor TSendEmail.Create;
const
  MESSAGE_BODY = 'Good day %s,' + CRLF + CRLF + 'Attached, please find your latest Remittanc/Recon for your attention.';
//  olMailItem = $00000000;
var
  Outlook: OleVariant;
//  EMail, MailRecipients: Variant;
begin
  try
    // If Outlook is already running then just get the handle on it...
    Outlook := GetActiveOleObject('Outlook.Application');
  except
    // ...Other wise create an instance of Outlook.
    Outlook := CreateOleObject('Outlook.Application');
  end;

//  EMail := Outlook.CreateItem(olMailItem);
  FEMail := Outlook.CreateItem(Outlook.OlItemType.olMailItem);
  FEMail.Recipients.Add(FRecipient, 1);
  if Length(Trim(FCC)) > 0 then
    FEMail.Recipients.Add(FCC, 2);

//  FEMail.Recipient := FRecipient;
//  FEMail.To := FRecipient;
  FEMail.Subject := FSubject;
  FEMail.Body := Body;
//  FEMail.Attachments.Add(FileName);
end;

procedure TSendEmail.AddAttachment(FileName: string);
begin
  FEMail.Attachments.Add(FileName);
end;

destructor TSendEmail.Destroy;
begin
  VarClear(FEMail);
  inherited;
end;

function TSendEmail.SendMailMsg: Boolean;
begin
//  try
  FEmail.Send;
//  except
//
//  end;
end;

end.

