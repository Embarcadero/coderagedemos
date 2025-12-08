unit FbC.JobObjects;

interface

uses
  System.Classes,
  Winapi.Windows;

// Below was missing prior to Delphi 12.x, so defined here
//TODO: put in ifdefs
//const
//  CREATE_BREAKAWAY_FROM_JOB       = $01000000;
//  {$EXTERNALSYM CREATE_BREAKAWAY_FROM_JOB}

type
  TOnCaptureProc = reference to procedure(const Value:string);

  /// <summary>
  ///   Thread class to create process and piping its STDERR back via callback
  /// </summary>
  TChildThread = class(TThread)
  const
    bufSize = 2400;
  private
    FReadBuf: array [0..bufSize] of AnsiChar;
    FCmd: string;
    FCallbackProc: TOnCaptureProc;
    FProcessInfo: TProcessInformation;
    function GethProcess: TProcessInformation;
    procedure SendLogMsg;
  public
    constructor Create(const cmd: string; CallBackProc: TOnCaptureProc);
    destructor Destroy; override;
    procedure Execute; override;
    property ProcessInfo: TProcessInformation read GethProcess;
  end;

implementation

uses
  System.SysUtils;

{ TChildThread }

constructor TChildThread.Create(const cmd: string; CallBackProc: TOnCaptureProc);
begin
  inherited Create(False);
  FreeOnTerminate := False;
  FCmd := cmd;
  FCallbackProc := CallBackProc;
end;

destructor TChildThread.Destroy;
begin
  FCallbackProc := nil;
  inherited;
end;

procedure TChildThread.Execute;
const
  secAttr: TSecurityAttributes = (
    nLength: SizeOf(TSecurityAttributes);
    bInheritHandle: True);
var
  rPipe: THandle; // Could PeekNamedPipe this for normal console info
  wPipe: THandle;
  erPipe: THandle; // STDERR pipe
  ewPipe: THandle;
  startupInfo: TStartupInfo;
  dRun, dAvail, dRead: DWORD;
  jobObject: NativeUInt;
  jobLimitInfo: TJobObjectExtendedLimitInformation;
begin
  inherited;
  if CreatePipe(rPipe, wPipe, @secAttr, 0) and CreatePipe(erPipe, ewPipe, @secAttr, 0) then
  try
    FillChar(startupInfo, SizeOf(TStartupInfo), #0);
    startupInfo.cb := SizeOf(TStartupInfo);
    startupInfo.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
    startupInfo.wShowWindow := SW_HIDE;
    startupInfo.hStdInput := rPipe;
    startupInfo.hStdOutput := wPipe;
    startupInfo.hStdError := ewPipe;

    jobObject := CreateJobObject(nil, PChar(Format('Global\%d', [GetCurrentProcessID])));
    if jobObject <> 0 then
    begin
      jobLimitInfo.BasicLimitInformation.LimitFlags := JOB_OBJECT_LIMIT_KILL_ON_JOB_CLOSE;
      SetInformationJobObject(JobObject, JobObjectExtendedLimitInformation, @jobLimitInfo, SizeOf(TJobObjectExtendedLimitInformation));
    end;

    if CreateProcess(nil, PChar(FCmd), @secAttr, @secAttr, True,   // !!!!
      CREATE_BREAKAWAY_FROM_JOB, nil, nil, startupInfo, FProcessInfo) then
    try
      if FProcessInfo.hProcess <> INVALID_HANDLE_VALUE then
        AssignProcessToJobObject(jobObject, FProcessInfo.hProcess);

      repeat
        dRun := WaitForSingleObject(FProcessInfo.hProcess, 100);
        PeekNamedPipe(erPipe, nil, 0, nil, @dAvail, nil);
        if (dAvail > 0) then
        repeat
          dRead := 0;
          ReadFile(erPipe, FReadBuf[0], bufSize, dRead, nil);
          FReadBuf[dRead] := #0;
          OemToCharA(FReadBuf, FReadBuf);
          Synchronize(SendLogMsg);
        until (dRead < bufSize);
      until (dRun <> WAIT_TIMEOUT);
    finally
      CloseHandle(FProcessInfo.hProcess);
      CloseHandle(FProcessInfo.hThread);
    end;
  finally
    CloseHandle(rPipe);
    CloseHandle(wPipe);
    CloseHandle(erPipe);
    CloseHandle(ewPipe);
  end;
end;

function TChildThread.GethProcess: TProcessInformation;
begin
  Result := FProcessInfo;
end;

procedure TChildThread.SendLogMsg;
begin
  FCallbackProc(string(FReadBuf));
end;

end.
