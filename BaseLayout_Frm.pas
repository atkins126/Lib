unit BaseLayout_Frm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Forms,
  System.Classes, Vcl.Graphics, System.ImageList, Vcl.ImgList, Vcl.Controls,
  Vcl.Dialogs, System.Actions, Vcl.ActnList,

  Base_Frm, {CustomerDetail,}

  cxImageList, cxGraphics, dxLayoutLookAndFeels, cxClasses, cxStyles, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxLayoutContainer, dxLayoutControl, cxDBLookupComboBox;

type
  TcxLookupComboBoxAccess = class(TcxLookupComboBox);

  TBaseLayoutFrm = class(TBaseFrm)
    layMainGroup_Root: TdxLayoutGroup;
    layMain: TdxLayoutControl;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FAllow: Boolean;
  public
    { Public declarations }
    procedure DoMouseWheel(Sender: TObject; Allow: Boolean);
    procedure LookupViewMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
  end;

var
  BaseLayoutFrm: TBaseLayoutFrm;

implementation

{$R *.dfm}

procedure TBaseLayoutFrm.DoMouseWheel(Sender: TObject; Allow: Boolean);
begin
  FAllow :=  Allow;
  TcxLookupComboBoxAccess(Sender).OnMouseWheel := LookupViewMouseWheel;
end;

procedure TBaseLayoutFrm.LookupViewMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := not FAllow;
end;

procedure TBaseLayoutFrm.FormCreate(Sender: TObject);
begin
  inherited;
  layMain.LayoutLookAndFeel := lafCustomSkin;
  layMain.Align := alClient;
end;

end.

