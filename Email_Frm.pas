unit Email_Frm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Forms,
  System.Classes, Vcl.Graphics, System.ImageList, Vcl.ImgList, System.Actions,
  Vcl.ActnList, Vcl.Controls, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls,

  BaseLayout_Frm, CommonValues,

  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinsDefaultPainters, cxImageList, dxLayoutLookAndFeels, cxClasses, cxStyles,
  dxLayoutContainer, dxLayoutControl, dxLayoutcxEditAdapters, cxEdit, cxButtons,
  dxLayoutControlAdapters, cxContainer, dxBar, cxMemo, cxCustomListBox, cxListBox,
  cxTextEdit, Vcl.ExtActns;

type
  TEmailFrm = class(TBaseLayoutFrm)
    edtSubject: TcxTextEdit;
    lstRecipient: TcxListBox;
    lstCC: TcxListBox;
    memBody: TcxMemo;
    barManager: TdxBarManager;
    barToolbar: TdxBar;
    docToolbar: TdxBarDockControl;
    litToolbar: TdxLayoutItem;
    btnClose: TdxBarLargeButton;
    btnSendMail: TdxBarLargeButton;
    litRecipient: TdxLayoutItem;
    litCC: TdxLayoutItem;
    litSubject: TdxLayoutItem;
    litBody: TdxLayoutItem;
    grpSendTo: TdxLayoutGroup;
    grpRecipient: TdxLayoutGroup;
    grpCC: TdxLayoutGroup;
    grpRecipientControls: TdxLayoutGroup;
    grpCCControls: TdxLayoutGroup;
    btnAddRecipient: TcxButton;
    btnDeleteRecipient: TcxButton;
    btnAddCC: TcxButton;
    btnDeleteCC: TcxButton;
    litAddrecipient: TdxLayoutItem;
    litDeleteRecipient: TdxLayoutItem;
    litAddCC: TdxLayoutItem;
    litDeleteCC: TdxLayoutItem;
    actAddRecipient: TAction;
    actAddCC: TAction;
    actDeleteRecipient: TAction;
    actDeleteCC: TAction;
    actTools: TActionList;
    actCancel: TAction;
    actSendMail: TAction;
    btnMail: TcxButton;
    procedure DoAddRecipient(Sender: TObject);
    procedure DoDeleteRecipient(Sender: TObject);
    procedure DoCloseForm(Sender: TObject);
    procedure actSendMailExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure SendEmail;
  public
    { Public declarations }
  end;

var
  EmailFrm: TEmailFrm;

implementation

{$R *.dfm}

uses
  RecipientInput_Frm,
  SendEmail;

procedure TEmailFrm.FormCreate(Sender: TObject);
begin
//  inherited;
  Caption := 'Email Messasge';
  layMain.Align := alClient;
  layMain.LookAndFeel := lafCustomSkin;
end;

procedure TEmailFrm.actSendMailExecute(Sender: TObject);
begin
//  inherited;
//  SendEmail;
end;

procedure TEmailFrm.DoAddRecipient(Sender: TObject);
var
  MyListBox: TcxListBox;

  procedure AddItem(ItemValue: string; AListBox: TcxListBox);
  begin
    if AListBox.Items.IndexOf(ItemValue) > 0 then
      raise EValidateException.Create('Email address: ' + ItemValue + ' already exists. Duplicates not allowed');

    AListBox.Items.Add(ItemValue);
  end;

begin
//  inherited;
  if RecipientInputFrm = nil then
    RecipientInputFrm := TRecipientInputFrm.Create(nil);

  if RecipientInputFrm.ShowModal = mrOK then
  begin
    case TAction(Sender).Tag of
      0: MyListBox := lstRecipient;
      2: MyListBox := lstCC;
    end;

    AddItem(RecipientInputFrm.EmailAddress, MyListBox);
  end;

  RecipientInputFrm.Close;
  FreeAndNil(RecipientInputFrm);
end;

procedure TEmailFrm.DoCloseForm(Sender: TObject);
begin
//  inherited;
  Self.ModalResult := mrCancel;
end;

procedure TEmailFrm.DoDeleteRecipient(Sender: TObject);
begin
//  inherited;
//
end;

procedure TEmailFrm.SendEmail;
var
  MailMsg: TSendEMail;
  I: Integer;
  Recipients: string;
begin
  MailMsg := TSendEmail.Create;
  Recipients := '';
  try
//    MailMsg.FromEmail
    MailMsg.Subject := edtSubject.Text;
    MailMsg.Body := memBody.Text;

    for I := 0 to lstRecipient.Items.Count - 1 do
    begin
      Recipients := Recipients + lstRecipient.Items[I];
      if I < lstRecipient.Items.Count then
        Recipients := Recipients + ';';
    end;

    MailMsg.Recipient := Recipients;

    Recipients := '';
    for I := 0 to lstCC.Items.Count - 1 do
    begin
      Recipients := Recipients + lstCC.Items[I];
      if I < lstCC.Items.Count then
        Recipients := Recipients + ';';
    end;

    MailMsg.CC := Recipients;
    if not MailMsg.SendMailMsg then
      raise EMailSendError.Create('One or more errors occurred when sending the email message');
    {TODO: Add attachment facility here}
//    MailMsg.AddAttachment(FileName);
  finally
    MailMsg.Free;
  end;

//  MailMsg.send
//  finally
//    VarClear(EMail);
//  end;
end;

end.

