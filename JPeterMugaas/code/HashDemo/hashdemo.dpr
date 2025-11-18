program hashdemo;

uses
  Vcl.Forms,
  hashdemoform in 'hashdemoform.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmHash, frmHash);
  Application.Run;
end.
