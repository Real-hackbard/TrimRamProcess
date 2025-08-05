object Form1: TForm1
  Left = 1758
  Top = 326
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Process Memory Trimmer 1.0'
  ClientHeight = 384
  ClientWidth = 527
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 13
  object Label1: TLabel
    Left = 128
    Top = 96
    Width = 6
    Height = 13
    Caption = #223
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 128
    Top = 112
    Width = 6
    Height = 13
    Caption = #223
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 40
    Top = 96
    Width = 78
    Height = 13
    Caption = 'Trim Size (byte) :'
  end
  object Label4: TLabel
    Left = 25
    Top = 112
    Width = 93
    Height = 13
    Caption = 'Original Size (byte) :'
  end
  object Label5: TLabel
    Left = 24
    Top = 232
    Width = 93
    Height = 13
    Caption = 'Original Size (byte) :'
  end
  object Label6: TLabel
    Left = 72
    Top = 52
    Width = 44
    Height = 13
    Caption = 'Process :'
  end
  object Label7: TLabel
    Left = 39
    Top = 266
    Width = 78
    Height = 13
    Caption = 'Trim Size (byte) :'
  end
  object Label8: TLabel
    Left = 456
    Top = 234
    Width = 21
    Height = 13
    Caption = '0 kb'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 456
    Top = 266
    Width = 21
    Height = 13
    Caption = '0 kb'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label10: TLabel
    Left = 56
    Top = 189
    Width = 59
    Height = 13
    Caption = 'Speed (ms) :'
  end
  object Label11: TLabel
    Left = 8
    Top = 8
    Width = 497
    Height = 20
    Caption = 'This is an example of trimming a process at runtime to minimal'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ProgressBar1: TProgressBar
    Left = 128
    Top = 232
    Width = 313
    Height = 17
    TabOrder = 0
  end
  object ProgressBar2: TProgressBar
    Left = 128
    Top = 264
    Width = 313
    Height = 17
    TabOrder = 1
  end
  object CheckBox1: TCheckBox
    Left = 396
    Top = 320
    Width = 81
    Height = 17
    TabStop = False
    Caption = 'Trim Memory'
    TabOrder = 2
    OnClick = CheckBox1Click
  end
  object Edit1: TEdit
    Left = 128
    Top = 48
    Width = 249
    Height = 21
    TabStop = False
    TabOrder = 3
    Text = 'Project1'
    OnChange = Edit1Change
  end
  object Button1: TButton
    Left = 376
    Top = 46
    Width = 75
    Height = 25
    Caption = 'Refresh'
    TabOrder = 4
    TabStop = False
    OnClick = Button1Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 365
    Width = 527
    Height = 19
    Panels = <>
    SimplePanel = True
    ExplicitTop = 290
    ExplicitWidth = 543
  end
  object CheckBox2: TCheckBox
    Left = 128
    Top = 160
    Width = 65
    Height = 17
    TabStop = False
    Caption = 'Activate'
    Checked = True
    State = cbChecked
    TabOrder = 6
    OnClick = CheckBox2Click
  end
  object SpinEdit1: TSpinEdit
    Left = 128
    Top = 184
    Width = 121
    Height = 22
    TabStop = False
    MaxValue = 0
    MinValue = 0
    TabOrder = 7
    Value = 100
    OnChange = SpinEdit1Change
  end
  object Button2: TButton
    Left = 280
    Top = 111
    Width = 97
    Height = 17
    Caption = 'Refresh Size'
    TabOrder = 8
    OnClick = Button2Click
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 448
    Top = 128
  end
end
