program server;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {fmServer},
  uDMServer in 'uDMServer.pas' {dmServer: TDataModule},
  uLoginDlg in 'uLoginDlg.pas' {fmLoginDlg};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmServer, dmServer);
  Application.CreateForm(TfmServer, fmServer);
  Application.Run;
end.
