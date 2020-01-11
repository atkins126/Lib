unit MsgDialog_Frm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Forms,
  System.Classes, Vcl.Graphics, Vcl.AppEvnts, Vcl.ExtCtrls, Vcl.Controls,
  Vcl.Dialogs, Vcl.ImgList, Vcl.Printers, Vcl.Menus, Vcl.StdCtrls, System.Actions,
  Vcl.ActnList, System.ImageList,

  Base_Frm,

  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxSkinsCore, dxSkinsDefaultPainters, cxGroupBox, dxBevel, cxTextEdit,
  cxMemo, cxCheckBox, cxLabel, cxImage, cxButtons, cxClasses, cxStyles, dxPrnDev,
  dxPrnDlg, dxLayoutLookAndFeels, cxImageList;

const
  MIN_WIDTH = 400;
  DEFAULT_HEIGHT = 145;
  DEFAULT_LEFT = 375;
  DEFAULT_OFFSET = 100;
  RIGHT_BUTTON_LEFT_OFFSET = 100;

type
  TMyButtons = array of TcxButton;

  TmsgDialogFrm = class(TBaseFrm)
    pnlFormHeader: TcxGroupBox;
    pnlControl: TcxGroupBox;
    pnlMsgDetail: TcxGroupBox;
    imgTitle: TcxImage;
    lblMainTitle: TcxLabel;
    memMsgDetail: TcxMemo;
    bvlHeaderBottom: TdxBevel;
    bvlFooterTop: TdxBevel;
    btnYes: TcxButton;
    btnNo: TcxButton;
    btnCancel: TcxButton;
    btnRetry: TcxButton;
    btnAbort: TcxButton;
    btnIgnore: TcxButton;
    btnAll: TcxButton;
    btnHelp: TcxButton;
    btnNoToAll: TcxButton;
    btnYesToAll: TcxButton;
    btnOK: TcxButton;
    btnClose: TcxButton;
    imgMsgDialog: TcxImageCollection;
    cxImageCollection1Item2: TcxImageCollectionItem;
    cxImageCollection1Item1: TcxImageCollectionItem;
    cxImageCollection1Item3: TcxImageCollectionItem;
    cxImageCollection1Item4: TcxImageCollectionItem;
    dlgPrint: TdxPrintDialog;
    pnlMessage: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FLeftPosition: Integer;
  public
    { Public declarations }
    FFormCaption: string;
    FMainCaption: string;
    FSubCaption: string;
    FMsg: string;
    FShowDetailedMessage: Boolean;
    FMyButton: TMyButtons;
    FButtons: TMsgDlgButtons;
    FMsgType: TMsgDlgType;
    FLongestWidth: Integer;
  end;

var
  msgDialogFrm: TmsgDialogFrm;

implementation

{$R *.dfm}


procedure TmsgDialogFrm.FormCreate(Sender: TObject);
//var
//  I, J: Integer;
begin
  inherited;
//  SetLength(FMyButton, Ord(high(TMsgDlgBtn)) + 1);
//
//  FMyButton[0] := btnYes;
//  FMyButton[1] := btnNo;
//  FMyButton[2] := btnOK;
//  FMyButton[3] := btnCancel;
//  FMyButton[4] := btnAbort;
//  FMyButton[5] := btnRetry;
//  FMyButton[6] := btnIgnore;
//  FMyButton[7] := btnAll;
//  FMyButton[8] := btnNoToAll;
//  FMyButton[9] := btnYesToAll;
//  FMyButton[10] := btnHelp;
//  FMyButton[11] := btnClose;
//
//  J := Ord(high(TMsgDlgBtn)) + 1;
//  FLeftPosition := DEFAULT_LEFT;
//
//  for I := Ord(low(TMsgDlgBtn)) to Ord(high(TMsgDlgBtn)) do
//  begin
//    FMyButton[I].Default := False;
//    FMyButton[I].Visible := False;
//    FMyButton[I].Left := FLeftPosition;
//    FMyButton[I].Top := 8;
//    FMyButton[I].TabOrder := J;
//    Dec(J);
//  end;
end;

procedure TmsgDialogFrm.FormShow(Sender: TObject);
var
  I, J: Integer;
  B: TMsgDlgBtn;
begin
  inherited;
  lblMainTitle.Style.TextColor := RootLookAndFeel.SkinPainter.DefaultSelectionColor;
  lblMainTitle.Style.Font.Color := RootLookAndFeel.SkinPainter.DefaultSelectionColor;

  SetLength(FMyButton, Ord(high(TMsgDlgBtn)) + 1);

  FMyButton[0] := btnYes;
  FMyButton[1] := btnNo;
  FMyButton[2] := btnOK;
  FMyButton[3] := btnCancel;
  FMyButton[4] := btnAbort;
  FMyButton[5] := btnRetry;
  FMyButton[6] := btnIgnore;
  FMyButton[7] := btnAll;
  FMyButton[8] := btnNoToAll;
  FMyButton[9] := btnYesToAll;
  FMyButton[10] := btnHelp;
  FMyButton[11] := btnClose;

  J := Ord(high(TMsgDlgBtn)) + 1;
  FLeftPosition := DEFAULT_LEFT;

  for I := Ord(low(TMsgDlgBtn)) to Ord(high(TMsgDlgBtn)) do
  begin
    FMyButton[I].Default := False;
    FMyButton[I].Visible := False;
    FMyButton[I].Left := FLeftPosition;
    FMyButton[I].Top := 8;
    FMyButton[I].TabOrder := J;
    Dec(J);
  end;

  // Message dialogue buttons and their order. This comes from Dialog.pas
  FMyButton[0] := btnYes;
  FMyButton[1] := btnNo;
  FMyButton[2] := btnOK;
  FMyButton[3] := btnCancel;
  FMyButton[4] := btnAbort;
  FMyButton[5] := btnRetry;
  FMyButton[6] := btnIgnore;
  FMyButton[7] := btnAll;
  FMyButton[8] := btnNoToAll;
  FMyButton[9] := btnYesToAll;
  FMyButton[10] := btnHelp;
  FMyButton[11] := btnClose;

  try
    Caption := FFormCaption;
    lblMainTitle.Caption := FMainCaption;
    imgTitle.Picture := imgMsgDialog.Items.Items[Ord(FMsgType)].Picture;

    I := 0;
    for B := low(TMsgDlgBtn) to high(TMsgDlgBtn) do
    begin
      if B in FButtons then
      begin
        FMyButton[I].Visible := True;
        if FMyButton[I].Visible then
        begin
          FMyButton[I].Left := FLeftPosition;
          Dec(FLeftPosition, 80);
        end;
      end;
      Inc(I);
    end;

    // Now we need to set the position order of the buttons
    // mbYes                     mbNo                     mbCancel
    if FMyButton[0].Visible and FMyButton[1].Visible and FMyButton[3].Visible then
    begin
      FMyButton[3].Left := Width - RIGHT_BUTTON_LEFT_OFFSET;
      FMyButton[1].Left := FMyButton[3].Left - 80;
      FMyButton[0].Left := FMyButton[1].Left - 80;
      FMyButton[3].Default := True;
      FMyButton[3].SetFocus;
    end

    //      mbYes                     mbNo
    else if FMyButton[0].Visible and FMyButton[1].Visible then
    begin
      FMyButton[1].Left := Width - RIGHT_BUTTON_LEFT_OFFSET;
      FMyButton[0].Left := FMyButton[1].Left - 80;
      FMyButton[1].Default := True;
      FMyButton[1].SetFocus;
    end

    //      mbOK
    else if FMyButton[2].Visible then
    begin
      FMyButton[2].Left := Width - RIGHT_BUTTON_LEFT_OFFSET;
      FMyButton[2].Default := True;
      FMyButton[2].SetFocus;
    end
    //      mbClose
    else if FMyButton[11].Visible then
    begin
      FMyButton[11].Left := Width - RIGHT_BUTTON_LEFT_OFFSET;
      FMyButton[11].Default := True;
      FMyButton[11].SetFocus;
    end;

    memMsgDetail.Lines.Clear;
    memMsgDetail.Lines.Add(FMsg);
  finally
    Screen.Cursor := crDefault;
  end;
end;

end.
