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
    procedure HandleCaption(var MyMsg: TMessage); message WM_DOWNLOAD_CAPTION;
    procedure HandleProgress(var MyMsg: TMessage); message WM_DOWNLOAD_PROGRESS;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
  end;

var
  ProgressFrm: TProgressFrm;

implementation

{$R *.dfm}

uses RUtils;

procedure TProgressFrm.CreateParams(var Params: TCreateParams);
begin
  inherited;
//  Params.Style := Params.Style or WS_BORDER or WS_THICKFRAME;
//  Params.Style:= (Params.Style or WS_POPUP) {and (not WS_DLGFRAME)};
  Params.Style := Params.Style or WS_BORDER or WS_DLGFRAME and (not WS_CAPTION) {and (not WS_DLGFRAME)};

//        SetWindowLong(Handle, GWL_STYLE, Save and (not (WS_CAPTION)) or WS_BORDER);
//      bsDialog:
//        SetWindowLong(Handle, GWL_STYLE, Save and (not (WS_CAPTION)) or DS_MODALFRAME
end;

procedure TProgressFrm.FormCreate(Sender: TObject);
begin
  inherited;
  layMain.Align := alClient;
  layMain.LayoutLookAndFeel := lafCustomSkin;
end;

procedure TProgressFrm.FormShow(Sender: TObject);
begin
  inherited;
  Width := 400;
  Height := 140;
end;

procedure TProgressFrm.HandleCaption(var MyMsg: TMessage);
begin
  inherited;
  try
    lblDownloadName.Caption := PChar(MyMsg.WParam);
    lblDownloadName.Update;
    Update;
  finally
    MyMsg.Result := 1;
  end;
end;

procedure TProgressFrm.HandleProgress(var MyMsg: TMessage);
var
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
end;

end.

