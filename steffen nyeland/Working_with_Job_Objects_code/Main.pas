unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,

  FbC.JobObjects;

type
  TfrmMain = class(TForm)
    memErrorLog: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    ChildThread: TChildThread;
    procedure LogChildError(const Value: string);
    procedure DidChildTerminateUnexpected(Sender: TObject);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  System.IOUtils;

{$R *.dfm}

procedure TfrmMain.DidChildTerminateUnexpected(Sender: TObject);
begin
  memErrorLog.Lines.Insert(0, 'Error: Seems like the child process was closed unexpected!!!.');
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  ChildExeName: string;
begin
  inherited;
// Start Child process and attach to this process via Job Object
  ChildExeName := TPath.Combine(ExtractFilePath(ParamStr(0)), 'ChildProcessC.exe');
  if FileExists(ChildExeName) then
  begin
    ChildExeName := '"'+ChildExeName+'"';
    System.UniqueString(ChildExeName);
    ChildThread := TChildThread.Create(ChildExeName, LogChildError);
    ChildThread.OnTerminate := DidChildTerminateUnexpected;
  end
  else
    memErrorLog.Lines.Add('Error: Not able to find any child process exe to start.');
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  if Assigned(ChildThread) and (ChildThread.ProcessInfo.hProcess>0) then
  begin
    ChildThread.OnTerminate := nil;
    TerminateProcess(ChildThread.ProcessInfo.hProcess, 0);
    ChildThread.Free;
  end;
  inherited;
end;

procedure TfrmMain.LogChildError(const Value: string);
begin
  // Would perfect the thing if we waited for the "whole" message
  memErrorLog.Lines.Insert(0, 'Errors found: '+Value);
end;

end.
