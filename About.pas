unit About;

interface

implementation

uses

  System.SysUtils, About_Frm;

type
  TAbout = class
  public
    constructor Create;
    destructor Destroy override;
  end;

{ TAbout }

constructor TAbout.Create;
begin
  if AboutFrm = nil then
    AboutFrm := TAboutFrm.Create(nil);
  AboutFrm.ShowModal;
end;

destructor TAbout.Destroy;
begin
  FreeAndNil(AboutFrm);
end;

end.

