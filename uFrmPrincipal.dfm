object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Teste Delphi'
  ClientHeight = 280
  ClientWidth = 632
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mmMenu
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlResultado: TPanel
    Left = 0
    Top = 0
    Width = 633
    Height = 305
    TabOrder = 0
    object lblItens: TLabel
      Left = 8
      Top = 21
      Width = 133
      Height = 13
      Caption = 'Lista de Itens Cadastrados:'
    end
    object btnAtualizar: TButton
      Left = 8
      Top = 246
      Width = 75
      Height = 34
      Caption = 'A&tualizar'
      TabOrder = 0
      OnClick = btnAtualizarClick
    end
    object StringGrid1: TStringGrid
      Tag = 6
      Left = 8
      Top = 40
      Width = 512
      Height = 200
      ColCount = 6
      FixedCols = 0
      RowCount = 2
      TabOrder = 1
      ColWidths = (
        64
        64
        64
        64
        64
        64)
      RowHeights = (
        24
        24)
    end
  end
  object mmMenu: TMainMenu
    Left = 592
    Top = 8
    object mmCadastro: TMenuItem
      Caption = '&Cadastro'
      object mmProduto: TMenuItem
        Caption = '&Produto'
        OnClick = mmProdutoClick
      end
      object mmServico: TMenuItem
        Caption = '&Servi'#231'o'
        OnClick = mmServicoClick
      end
      object mmCategoria: TMenuItem
        Caption = '&Categoria'
        OnClick = mmCategoriaClick
      end
    end
  end
  object qryItens: TFDQuery
    Connection = dmCadastro.Connection
    SQL.Strings = (
      
        'select i.*, case when p.IdItem is null then '#39'Servi'#231'o'#39' else '#39'Prod' +
        'uto'#39' end '#39'Tipo Item'#39' '
      'from Item i'
      'left join Produto p on p.IdItem = i.Id'
      'left join Servico s on s.IdItem = i.Id')
    Left = 592
    Top = 56
    object qryItensId: TIntegerField
      FieldName = 'Id'
      Origin = 'Id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryItensCodigo: TStringField
      FieldName = 'Codigo'
      Origin = 'Codigo'
      Required = True
      Size = 50
    end
    object qryItensNome: TStringField
      FieldName = 'Nome'
      Origin = 'Nome'
      Required = True
      Size = 100
    end
    object qryItensDescricao: TStringField
      FieldName = 'Descricao'
      Origin = 'Descricao'
      Required = True
      Size = 200
    end
    object qryItensValorUnitario: TFloatField
      FieldName = 'ValorUnitario'
      Origin = 'ValorUnitario'
      Required = True
    end
    object qryItensTipoItem: TStringField
      FieldName = 'Tipo Item'
      Origin = '[Tipo Item]'
      ReadOnly = True
      Required = True
      Size = 7
    end
  end
  object BindSourceDB1: TBindSourceDB
    DataSet = qryItens
    ScopeMappings = <>
    Left = 592
    Top = 104
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 532
    Top = 13
    object LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource
      Category = 'Quick Bindings'
      DataSource = BindSourceDB1
      GridControl = StringGrid1
      Columns = <>
    end
  end
end
