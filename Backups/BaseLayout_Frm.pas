unit BaseLayout_Frm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base_Frm, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxLayoutContainer, dxLayoutControl, System.ImageList, Vcl.ImgList,
  cxImageList, dxLayoutLookAndFeels, System.Actions, Vcl.ActnList, cxContainer,
  cxEdit, cxClasses, cxStyles;

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
