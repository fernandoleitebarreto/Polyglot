object FrmDebug: TFrmDebug
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 211
  ClientWidth = 369
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 13
  object Label1: TLabel
    Left = 56
    Top = 88
    Width = 147
    Height = 25
    Caption = 'Servidor Ativo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Switch: TToggleSwitch
    Left = 240
    Top = 88
    Width = 72
    Height = 20
    State = tssOn
    TabOrder = 0
    OnClick = SwitchClick
  end
  object Button1: TButton
    Left = 262
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Send Email'
    TabOrder = 1
    OnClick = Button1Click
  end
  object edEmail: TEdit
    Left = 56
    Top = 130
    Width = 193
    Height = 21
    ImeName = 'Portuguese (Brazilian ABNT)'
    TabOrder = 2
    Text = 'fernando.leitebarreto@gmail.com'
  end
end
