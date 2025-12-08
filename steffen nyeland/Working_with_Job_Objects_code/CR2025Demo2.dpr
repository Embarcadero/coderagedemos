program CR2025Demo2;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Winapi.Windows;

begin
  try
    if ParamCount<1 then
      Halt(1);

    var hJob := CreateJobObject(nil, 'MyJobObject');
    if hJob=0 then
      Halt(1);

    var pid := ParamStr(1).ToInteger;
    var hProcess := OpenProcess(PROCESS_SET_QUOTA or PROCESS_TERMINATE, False, pid);
    if hProcess=0 then
      Halt(1);

    if not AssignProcessToJobObject(hJob, hProcess) then
      Halt(1);

    var info: TJobObjectBasicLimitInformation;
    info.ActiveProcessLimit := 2;
    info.LimitFlags := JOB_OBJECT_LIMIT_ACTIVE_PROCESS;

    if not SetInformationJobObject(hJob, JobObjectBasicLimitInformation, @info, SizeOf(info)) then
      Halt(1);

    var info2: TJobObjectCPURateControlInformation;
    info2.CpuRate := 1000; // 10.00 %
    info2.ControlFlags := JOB_OBJECT_CPU_RATE_CONTROL_ENABLE or JOB_OBJECT_CPU_RATE_CONTROL_HARD_CAP;

    if not SetInformationJobObject(hJob, JobObjectCpuRateControlInformation, @info2, SizeOf(info2)) then
      Halt(1);

    WriteLn('Success!');
    Sleep(INFINITE);

    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
