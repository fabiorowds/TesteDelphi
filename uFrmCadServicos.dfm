object FrmCadServicos: TFrmCadServicos
  Left = 0
  Top = 0
  Caption = 'Cadastro de Servi'#231'os'
  ClientHeight = 321
  ClientWidth = 481
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlCampos: TPanel
    Left = 0
    Top = 0
    Width = 481
    Height = 249
    TabOrder = 0
    object grpDados: TGroupBox
      Left = 6
      Top = 57
      Width = 469
      Height = 185
      TabOrder = 1
      OnEnter = grpDadosEnter
      object lblCodigo: TLabel
        Left = 45
        Top = 17
        Width = 33
        Height = 13
        Caption = 'C'#243'digo'
      end
      object lblNome: TLabel
        Left = 51
        Top = 44
        Width = 27
        Height = 13
        Caption = 'Nome'
      end
      object lblDescricao: TLabel
        Left = 32
        Top = 71
        Width = 46
        Height = 13
        Caption = 'Descri'#231#227'o'
      end
      object lblVlrUnitario: TLabel
        Left = 14
        Top = 98
        Width = 64
        Height = 13
        Caption = 'Valor Unit'#225'rio'
      end
      object lblCodigoServico: TLabel
        Left = 7
        Top = 125
        Width = 71
        Height = 13
        Caption = 'C'#243'digo Servi'#231'o'
      end
      object lblCategoria: TLabel
        Left = 31
        Top = 152
        Width = 47
        Height = 13
        Caption = 'Categoria'
      end
      object lblDscCategoria: TLabel
        Left = 155
        Top = 152
        Width = 3
        Height = 13
      end
      object edtCodigo: TEdit
        Left = 84
        Top = 14
        Width = 65
        Height = 21
        TabOrder = 0
      end
      object edtNome: TEdit
        Left = 84
        Top = 41
        Width = 301
        Height = 21
        TabOrder = 1
      end
      object edtDescricao: TEdit
        Left = 84
        Top = 68
        Width = 301
        Height = 21
        TabOrder = 2
      end
      object edtVlrUnitario: TEdit
        Left = 84
        Top = 95
        Width = 65
        Height = 21
        TabOrder = 3
        OnKeyPress = edtVlrUnitarioKeyPress
      end
      object edtCodigoServico: TEdit
        Left = 84
        Top = 122
        Width = 65
        Height = 21
        TabOrder = 4
      end
      object edtCategoria: TEdit
        Left = 84
        Top = 149
        Width = 65
        Height = 21
        TabOrder = 5
        OnExit = edtCategoriaExit
        OnKeyPress = edtCategoriaKeyPress
      end
    end
    object grpAcesso: TGroupBox
      Left = 6
      Top = 6
      Width = 469
      Height = 49
      TabOrder = 0
      object lblId: TLabel
        Left = 68
        Top = 16
        Width = 10
        Height = 13
        Caption = 'Id'
      end
      object lblStatus: TLabel
        Left = 395
        Top = 16
        Width = 25
        Height = 13
        Caption = 'Novo'
      end
      object edtId: TEdit
        Left = 84
        Top = 13
        Width = 65
        Height = 21
        TabOrder = 0
        OnKeyPress = edtIdKeyPress
      end
    end
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 248
    Width = 481
    Height = 73
    TabOrder = 1
    object btnGravar: TButton
      Left = 6
      Top = 7
      Width = 89
      Height = 58
      Caption = '&Gravar'
      Enabled = False
      TabOrder = 0
      OnClick = btnGravarClick
    end
    object btnCancelar: TButton
      Left = 101
      Top = 7
      Width = 89
      Height = 58
      Caption = '&Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
    object btnExcluir: TButton
      Left = 196
      Top = 7
      Width = 89
      Height = 58
      Caption = '&Excluir'
      Enabled = False
      TabOrder = 2
      OnClick = btnExcluirClick
    end
    object btnFechar: TButton
      Left = 291
      Top = 7
      Width = 89
      Height = 58
      Caption = '&Fechar'
      TabOrder = 3
      OnClick = btnFecharClick
    end
  end
end
