unit Unit1;

interface

uses
  Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, Spin, Vcl.ExtCtrls, Vcl.StdCtrls,
  TLHelp32, Winapi.PsAPI;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ProgressBar1: TProgressBar;
    ProgressBar2: TProgressBar;
    Edit1: TEdit;
    Label6: TLabel;
    Button1: TButton;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    StatusBar1: TStatusBar;
    Label10: TLabel;
    Panel1: TPanel;
    ScrollBar1: TScrollBar;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    ComboBox1: TComboBox;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Timer2: TTimer;
    Label30: TLabel;
    Label31: TLabel;
    Panel2: TPanel;
    CheckBox1: TCheckBox;
    ProgressBar3: TProgressBar;
    ProgressBar4: TProgressBar;
    ProgressBar5: TProgressBar;
    ProgressBar6: TProgressBar;
    ProgressBar7: TProgressBar;
    ProgressBar8: TProgressBar;
    ProgressBar9: TProgressBar;
    ProgressBar10: TProgressBar;
    Timer3: TTimer;
    CheckBox2: TCheckBox;
    Label29: TLabel;
    Label32: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CheckBox1Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure DebugProcessStatus(s: string);
  end;

var
  Form1: TForm1;
  LastIdleTime, LastKernelTime, LastUserTime: TFileTime;
  LastPidCloneTime: Int64;
  LastProcessKernel: Int64;
  LastProcessUser: Int64;

type
  TMemoryStatusEx = packed record
    dwLength: DWORD;
    dwMemoryLoad: DWORD;
    ullTotalPhys: Int64;
    ullAvailPhys: Int64;
    ullTotalPageFile: Int64;
    ullAvailPageFile: Int64;
    ullTotalVirtual: Int64;
    ullAvailVirtual: Int64;
    ullAvailExtendedVirtual: Int64;
end;

implementation

{$R *.dfm}
// Determine the process utilization.
function GetProcessCPUUsage: Double;
var
  CreationTime, ExitTime, KernelTime, UserTime: TFileTime;
  NowTime: Int64;
  ProcKernel, ProcUser: Int64;
  TimePassed: Int64;
  SysInfo: TSystemInfo;
begin
  Result := 0.0;
  // Get the current system time in 100-nanosecond intervals.
  GetSystemTimeAsFileTime(TFileTime(NowTime));
  if GetProcessTimes(GetCurrentProcess, CreationTime, ExitTime, KernelTime, UserTime) then
  begin
    // calculate size
    ProcKernel := Int64(KernelTime) - LastProcessKernel;
    ProcUser   := Int64(UserTime) - LastProcessUser;
    TimePassed := NowTime - LastPidCloneTime;
    LastProcessKernel := Int64(KernelTime);
    LastProcessUser   := Int64(UserTime);
    LastPidCloneTime  := NowTime;
    if TimePassed > 0 then
    begin
      // Determining logical CPU cores for correct scaling
      GetSystemInfo(SysInfo);
      Result := ((ProcKernel + ProcUser) * 100.0) / TimePassed / SysInfo.dwNumberOfProcessors;
    end;
  end;
end;

// Determine the CPU usage for the entire system.
function GetCPUUsage: Double;
var
  IdleTime, KernelTime, UserTime: TFileTime;
  IdleDiff, KernelDiff, UserDiff: Int64;
  SysTime: Int64;
begin
  Result := 0.0;
  // class function used to retrieve the system-wide CPU execution times
  if GetSystemTimes(IdleTime, KernelTime, UserTime) then
  begin
    // Conversion of TFileTime structures into 64-bit integers
    IdleDiff   := Int64(IdleTime) - Int64(LastIdleTime);
    KernelDiff := Int64(KernelTime) - Int64(LastKernelTime);
    UserDiff   := Int64(UserTime) - Int64(LastUserTime);
    // Saving the current values ​​for the next measurement
    LastIdleTime   := IdleTime;
    LastKernelTime := KernelTime;
    LastUserTime   := UserTime;
    SysTime := KernelDiff + UserDiff;
    if SysTime > 0 then
    begin
      // Percentage calculation: (Total time - Idle time) / Total time
      Result := ((SysTime - IdleDiff) * 100.0) / SysTime;
      if Result < 0 then Result := 0.0;
    end;
  end;
end;

// Determine the process size in memory.
function GetProcessMemorySize(_sProcessName: string; var _nMemSize: Cardinal): Boolean;
var
  l_nWndHandle, l_nProcID, l_nTmpHandle: HWND;
  // to query detailed information about the memory usage of a specific process.
  l_pPMC: PPROCESS_MEMORY_COUNTERS;
  l_pPMCSize: Cardinal;
begin
  // search anf find the windows gui
  l_nWndHandle := FindWindow(nil, PChar(_sProcessName));
  if l_nWndHandle = 0 then
  begin
    Result := False;
    Exit;
  end;
  // Transmit the process information.
  l_pPMCSize := SizeOf(PROCESS_MEMORY_COUNTERS);
  // dynamic memory block and assigns the memory address to the pointer variable
  GetMem(l_pPMC, l_pPMCSize);
  // buffer size to the cb (Count of Bytes) member of a structure pointer.
  l_pPMC^.cb := l_pPMCSize;
  // retrieve the Process ID (PID) and Thread ID of a given window handle
  GetWindowThreadProcessId(l_nWndHandle, @l_nProcID);
  // open and transmit
  l_nTmpHandle := OpenProcess(PROCESS_ALL_ACCESS, False, l_nProcID);

  // transmit current working size
  if (GetProcessMemoryInfo(l_nTmpHandle, l_pPMC, l_pPMCSize)) then
    _nMemSize := l_pPMC^.WorkingSetSize
  else
    _nMemSize := 0;
  FreeMem(l_pPMC);
  Result := True;
end;

{ to obtain detailed information about physical and virtual memory,
  including compatibility with large-capacity configurations. }
function GlobalMemoryStatusEx(var lpBuffer: TMemoryStatusEx): BOOL; stdcall;
type
  TFNGlobalMemoryStatusEx = function(var msx: TMemoryStatusEx): BOOL; stdcall;
var
  FNGlobalMemoryStatusEx: TFNGlobalMemoryStatusEx;
begin
  // custom procedural type (function pointer) used to dynamically link
  // and call the Windows API function
  FNGlobalMemoryStatusEx := TFNGlobalMemoryStatusEx(
    GetProcAddress(GetModuleHandle(kernel32), 'GlobalMemoryStatusEx'));
  if not Assigned(FNGlobalMemoryStatusEx) then
  begin
    SetLastError(ERROR_CALL_NOT_IMPLEMENTED);
    Result := False;
  end
  else
    Result := FNGlobalMemoryStatusEx(lpBuffer);
end;

{ exact execution state of an application actively controlled
  by the integrated debugger }
procedure TForm1.DebugProcessStatus(s: string);
var
  pmc: PPROCESS_MEMORY_COUNTERS;
  cb: Integer;
  MemStat: tMemoryStatus;
  NewWorkingMemory, OldWorkingMemory : Longint;
  l_nSize: Cardinal;
  hProcess: THandle;
  ProcessID: DWORD;
  MyHandle: THandle;
  Struct: TProcessEntry32;
  Status: TMemoryStatusEx;
begin
  // returns the total memory size (in bytes)
  MemStat.dwLength := SizeOf(MemStat);
  // Retrieve system information regarding physical and virtual memory usage.
  GlobalMemoryStatus(MemStat);

  // Get the used memory for the current process
  cb := SizeOf(TProcessMemoryCounters);

  // transmit information
  GetMem(pmc, cb);
  pmc^.cb := cb;

  // transmission of the processed bytes and the lost ones
  if GetProcessMemoryInfo(GetCurrentProcess(), pmc, cb) then
  begin
    NewWorkingMemory           := Longint(pmc^.WorkingSetSize);
    Label27.Caption := FormatFloat('###,###', NewWorkingMemory / 1024) + ' bytes';
    Label28.Caption := FormatFloat('###,###', (NewWorkingMemory - OldWorkingMemory) / 1024) + ' bytes';
    OldWorkingMemory := NewWorkingMemory;
  end;

  // pass the bytes of the progress bars
  if (GetProcessMemorySize(Edit1.Text, l_nSize)) then
  begin
      Progressbar9.Max := l_nSize div 1000;
      Progressbar10.Max := l_nSize div 1000;
      Progressbar9.Position := (l_nSize div 1000) - (NewWorkingMemory div 1024);
      Progressbar10.Position := ((OldWorkingMemory) div 10000);
  end;
  // end PPROCESS_MEMORY_COUNTERS
  FreeMem(pmc);
end;

// Determine the process filename
function GetParentProcessFileName(PID : DWORD): String;
var
  HandleSnapShot      : THandle;
  EntryParentProc     : TProcessEntry32;
  HandleParentProc    : THandle;
  ParentPID           : DWORD;
  ParentProcessFound  : Boolean;
  ParentProcPath      : PChar;
begin
  ParentProcessFound := False;
  // To create a snapshot of the currently running processes, threads,
  // or modules in the Windows system.
  HandleSnapShot     := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  // measures, whereas Windows paths (MAX_PATH) are defined in characters and are imprecise
  GetMem(ParentProcPath, MAX_PATH);
  try
    if HandleSnapShot <> INVALID_HANDLE_VALUE then
    begin
      // pass the size
      EntryParentProc.dwSize := SizeOf(EntryParentProc);
      // to read the first element from a snapshot of the running processes
      if Process32First(HandleSnapShot, EntryParentProc) then
      begin
        repeat
          // contains the process ID (PID) of the process currently being checked in the loop
          if EntryParentProc.th32ProcessID = PID then
          begin
            ParentPID  := EntryParentProc.th32ParentProcessID;
            // Open and read the data, then the transmission.
            HandleParentProc  := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, False, ParentPID);
            ParentProcessFound:= HandleParentProc <> 0;
            if ParentProcessFound then
            begin
              // retrieve the full file path of an executable file or DLL of another process
                GetModuleFileNameEx(HandleParentProc, 0, PChar(ParentProcPath), MAX_PATH);
                ParentProcPath := PChar(ParentProcPath);
                CloseHandle(HandleParentProc);
            end;
            break;
          end;
          // to identify or monitor processes currently running on the system.
        until not Process32Next(HandleSnapShot, EntryParentProc);
      end;
      CloseHandle(HandleSnapShot);
    end;

    if ParentProcessFound then
      Result := ParentProcPath
    else
      Result := '';
  finally
      FreeMem(ParentProcPath);
  end;
end;

// To get a Process ID (PID) by its process name
function GetPIDbyProcessName(processName:String):integer;
var
  GotProcess: Boolean;
  tempHandle: tHandle;
  procE: tProcessEntry32;
begin
  // Snapshot of currently running processes
  tempHandle:=CreateToolHelp32SnapShot(TH32CS_SNAPALL, 0);
  procE.dwSize:=SizeOf(procE);
  // read the first entry of a process list (snapshot)
  GotProcess:=Process32First(tempHandle, procE);
  {$B-}
    if GotProcess and not SameText(procE.szExeFile, processName) then
      repeat
        // Iterate through the list of all running processes step by step.
        GotProcess := Process32Next(tempHandle, procE);
      until (not GotProcess) or SameText(procE.szExeFile,processName);
  {$B+}

  if GotProcess then
    result := procE.th32ProcessID
  else
    result := 0; // process not found in running process list

  CloseHandle(tempHandle);
end;

// Trim the process to the minimum possible size in RAM.
procedure TrimAppMemorySize;
 var
   MainHandle : THandle;
 begin
   try
     // open & read the process
     MainHandle := OpenProcess(PROCESS_ALL_ACCESS, false, GetCurrentProcessID);
     // Set minimum and maximum RAM amount (working set)
     SetProcessWorkingSetSize(MainHandle, $FFFFFFFF, $FFFFFFFF) ;
     CloseHandle(MainHandle) ;
   except
    on E: Exception do
      ShowMessage(E.Message);
   end;
   Application.ProcessMessages;
 end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  l_nSize: Cardinal;
  Status: TMemoryStatusEx;
begin
    if not (GetProcessMemorySize(Edit1.Text, l_nSize)) then
    begin
      CheckBox1.Checked := false;
      Timer1.Enabled := false;
      ProgressBar1.Position := 0;
      ProgressBar2.Position := 0;
      Label1.Caption := '0';
      Label2.Caption := '0';
      Exit;
    end;

  if (GetProcessMemorySize(Edit1.Text, l_nSize)) then
  begin
    Label1.Caption := IntToStr(l_nSize);
    //Label2.Caption := IntToStr(l_nSize);
    Label9.Caption := IntToStr(l_nSize div 10000) + ' Kb';
    ProgressBar2.Max := StrToInt(Label2.Caption);
    ProgressBar2.Position := StrToInt(Label1.Caption);
  end else begin
    Label1.Caption := ('Error');
  end;

  Status.dwLength := SizeOf(TMemoryStatusEx);
  GlobalMemoryStatusEx(Status);
  Label15.Caption := IntToStr(Status.ullTotalPhys) + ' bytes';
  Label16.Caption := IntToStr(Status.ullAvailPhys) + ' bytes';
  Label17.Caption := IntToStr(Status.ullTotalPageFile) + ' bytes';
  Label18.Caption := IntToStr(Status.ullAvailPageFile) + ' bytes';
  Label19.Caption := IntToStr(Status.ullTotalVirtual) + ' bytes';
  Label20.Caption := IntToStr(Status.ullAvailVirtual) + ' bytes';

  Progressbar3.Position := (Status.ullTotalPhys div 10000);
  Progressbar4.Position := (Status.ullAvailPhys div 10000);
  Progressbar5.Position := (Status.ullTotalPageFile div 10000);
  Progressbar6.Position := (Status.ullAvailPageFile div 10000);
  Progressbar7.Position := (Status.ullTotalVirtual div 10000);
  Progressbar8.Position := (Status.ullAvailVirtual div 10000);

  if CheckBox1.Checked = true then
  begin
    TrimAppMemorySize;
    ProgressBar2.Position := StrToInt(Label1.Caption);
    Label1.Caption := IntToStr(l_nSize);
    Label9.Caption := IntToStr(l_nSize div 10000) + ' Kb';
  end;

  DebugProcessStatus(Edit1.Text);
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var
  l_nSize: Cardinal;
  Status: TMemoryStatusEx;
begin
    if not (GetProcessMemorySize(Edit1.Text, l_nSize)) then
    begin
      CheckBox1.Checked := false;
      Timer1.Enabled := false;
      ProgressBar1.Position := 0;
      ProgressBar2.Position := 0;
      Label1.Caption := '0';
      Label2.Caption := '0';
      Exit;
    end;

  if (GetProcessMemorySize(Edit1.Text, l_nSize)) then
  begin
    Label2.Caption := IntToStr(l_nSize);
    Label8.Caption := IntToStr(l_nSize div 10000) + ' Kb';
    Label9.Caption := IntToStr(l_nSize div 10000) + ' Kb';
    ProgressBar1.Max := l_nSize;
    ProgressBar1.Position := l_nSize;
    ProgressBar2.Max := StrToInt(Label2.Caption);
    ProgressBar2.Position := StrToInt(Label2.Caption);
  end else begin
    Label1.Caption := ('Error');
  end;

  Status.dwLength := SizeOf(TMemoryStatusEx);
  GlobalMemoryStatusEx(Status);
  Label15.Caption := IntToStr(Status.ullTotalPhys) + ' bytes';
  Label16.Caption := IntToStr(Status.ullAvailPhys) + ' bytes';
  Label17.Caption := IntToStr(Status.ullTotalPageFile) + ' bytes';
  Label18.Caption := IntToStr(Status.ullAvailPageFile) + ' bytes';
  Label19.Caption := IntToStr(Status.ullTotalVirtual) + ' bytes';
  Label20.Caption := IntToStr(Status.ullAvailVirtual) + ' bytes';

  Progressbar3.Position := (Status.ullTotalPhys div 10000);
  Progressbar4.Position := (Status.ullAvailPhys div 10000);
  Progressbar5.Position := (Status.ullTotalPageFile div 10000);
  Progressbar6.Position := (Status.ullAvailPageFile div 10000);
  Progressbar7.Position := (Status.ullTotalVirtual div 10000);
  Progressbar8.Position := (Status.ullAvailVirtual div 10000);

  DebugProcessStatus(Edit1.Text);
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
  StatusBar1.Panels[4].Text := Format('%f MHz', [GetCPUUsage]);
  Label29.Caption := Format('%f MHz', [GetProcessCPUUsage]);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  hProcess: THandle;
  ProcessID: DWORD;
  MyHandle: THandle;
  Struct: TProcessEntry32;
  Status: TMemoryStatusEx;
begin
  StatusBar1.Panels[0].Text := 'Memory scan running..';
  DoubleBuffered := true;

  // Open the process handle with the required rights.
  hProcess := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, False, ProcessID);

  // get windows process pid
  Label12.Caption := IntToStr(GetPIDbyProcessName(Edit1.Text + '.exe'));

  // add ComboBox priority strings
  ComboBox1.Items.AddObject('Normal Priority', TObject(NORMAL_PRIORITY_CLASS));
  ComboBox1.Items.AddObject('Idle Priority', TObject(IDLE_PRIORITY_CLASS));
  ComboBox1.Items.AddObject('High Priority', TObject(HIGH_PRIORITY_CLASS));
  ComboBox1.ItemIndex := 0;

  // Overwrite the memory block with zeros (0).
  ZeroMemory(@Status, SizeOf(TMemoryStatusEx));
  Status.dwLength := SizeOf(TMemoryStatusEx);
  GlobalMemoryStatusEx(Status);
  Label15.Caption := IntToStr(Status.ullTotalPhys);
  Label16.Caption := IntToStr(Status.ullAvailPhys);
  Label17.Caption := IntToStr(Status.ullTotalPageFile);
  Label18.Caption := IntToStr(Status.ullAvailPageFile);
  Label19.Caption := IntToStr(Status.ullTotalVirtual);
  Label20.Caption := IntToStr(Status.ullAvailVirtual);

  Progressbar3.Max := (Status.ullTotalPhys div 10000);
  Progressbar4.Max := (Status.ullTotalPhys div 10000);
  Progressbar5.Max := (Status.ullTotalPageFile div 10000);
  Progressbar6.Max := (Status.ullTotalPageFile div 10000);
  Progressbar7.Max := (Status.ullTotalVirtual div 10000);
  Progressbar8.Max := (Status.ullTotalVirtual div 10000);

  Progressbar3.Position := (Status.ullTotalPhys div 10000);
  Progressbar4.Position := (Status.ullAvailPhys div 10000);
  Progressbar5.Position := (Status.ullTotalPageFile div 10000);
  Progressbar6.Position := (Status.ullAvailPageFile div 10000);
  Progressbar7.Position := (Status.ullTotalVirtual div 10000);
  Progressbar8.Position := (Status.ullAvailVirtual div 10000);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  l_nSize: Cardinal;
  Status: TMemoryStatusEx;
begin
  ZeroMemory(@Status, SizeOf(TMemoryStatusEx));
  if (GetProcessMemorySize(Edit1.Text, l_nSize)) then
  begin
      Label2.Caption := IntToStr(l_nSize);
      Label8.Caption := IntToStr(l_nSize div 10000) + ' kb';
      Label9.Caption := IntToStr(l_nSize div 10000) + ' kb';
      ProgressBar1.Max := l_nSize;
      ProgressBar1.Position := l_nSize;
      StatusBar1.Panels[0].Text := 'Memory scan running..';
  end else begin
      Label1.Caption := 'Error';
      Label2.Caption := '0';
      Label8.Caption := '0 kb';
      Label9.Caption := '0 kb';
      ProgressBar1.Position := 0;
      ProgressBar2.Position := 0;
      StatusBar1.Panels[0].Text := 'Memory scan stop.';
  end;
  Application.ProcessMessages;
  StatusBar1.SetFocus;
end;

// Set process priority
procedure TForm1.ComboBox1Select(Sender: TObject);
var
  PriorityClass: DWORD;
begin
  if ComboBox1.ItemIndex <> -1 then
  begin
    PriorityClass := DWORD(ComboBox1.Items.Objects[ComboBox1.ItemIndex]);
    SetPriorityClass(GetCurrentProcess, PriorityClass);
  end;
end;

// set the measurement speed
procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
  Timer1.Interval := ScrollBar1.Position;
  Timer2.Interval := ScrollBar1.Position;
  Timer3.Interval := ScrollBar1.Position;
  Label11.Caption := IntToStr(ScrollBar1.Position);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // end all measurement
  Timer1.Enabled := false;
  Timer2.Enabled := false;
  Timer3.Enabled := false;
end;

// start stop trim
procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked = true then
  begin
    CheckBox2.Checked := false;
    Timer1.Enabled := true;
    Timer2.Enabled := false;
    StatusBar1.Panels[2].Text := 'run';
  end else begin
    Timer1.Enabled := false;
    Timer2.Enabled := true;
    StatusBar1.Panels[2].Text := 'stop';
  end;
end;

// stop and run all measurement
procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.Checked = true then
  begin
    CheckBox1.Checked := false;
    Timer1.Enabled := false;
    Timer2.Enabled := false;
    Timer3.Enabled := false;
    StatusBar1.Panels[0].Text := 'Memory scan stop.';
  end else begin
    Timer2.Enabled := true;
    Timer3.Enabled := true;
    StatusBar1.Panels[0].Text := 'Memory scan running..';
  end;
end;

end.
