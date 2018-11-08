unit uFrmCadServicos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, uDmCadastro;

type
  TFrmCadServicos = class(TForm)
    pnlCampos: TPanel;
    grpDados: TGroupBox;
    lblCodigo: TLabel;
    lblNome: TLabel;
    lblDescricao: TLabel;
    lblVlrUnitario: TLabel;
    lblCodigoServico: TLabel;
    edtCodigo: TEdit;
    edtNome: TEdit;
    edtDescricao: TEdit;
    edtVlrUnitario: TEdit;
    edtCodigoServico: TEdit;
    grpAcesso: TGroupBox;
    lblId: TLabel;
    lblStatus: TLabel;
    edtId: TEdit;
    pnlBotoes: TPanel;
    btnGravar: TButton;
    btnCancelar: TButton;
    btnExcluir: TButton;
    btnFechar: TButton;
    lblCategoria: TLabel;
    edtCategoria: TEdit;
    lblDscCategoria: TLabel;
    procedure FormShow(Sender: TObject);
    procedure edtIdKeyPress(Sender: TObject; var Key: Char);
    procedure edtVlrUnitarioKeyPress(Sender: TObject; var Key: Char);
    procedure btnFecharClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtCategoriaExit(Sender: TObject);
    procedure grpDadosEnter(Sender: TObject);
    procedure edtCategoriaKeyPress(Sender: TObject; var Key: Char);
  private
    function RetornarProximoId: integer;
    function ValidarCampos: boolean;
    procedure Cancelar;
    procedure Gravar;
    procedure ValidarId;
    procedure Excluir;
  public
    { Public declarations }
  end;

var
  FrmCadServicos: TFrmCadServicos;
  dmCadastro: TDmCadastro;

implementation

uses
  uServico, uCategoria, uProduto;


{$R *.dfm}

{ TFrmCadServicos }

procedure TFrmCadServicos.btnCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TFrmCadServicos.btnExcluirClick(Sender: TObject);
begin
  Excluir;
end;

procedure TFrmCadServicos.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCadServicos.btnGravarClick(Sender: TObject);
begin
  Gravar;
end;

procedure TFrmCadServicos.Cancelar;
begin
  // Método que retorna a tela para o estado inicial.
  edtId.Text := IntToStr(RetornarProximoId);
  edtCodigo.Text := '';
  edtNome.Text := '';
  edtDescricao.Text := '';
  edtVlrUnitario.Text := '';
  edtCodigoServico.Text := '';
  edtCategoria.Text := '';
  lblDscCategoria.Caption := '';
  grpAcesso.Enabled := true;
  lblStatus.Caption := 'Novo';
  btnGravar.Enabled := false;
  btnExcluir.Enabled := false;
  edtId.SetFocus;
end;

procedure TFrmCadServicos.edtCategoriaExit(Sender: TObject);
var
  Categoria: TCategoria;
begin
  if Trim(edtCategoria.Text) = '' then
  begin
    {ShowMessage('Deve ser informada uma categoria.');
    lblDscCategoria.Caption := '';
    edtCategoria.SetFocus;}
    exit;
  end;
  Categoria := TCategoria.Create;
  Categoria.Consultar(StrToInt(edtCategoria.Text));

  if Categoria.getId = 0 then
  begin
    ShowMessage('A categoria informada não foi encontrada.');
    lblDscCategoria.Caption := '';
    edtCategoria.Text := '';
    edtCategoria.SetFocus;
    exit;
  end;

  lblDscCategoria.Caption := Categoria.getNome;
end;

procedure TFrmCadServicos.edtCategoriaKeyPress(Sender: TObject; var Key: Char);
begin
  //Validação para o campo Categoria não aceitar caracteres invalidos.
  If not( key in['0'..'9',#08] ) then
    key:=#0;
end;

procedure TFrmCadServicos.edtIdKeyPress(Sender: TObject; var Key: Char);
begin
  //Validação para o campo Id não aceitar caracteres invalidos.
  If not( key in['0'..'9',#08] ) then
    key:=#0;
end;

procedure TFrmCadServicos.edtVlrUnitarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  //Validação para o campo Valor Unitário não aceitar caracteres invalidos.
  If not( key in['0'..'9',',',#08] ) then
    key:=#0;
end;

procedure TFrmCadServicos.Excluir;
var
  Servico: TServico;
begin
  if lblStatus.Caption = 'Alteração' then
  begin
    if MessageDlg('Deseja realmente remover o serviço selecionado?',mtConfirmation, mbYesNo,0 ) = mrYes then
    begin
      Servico := TServico.Create;
      Servico.Consultar(StrToInt(edtId.Text));
      Servico.Excluir();
      ShowMessage('Serviço removido com sucesso.');
      Cancelar;
    end;
  end;
end;

procedure TFrmCadServicos.FormShow(Sender: TObject);
begin
  dmCadastro := TdmCadastro.Create(Self);
  Cancelar;
end;

procedure TFrmCadServicos.Gravar;
var
  Servico: TServico;
  Categoria: TCategoria;
begin
  if ValidarCampos then
  begin
    Servico := TServico.Create;
    Servico.setId(StrToInt(edtId.Text));
    Servico.setCodigo(edtCodigo.Text);
    Servico.setNome(edtNome.Text);
    Servico.setDescricao(edtDescricao.Text);
    Servico.setValorUnitario(StrToFloat(edtVlrUnitario.Text));
    Servico.setCodigoServico(edtCodigoServico.Text);
    Categoria := TCategoria.Create;
    Categoria.Consultar(StrToInt(edtCategoria.Text));
    Servico.setCategoria(Categoria);
    Servico.Gravar;
    ShowMessage('Serviço gravado com sucesso.');
    Cancelar;
  end;
end;

procedure TFrmCadServicos.grpDadosEnter(Sender: TObject);
begin
  ValidarId;
end;

function TFrmCadServicos.RetornarProximoId: integer;
begin
  //Método que busca no banco de dados o proximo Id disponível e preenche o campo preperando para um novo registro.
  DmCadastro.qryPesquisa.Close;
  DmCadastro.qryPesquisa.SQL.Text := 'select Coalesce(max(Id),0) + 1 prox_codigo from Item';
  DmCadastro.qryPesquisa.Open();

  Result := DmCadastro.qryPesquisa.FieldByName('prox_codigo').AsInteger;
end;

function TFrmCadServicos.ValidarCampos: boolean;
var
  Categoria: TCategoria;
begin
  //Método que valida se os campos da tela estão preenchidos antes de seguir com o cadastro.
  Result := true;

  if Trim(edtCodigo.Text) = '' then
  begin
    ShowMessage('Deve ser informado um código.');
    edtCodigo.SetFocus;
    Result := false;
    Exit;
  end;

  if Trim(edtNome.Text) = '' then
  begin
    ShowMessage('Deve ser informado um nome.');
    edtNome.SetFocus;
    Result := false;
    Exit;
  end;

  if Trim(edtDescricao.Text) = '' then
  begin
    ShowMessage('Deve ser informado uma descrição.');
    edtDescricao.SetFocus;
    Result := false;
    Exit;
  end;

  if Trim(edtVlrUnitario.Text) = '' then
  begin
    ShowMessage('Deve ser informado um valor unitário.');
    edtVlrUnitario.SetFocus;
    Result := false;
    Exit;
  end;

  if Trim(edtCodigoServico.Text) = '' then
  begin
    ShowMessage('Deve ser informado um código de serviço.');
    edtCodigoServico.SetFocus;
    Result := false;
    Exit;
  end;

  if Trim(edtCategoria.Text) = '' then
  begin
    ShowMessage('Deve ser informado uma categoria.');
    edtCategoria.SetFocus;
    Result := false;
    Exit;
  end else
  begin
    Categoria := TCategoria.Create;
    Categoria.Consultar(StrToInt(edtCategoria.Text));
    if Categoria.getId = 0 then
    begin
      ShowMessage('A categoria informada não foi encontrada.');
      edtCategoria.SetFocus;
      Result := false;
      Exit;
    end;
  end;
end;

procedure TFrmCadServicos.ValidarId;
var
  Servico: TServico;
  Produto: TProduto;
begin
  // Valida se foi informado um ID de categoria e caso esteja informado, verifica se é um registro cadastrado ou se será cadastrado um novo registro.
  if Trim(edtId.Text) = '' then
  begin
    //Se não for informado um ID mostra mensagem de validação e volta o foco para o campo.
    ShowMessage('Deve ser informado um Id para realizar o cadastro.');
    edtId.SetFocus;
    exit;
  end;

  if StrToInt(edtId.Text) <= 0 then
  begin
    //Se não for informado um ID mostra mensagem de validação e volta o foco para o campo.
    ShowMessage('Deve ser informado um Id maior que zero para realizar o cadastro.');
    edtId.SetFocus;
    exit;
  end;

  Servico := TServico.Create;
  Servico.Consultar(StrToInt(edtId.Text));


  if Servico.getId = 0 then
  begin
    Produto := TProduto.Create;
    Produto.Consultar(StrToInt(edtId.Text));

    if Produto.getId > 0 then
    begin
      ShowMessage('O Id informado é de um produto e não pode ser utilizado na tela de cadastro de serviços.');
      edtId.SetFocus;
      exit;
    end;

    lblStatus.Caption := 'Novo';
  end else
  begin
    lblStatus.Caption := 'Alteração';
    edtCodigo.Text := Servico.getCodigo;
    edtNome.Text := Servico.getNome;
    edtDescricao.Text := Servico.getDescricao;
    edtVlrUnitario.Text := FloatToStr(Servico.getValorUnitario);
    edtCodigoServico.Text := Servico.getCodigoServico;
    edtCategoria.Text := IntToStr(Servico.getCategoria.getId);
    lblDscCategoria.Caption := Servico.getCategoria.getNome;
    //Em caso de alteração habilita o botão de exclusão.
    btnExcluir.Enabled := true;
  end;

  grpAcesso.Enabled := false;
  btnGravar.Enabled := true;
  edtCodigo.SetFocus;
end;

end.
