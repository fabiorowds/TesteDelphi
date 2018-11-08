unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Data.DB,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, uDmCadastro, Datasnap.DBClient,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.Bind.EngExt, Vcl.Bind.DBEngExt,
  Vcl.Bind.Grid, System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFrmPrincipal = class(TForm)
    mmMenu: TMainMenu;
    mmCadastro: TMenuItem;
    mmProduto: TMenuItem;
    mmServico: TMenuItem;
    mmCategoria: TMenuItem;
    pnlResultado: TPanel;
    btnAtualizar: TButton;
    StringGrid1: TStringGrid;
    qryItens: TFDQuery;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    lblItens: TLabel;
    qryItensId: TIntegerField;
    qryItensCodigo: TStringField;
    qryItensNome: TStringField;
    qryItensDescricao: TStringField;
    qryItensValorUnitario: TFloatField;
    qryItensTipoItem: TStringField;
    procedure mmCategoriaClick(Sender: TObject);
    procedure mmServicoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure mmProdutoClick(Sender: TObject);
  private
    { Private declarations }
    DmCadastro: TDmCadastro;
    procedure AtualizarItens;
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
  uFrmCadCategoria, uFrmCadServicos, uFrmCadProdutos;

{$R *.dfm}


procedure TFrmPrincipal.AtualizarItens;
begin
  qryItens.Active := false;
  qryItens.Active := true;
end;

procedure TFrmPrincipal.btnAtualizarClick(Sender: TObject);
begin
  AtualizarItens;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  DmCadastro := TdmCadastro.Create(Self);
  AtualizarItens;
end;

procedure TFrmPrincipal.mmCategoriaClick(Sender: TObject);
var
  frmCadCategoria: TFrmCadCategoria;
begin
  frmCadCategoria := TFrmCadCategoria.Create(Self);
  frmCadCategoria.ShowModal;
  AtualizarItens;
end;

procedure TFrmPrincipal.mmProdutoClick(Sender: TObject);
var
  frmCadProdutos: TFrmCadProdutos;
begin
  frmCadProdutos := TFrmCadProdutos.Create(Self);
  frmCadProdutos.ShowModal;
  AtualizarItens;
end;

procedure TFrmPrincipal.mmServicoClick(Sender: TObject);
var
  frmCadServicos: TFrmCadServicos;
begin
  frmCadServicos := TFrmCadServicos.Create(Self);
  frmCadServicos.ShowModal;
  AtualizarItens;
end;

end.
