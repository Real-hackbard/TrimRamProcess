object Form1: TForm1
  Left = 1758
  Top = 326
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Process Memory Trimmer'
  ClientHeight = 564
  ClientWidth = 507
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 13
  object Label1: TLabel
    Left = 128
    Top = 112
    Width = 6
    Height = 13
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clTeal
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 128
    Top = 131
    Width = 6
    Height = 13
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 44
    Top = 112
    Width = 78
    Height = 13
    Caption = 'Trim Size (byte) :'
  end
  object Label4: TLabel
    Left = 29
    Top = 131
    Width = 93
    Height = 13
    Caption = 'Original Size (byte) :'
  end
  object Label5: TLabel
    Left = 29
    Top = 437
    Width = 93
    Height = 13
    Caption = 'Original Size (byte) :'
  end
  object Label6: TLabel
    Left = 78
    Top = 83
    Width = 44
    Height = 13
    Caption = 'Process :'
  end
  object Label7: TLabel
    Left = 44
    Top = 469
    Width = 78
    Height = 13
    Caption = 'Trim Size (byte) :'
  end
  object Label8: TLabel
    Left = 447
    Top = 437
    Width = 21
    Height = 13
    Caption = '0 kb'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 447
    Top = 469
    Width = 21
    Height = 13
    Caption = '0 kb'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clTeal
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label10: TLabel
    Left = 63
    Top = 400
    Width = 59
    Height = 13
    Caption = 'Speed (ms) :'
  end
  object Label11: TLabel
    Left = 383
    Top = 400
    Width = 12
    Height = 13
    Caption = '25'
  end
  object Label12: TLabel
    Left = 128
    Top = 150
    Width = 6
    Height = 13
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label13: TLabel
    Left = 98
    Top = 150
    Width = 24
    Height = 13
    Caption = 'PID :'
  end
  object Label14: TLabel
    Left = 66
    Top = 191
    Width = 56
    Height = 13
    Caption = 'Set Priority :'
  end
  object Label15: TLabel
    Left = 128
    Top = 227
    Width = 38
    Height = 13
    Caption = 'Label15'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label16: TLabel
    Left = 128
    Top = 246
    Width = 38
    Height = 13
    Caption = 'Label16'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label17: TLabel
    Left = 128
    Top = 265
    Width = 38
    Height = 13
    Caption = 'Label17'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label18: TLabel
    Left = 128
    Top = 284
    Width = 38
    Height = 13
    Caption = 'Label18'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label19: TLabel
    Left = 128
    Top = 303
    Width = 38
    Height = 13
    Caption = 'Label19'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label20: TLabel
    Left = 128
    Top = 322
    Width = 38
    Height = 13
    Caption = 'Label20'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label21: TLabel
    Left = 65
    Top = 227
    Width = 57
    Height = 13
    Caption = 'Total RAM :'
  end
  object Label22: TLabel
    Left = 46
    Top = 246
    Width = 76
    Height = 13
    Caption = 'Available RAM :'
  end
  object Label23: TLabel
    Left = 51
    Top = 265
    Width = 71
    Height = 13
    Caption = 'Total Pagefile :'
  end
  object Label24: TLabel
    Left = 33
    Top = 284
    Width = 89
    Height = 13
    Caption = 'Available pagefile :'
  end
  object Label25: TLabel
    Left = 58
    Top = 303
    Width = 64
    Height = 13
    Caption = 'Total Virtuell :'
  end
  object Label26: TLabel
    Left = 34
    Top = 322
    Width = 88
    Height = 13
    Caption = 'Virtually Available :'
  end
  object Label27: TLabel
    Left = 128
    Top = 341
    Width = 38
    Height = 13
    Caption = 'Label27'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label28: TLabel
    Left = 128
    Top = 360
    Width = 38
    Height = 13
    Caption = 'Label28'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label30: TLabel
    Left = 98
    Top = 341
    Width = 24
    Height = 13
    Caption = 'Edit :'
  end
  object Label31: TLabel
    Left = 65
    Top = 360
    Width = 57
    Height = 13
    Caption = 'Loss (leak) :'
  end
  object Label29: TLabel
    Left = 128
    Top = 169
    Width = 44
    Height = 13
    Caption = '0,00 Mhz'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label32: TLabel
    Left = 41
    Top = 169
    Width = 81
    Height = 13
    Caption = 'Current Process :'
  end
  object ProgressBar1: TProgressBar
    Left = 128
    Top = 435
    Width = 313
    Height = 17
    TabOrder = 0
  end
  object ProgressBar2: TProgressBar
    Left = 128
    Top = 467
    Width = 313
    Height = 17
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 128
    Top = 80
    Width = 249
    Height = 21
    TabStop = False
    TabOrder = 2
    Text = 'Project1'
  end
  object Button1: TButton
    Left = 383
    Top = 80
    Width = 75
    Height = 22
    Caption = 'Refresh'
    TabOrder = 3
    TabStop = False
    OnClick = Button1Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 545
    Width = 507
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Text = 'Trim :'
        Width = 40
      end
      item
        Text = 'stop'
        Width = 150
      end
      item
        Text = 'CPU :'
        Width = 40
      end
      item
        Width = 50
      end>
    ExplicitTop = 544
    ExplicitWidth = 503
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 507
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Process Memory Trimmer'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Impact'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    ExplicitWidth = 503
  end
  object ScrollBar1: TScrollBar
    Left = 128
    Top = 400
    Width = 249
    Height = 13
    Max = 1000
    Min = 1
    PageSize = 0
    Position = 25
    TabOrder = 6
    OnChange = ScrollBar1Change
  end
  object ComboBox1: TComboBox
    Left = 128
    Top = 188
    Width = 113
    Height = 21
    Style = csDropDownList
    TabOrder = 7
    OnSelect = ComboBox1Select
  end
  object Panel2: TPanel
    Left = 200
    Top = 498
    Width = 241
    Height = 33
    TabOrder = 8
    object CheckBox1: TCheckBox
      Left = 122
      Top = 8
      Width = 109
      Height = 17
      TabStop = False
      Caption = 'Start Trim Memory'
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object CheckBox2: TCheckBox
      Left = 11
      Top = 8
      Width = 91
      Height = 17
      Caption = 'Complete stop'
      TabOrder = 1
      OnClick = CheckBox2Click
    end
  end
  object ProgressBar3: TProgressBar
    Left = 273
    Top = 230
    Width = 168
    Height = 10
    TabOrder = 9
  end
  object ProgressBar4: TProgressBar
    Left = 273
    Top = 249
    Width = 168
    Height = 10
    TabOrder = 10
  end
  object ProgressBar5: TProgressBar
    Left = 273
    Top = 268
    Width = 168
    Height = 10
    TabOrder = 11
  end
  object ProgressBar6: TProgressBar
    Left = 273
    Top = 287
    Width = 168
    Height = 10
    TabOrder = 12
  end
  object ProgressBar7: TProgressBar
    Left = 273
    Top = 306
    Width = 168
    Height = 10
    TabOrder = 13
  end
  object ProgressBar8: TProgressBar
    Left = 273
    Top = 325
    Width = 168
    Height = 10
    TabOrder = 14
  end
  object ProgressBar9: TProgressBar
    Left = 273
    Top = 344
    Width = 168
    Height = 10
    TabOrder = 15
  end
  object ProgressBar10: TProgressBar
    Left = 273
    Top = 363
    Width = 168
    Height = 10
    TabOrder = 16
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 312
    Top = 120
  end
  object Timer2: TTimer
    Interval = 300
    OnTimer = Timer2Timer
    Left = 368
    Top = 120
  end
  object Timer3: TTimer
    Interval = 200
    OnTimer = Timer3Timer
    Left = 424
    Top = 120
  end
end
