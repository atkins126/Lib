unit BaseLogin_Frm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.AppEvnts, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Vcl.Menus, Vcl.StdCtrls, Vcl.ImgList, Base_Frm,
  Vcl.Imaging.jpeg,
  // DevExpress
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxSkinsCore, dxSkinMoneyTwins, dxSkinsDefaultPainters, cxImage, cxPC,
  cxClasses, cxStyles, dxSkinscxPCPainter, cxPCdxBarPopupMenu, cxButtons,
  cxTextEdit, cxLabel, cxGroupBox, dxSkinsdxStatusBarPainter, dxStatusBar,
  dxBarBuiltInMenu, dxScreenTip, Soap.InvokeRegistry, Soap.Rio,
  Soap.SOAPHTTPClient;

type
  TBaseLoginFrm = class(TBaseFrm)
    pnlImage: TcxGroupBox;
    pagMain: TcxPageControl;
    tabLogin: TcxTabSheet;
    cxcLabel1: TcxLabel;
    cxcLabel2: TcxLabel;
    lblDebugMode: TcxLabel;
    edtPassword: TcxTextEdit;
    edtUserName: TcxTextEdit;
    btnLogin: TcxButton;
    btnCancel: TcxButton;
    lblCapsLockStatus: TcxLabel;
    sbrMain: TdxStatusBar;
    actCancelLogin: TAction;
    actLogin: TAction;
    imgLogo: TcxImage;
    HTTPRIO: THTTPRIO;
    procedure DoCancelLogin(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    FAppName: string;

    property AppName: string read FAppName write FAppName;
  end;

var
  BaseLoginFrm: TBaseLoginFrm;

implementation

{$R *.dfm}

uses RUtils;

procedure TBaseLoginFrm.FormCreate(Sender: TObject);
begin
  inherited;
  edtPassword.Clear;
  RUtils.HideTabs(pagMain);
  imgLogo.Style.Edges := [];
  imgLogo.Style.BorderStyle := ebsNone;
  imgLogo.StyleFocused.BorderStyle := ebsNone;
  imgLogo.StyleHot.BorderStyle := ebsNone;
end;

procedure TBaseLoginFrm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_ESCAPE then
    actCancelLogin.Execute;
end;

procedure TBaseLoginFrm.DoCancelLogin(Sender: TObject);
begin
  inherited;
  Application.Terminate

//  Beep;
//  if DisplayMsg(Application.Title,
//    Application.Title + ' - Login Cancellation',
//    'Cancel login to ' + FAppName + '?',
//    '',
//    mtConfirmation,
//    [mbYes, mbNo],
//    False
//    ) = mrYes then
//
//    Application.Terminate
//  else
//  try
//    if tabLogin.Visible then
//    begin
//      if Length(edtUserName.Text) = 0 then
//        edtUserName.SetFocus
//      else
//      begin
//        edtPassword.SetFocus;
//        if GetKeyState(VK_CAPITAL) and 1 <> 0 then
//        begin
//          if edtPassword.Focused then
//          begin
//            PostMessage(edtPassword.Handle, WM_KILLFOCUS, 0, 0);
//            PostMessage(edtPassword.Handle, WM_SETFOCUS, 0, 0);
//          end;
//        end;
//      end;
//    end;
//  except
//  end;
end;

end.

