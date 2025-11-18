program httpdemo;

uses
  Vcl.Forms,
  formHTTPClient in 'formHTTPClient.pas' {frmHTTPSDemo};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmHTTPSDemo, frmHTTPSDemo);
  Application.Run;
end.
