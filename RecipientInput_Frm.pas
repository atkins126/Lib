unit RecipientInput_Frm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Forms,
  System.Classes, Vcl.Graphics, System.ImageList, Vcl.ImgList, Vcl.Controls,
  Vcl.Dialogs, System.Actions, Vcl.ActnList, Vcl.Menus, Vcl.StdCtrls,

  BaseLayout_Frm, CommonValues,

  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinsDefaultPainters, cxImageList, dxLayoutLookAndFeels, cxClasses, cxStyles,
  dxLayoutContainer, dxLayoutControl, dxLayoutcxEditAdapters, cxEdit, cxButtons,
  dxLayoutControlAdapters, cxContainer, cxTextEdit;

type
  TRecipientInputFrm = class(TBaseLayoutFrm)
    edtEmailAddress: TcxTextEdit;
    grpControls: TdxLayoutGroup;
    litEmailAddress: TdxLayoutItem;
    btnOK: TcxButton;
    btnCancel: TcxButton;
    litOK: TdxLayoutItem;
    litCancel: TdxLayoutItem;
    sep1: TdxLayoutSeparatorItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtEmailAddressPropertiesChange(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    FEmailAddress: string;
    { Private declarations }
  public
    { Public declarations }
    property EmailAddress: string read FEmailAddress write FEmailAddress;
  end;

var
  RecipientInputFrm: TRecipientInputFrm;

implementation

{$R *.dfm}

uses RUtils;

procedure TRecipientInputFrm.btnOKClick(Sender: TObject);
var
  Response: string;
begin
//  inherited;
  Response := '';
  if not ValidEmailAddress(edtEmailAddress.Text, Response) then
    raise EValidateException.Create(Response);

  FEmailAddress := edtEmailAddress.Text;
  Self.ModalResult := mrOK;
end;

procedure TRecipientInputFrm.edtEmailAddressPropertiesChange(Sender: TObject);
begin
//  inherited;
  btnOK.Enabled := Length(Trim(edtEmailAddress.Text)) > 0;
end;

procedure TRecipientInputFrm.FormCreate(Sender: TObject);
begin
//  inherited;
  Caption := 'Recipient Email Address';
  layMain.Align :=  alClient;
  layMain.LookAndFeel :=  lafCustomSkin;
  Self.Height := 130;
  Self.Width := 405;
  btnOK.Enabled := False;
end;

procedure TRecipientInputFrm.FormShow(Sender: TObject);
begin
//  inherited;
  edtEmailAddress.SetFocus;
end;

end.

