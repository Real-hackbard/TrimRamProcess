unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, psAPI, XPMan, Spin;

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
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Label6: TLabel;
    Button1: TButton;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    StatusBar1: TStatusBar;
    CheckBox2: TCheckBox;
    SpinEdit1: TSpinEdit;
    Label10: TLabel;
    Label11: TLabel;
    Button2: TButton;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
function GetProcessMemorySize(_sProcessName: string; var _nMemSize: Cardinal): Boolean;
var
  l_nWndHandle, l_nProcID, l_nTmpHandle: HWND;
  l_pPMC: PPROCESS_MEMORY_COUNTERS;
  l_pPMCSize: Cardinal;
begin
  l_nWndHandle := FindWindow(nil, PChar(_sProcessName));
  if l_nWndHandle = 0 then
  begin
    Result := False;
    Exit;
  end;
  l_pPMCSize := SizeOf(PROCESS_MEMORY_COUNTERS);
  GetMem(l_pPMC, l_pPMCSize);
  l_pPMC^.cb := l_pPMCSize;
  GetWindowThreadProcessId(l_nWndHandle, @l_nProcID);
  l_nTmpHandle := OpenProcess(PROCESS_ALL_ACCESS, False, l_nProcID);
  if (GetProcessMemoryInfo(l_nTmpHandle, l_pPMC, l_pPMCSize)) then
    _nMemSize := l_pPMC^.WorkingSetSize
  else
    _nMemSize := 0;
  FreeMem(l_pPMC);
  Result := True;
end;

procedure TrimAppMemorySize;
 var
   MainHandle : THandle;
 begin
   try
     MainHandle := OpenProcess(PROCESS_ALL_ACCESS, false, GetCurrentProcessID) ;
     SetProcessWorkingSetSize(MainHandle, $FFFFFFFF, $FFFFFFFF) ;
     CloseHandle(MainHandle) ;
   except
   end;
   Application.ProcessMessages;
 end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  l_nSize: Cardinal;
begin
    if not (GetProcessMemorySize(Edit1.Text, l_nSize)) then begin
    CheckBox2.Checked := false;  CheckBox1.Checked := false;
    Timer1.Enabled := false;
    ProgressBar1.Position := 0; ProgressBar2.Position := 0;
    Label1.Caption := '0'; Label2.Caption := '0';
    Exit; end;

  if (GetProcessMemorySize(Edit1.Text, l_nSize)) then begin
    Label1.Caption := IntToStr(l_nSize);
    //Label2.Caption := IntToStr(l_nSize);
    Label9.Caption := IntToStr(l_nSize div 10000) + ' Kb';

    ProgressBar2.Max := StrToInt(Label2.Caption);
    ProgressBar2.Position := StrToInt(Label1.Caption);

    end else begin
    Label1.Caption := ('Error');
    end;

    if CheckBox1.Checked = true then begin
    TrimAppMemorySize;
    ProgressBar2.Position := StrToInt(Label1.Caption);
    Label1.Caption := IntToStr(l_nSize);
    Label9.Caption := IntToStr(l_nSize div 10000) + ' Kb';
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  l_nSize: Cardinal;
begin
  if (GetProcessMemorySize(Edit1.Text, l_nSize)) then begin
    Label2.Caption := IntToStr(l_nSize);
    Label8.Caption := IntToStr(l_nSize div 10000) + ' Kb';
    Label9.Caption := IntToStr(l_nSize div 10000) + ' Kb';
    ProgressBar1.Max := l_nSize;
    ProgressBar1.Position := l_nSize;
    end else begin
    Label1.Caption := ('Error');
    end;
    
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  l_nSize: Cardinal;
begin
    Label1.Caption := '0'; Label2.Caption := '0';

  if (GetProcessMemorySize(Edit1.Text, l_nSize)) then begin
    Label2.Caption := IntToStr(l_nSize);
    Label8.Caption := IntToStr(l_nSize div 10000) + ' Kb';
    Label9.Caption := IntToStr(l_nSize div 10000) + ' Kb';
    ProgressBar1.Max := l_nSize;
    ProgressBar1.Position := l_nSize;
    StatusBar1.SimpleText := 'Process is running...';
    end else begin
    //CheckBox1.Checked := false; CheckBox2.Checked := false;
    Label1.Caption := 'Error';
    Label2.Caption := '0';
    Label8.Caption := '0 Kb';
    Label9.Caption := '0 Kb';
    ProgressBar1.Position := 0; ProgressBar2.Position := 0;
    StatusBar1.SimpleText := 'Process not found...';
    end;
    StatusBar1.SetFocus;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
 if CheckBox2.Checked = true then begin
 Timer1.Enabled := true; Button1.Click;
 end else begin
 Timer1.Enabled := false;
 end;   StatusBar1.SetFocus;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  CheckBox2.Checked := false;
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
  Timer1.Interval := SpinEdit1.Value;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Timer1.Enabled := false;
  
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  Button1.Click;  
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  Button1.Click;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Button1.Click; StatusBar1.SetFocus;
end;

end.
