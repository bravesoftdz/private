unit uLoginDlg;

interface

uses
  Winapi.Windows,
  System.SysUtils,
  System.Classes,
  Vcl.Graphics,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.Buttons;

type
  TfmLoginDlg = class(TForm)
    lbPassword: TLabel;
    edPassword: TEdit;
    OKBtn: TButton;
    CancelBtn: TButton;
    lbUser: TLabel;
    edUser: TEdit;
  private
    //
  public
    //
  end;

  function Login(aOwner:TComponent; var aUser,aPassword:string):Boolean;

implementation

{$R *.dfm}

function Login(aOwner:TComponent; var aUser,aPassword:string):Boolean;
var
  fmLoginDlg: TfmLoginDlg;
begin
  fmLoginDlg:=TfmLoginDlg.Create(aOwner);
  try
     fmLoginDlg.edUser.Text:=aUser;
     fmLoginDlg.edPassword.Text:=aPassword;
     Result:= fmLoginDlg.ShowModal = mrOK;
     if Result then
     begin
       aUser:=fmLoginDlg.edUser.Text;
       aPassword:=fmLoginDlg.edPassword.Text;
     end;
  finally
     fmLoginDlg.Free;
  end;
end;

end.
 
