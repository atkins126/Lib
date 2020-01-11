unit BaseLayout_Frm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Forms,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Dialogs, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList,

  Base_Frm, VersionInformation,

  cxContainer, cxEdit, cxClasses, cxStyles, cxGraphics, cxControls, cxImageList,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxLayoutContainer, dxLayoutControl, dxLayoutLookAndFeels, dxPrnDev, dxPrnDlg,
  dxScreenTip, dxCustomHint, cxHint, Vcl.AppEvnts, dxSkinTheBezier,
  dxSkinMoneyTwins, dxSkinSummer2008;

type
  TBaseLayoutFrm = class(TBaseFrm)
    layMainGroup_Root: TdxLayoutGroup;
    layMain: TdxLayoutControl;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BaseLayoutFrm: TBaseLayoutFrm;

implementation

{$R *.dfm}

procedure TBaseLayoutFrm.FormCreate(Sender: TObject);
begin
  inherited;
  layMain.LayoutLookAndFeel := lafCustomSkin;
end;

end.

