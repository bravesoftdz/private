program client;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {fmMain},
  superdate in 'superobject\superdate.pas',
  superobject in 'superobject\superobject.pas',
  supertimezone in 'superobject\supertimezone.pas',
  supertypes in 'superobject\supertypes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
