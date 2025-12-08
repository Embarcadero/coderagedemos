program CR2025Demo;

uses
  Vcl.Forms,
  Main in 'Main.pas' {frmMain},
  FbC.JobObjects in 'FbC.JobObjects.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
