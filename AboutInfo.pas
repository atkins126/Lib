unit AboutInfo;

interface

type
  TAboutInfo = class
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses

  System.SysUtils, About_Frm;

{ TAbout }

constructor TAboutInfo.Create;
begin
  if AboutFrm = nil then
    AboutFrm := TAboutFrm.Create(nil);
  AboutFrm.ShowModal;
end;

destructor TAboutInfo.Destroy;
begin
  FreeAndNil(AboutFrm);
end;

end.

