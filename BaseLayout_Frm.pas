unit BaseLayout_Frm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Forms,
  System.Classes, Vcl.Graphics, System.ImageList, Vcl.ImgList, Vcl.Controls,
  Vcl.Dialogs, System.Actions, Vcl.ActnList,

  Base_Frm, {CustomerDetail,}

  cxImageList, cxGraphics, dxLayoutLookAndFeels, cxClasses, cxStyles, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxLayoutContainer, dxLayoutControl, dxSkinMoneyTwins,
  dxSkinOffice2019Colorful, dxSkinTheBezier;

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
  layMain.Align := alClient;
end;

end.

