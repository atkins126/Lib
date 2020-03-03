unit Progress_Frm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Forms,
  System.Classes, Vcl.Graphics, System.ImageList, Vcl.ImgList, Vcl.Controls,
  Vcl.Dialogs, System.Actions, Vcl.ActnList, System.StrUtils,

  BaseLayout_Frm, VBCommonValues,

  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinsDefaultPainters, cxImageList, dxLayoutLookAndFeels, cxContainer, cxEdit,
  cxClasses, cxStyles, dxLayoutContainer, dxLayoutControl, dxLayoutcxEditAdapters,
  cxImage, cxProgressBar, cxLabel;

type
  TProgressFrm = class(TBaseLayoutFrm)
    grpHeader: TdxLayoutGroup;
    grpDownloadProgress: TdxLayoutGroup;
    litAppTitle: TdxLayoutItem;
    litImage: TdxLayoutItem;
    imgDownload: TcxImage;
    litSubTitle: TdxLayoutItem;
    lblAppTitle: TcxLabel;
    styHeaderTitle: TcxEditStyleController;
    litProgressBar: TdxLayoutItem;
    lblDownloadName: TcxLabel;
    prgDownload: TcxProgressBar;
    sep1: TdxLayoutSeparatorItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
//    procedure HandleProgressCaption(var MyMsg: TMessage); message WM_DOWNLOAD_CAPTION;
    procedure HandleCaption(var MyMsg: TMessage); message WM_DOWNLOAD_CAPTION;
    procedure HandleProgress(var MyMsg: TMessage); message WM_DOWNLOAD_PROGRESS;
  protected
//    procedure WndProc(var MyMsg: TMessage); override;
//    procedure HandleCaption(var MyMsg: TMessage); message WM_DOWNLOAD_CAPTION;
//    procedure HandleProgress(var MyMsg: TMessage); message WM_DOWNLOAD_PROGRESS;
  public
    { Public declarations }
  end;

var
  ProgressFrm: TProgressFrm;

implementation

{$R *.dfm}

uses RUtils;

procedure TProgressFrm.FormCreate(Sender: TObject);
begin
  inherited;
{
  $ED9564 = clWebConrFlowerBlue
  $FAE6E6 = clWebLavender
  $C0DCC0 = clMintgreen
  $F0CAA6 = clSkyBlue
}

  layMain.Align := alClient;
  layMain.LayoutLookAndFeel := lafCustomSkin;
//  prgDownload.Properties.BeginColor := $ED9564
//  prgDownload.Style.BorderStyle := ebsOffice11;
//  prgDownload.Style.LookAndFeel.SkinName := '';
end;

//procedure TProgressFrm.HandleProgressCaption(var MyMsg: TMessage);
//var
////  P: PChar;
////  S, T: string;
//  SL: TStringList;
//  Progress: Extended;
//begin
//  // WParam is the first parameter
//  // LParam is the second parameter
////  P := PChar(MyMsg.WParam);
//  SL := TStringList.Create;
//  SL.Delimiter := PIPE;
//  SL.QuoteChar := '"';
//  SL.DelimitedText := PChar(MyMsg.WParam);
//  Progress := StrToFloat(SL.Values['PROGRESS']);
//
////  if Length(Trim(SL.Values['CAPTION'])) > 0 then
////    lblDownloadName.Caption := ReplaceText(SL.Values['CAPTION'], '_', ' ');
//
//    lblDownloadName.Caption := SL.Values['CAPTION'];
//
//
//  try
//    prgDownload.Position := Trunc(Progress);
//    prgDownload.Update;
//    Update;
//  finally
//    MyMsg.Result := 1;
//    SL.Free;
//  end;
//end;

procedure TProgressFrm.FormShow(Sender: TObject);
begin
  inherited;
  Width := 400;
  Height := 120;
end;

procedure TProgressFrm.HandleCaption(var MyMsg: TMessage);
//var
//  SL: TStringList;
//  Progress: Extended;
begin
  inherited;
  try
    lblDownloadName.Caption := PChar(MyMsg.WParam);
    lblDownloadName.Update;
    Update;
  finally
    MyMsg.Result := 1;
  end;

//  case MyMsg.Msg of
//    WM_DOWNLOAD_CAPTION:
//      begin
//        SL := RUtils.CreateStringList(PIPE);
//        SL.QuoteChar := '"';
//        SL.DelimitedText := PChar(MyMsg.WParam);
//        lblDownloadName.Caption := SL.Values['CAPTION'];
//      end;
//  end;
end;

procedure TProgressFrm.HandleProgress(var MyMsg: TMessage);
var
//  SL: TStringList;
  Progress: Extended;
begin
  inherited;
  Progress := StrToFloat(PChar(MyMsg.WParam));
  try
    prgDownload.Position := Trunc(Progress);
    prgDownload.Update;
    Update;
  finally
    MyMsg.Result := 1;
  end;

//  case MyMsg.Msg of
//    WM_DOWNLOAD_CAPTION:
//      begin
//        SL := RUtils.CreateStringList(PIPE);
//        SL.QuoteChar := '"';
//        SL.DelimitedText := PChar(MyMsg.WParam);
//        Progress := StrToFloat(SL.Values['PROGRESS']);
//
//        try
//          prgDownload.Position := Trunc(Progress);
//          prgDownload.Update;
//          Update;
//        finally
//          MyMsg.Result := 1;
//          SL.Free;
//        end;
//      end;
//end;
end;

//procedure TProgressFrm.WndProc(var MyMsg: TMessage);
//var
//  SL: TStringList;
//  Progress: Extended;
//begin
//  inherited;
//  case MyMsg.Msg of
//    WM_DOWNLOAD_CAPTION:
//      begin
//        SL := RUtils.CreateStringList(PIPE);
//        SL.QuoteChar := '"';
//        SL.DelimitedText := PChar(MyMsg.WParam);
//        Progress := StrToFloat(SL.Values['PROGRESS']);
//        lblDownloadName.Caption := SL.Values['CAPTION'];
//
//        try
//          prgDownload.Position := Trunc(Progress);
//          prgDownload.Update;
//          Update;
//        finally
//          MyMsg.Result := 1;
//          SL.Free;
//        end;
//      end;
//  end;
//end;

end.

