unit uFrmCadProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  uDmCadastro;

type
  TFrmCadProdutos = class(TForm)
    pnlCampos: TPanel;
    pnlBotoes: TPanel;
    btnGravar: TButton;
    btnCancelar: TButton;
    btnExcluir: TButton;
    btnFechar: TButton;
    grpAcesso: TGroupBox;
    lblId: TLabel;
    edtId: TEdit;
    lblStatus: TLabel;
    grpDados: TGroupBox;
    lblCodigo: TLabel;
    edtCodigo: TEdit;
    lblNome: TLabel;
    edtNome: TEdit;
    lblDescricao: TLabel;
    edtDescricao: TEdit;
    lblVlrUnitario: TLabel;
    lblPeso: TLabel;
    edtPeso: TEdit;
    lblAltura: TLabel;
    edtVlrUnitario: TEdit;
    edtAltura: TEdit;
    procedure FormShow(Sender: TObject);
    procedure edtVlrUnitarioKeyPress(Sender: TObject; var Key: Char);
    procedure edtPesoKeyPress(Sender: TObject; var Key: Char);
    procedure edtAlturaKeyPress(Sender: TObject; var Key: Char);
    procedure grpDadosEnter(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtIdKeyPress(Sender: TObject; var Key: Char);
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
  FrmCadProdutos: TFrmCadProdutos;
  DmCadastro: TDmCadastro;

implementation

uses
  uProduto, uServico;

{$R *.dfm}

{ TFrmCadProdutos }

procedure TFrmCadProdutos.btnCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TFrmCadProdutos.btnExcluirClick(Sender: TObject);
begin
  Excluir;
end;

procedure TFrmCadProdutos.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCadProdutos.btnGravarClick(Sender: TObject);
begin
  Gravar;
end;

procedure TFrmCadProdutos.Cancelar;
begin
  // M�todo que retorna a tela para o estado inicial.
  edtId.Text := IntToStr(RetornarProximoId);
  edtCodigo.Text := '';
  edtNome.Text := '';
  edtDescricao.Text := '';
  edtVlrUnitario.Text := '';
  edtPeso.Text := '';
  edtAltura.Text := '';
  grpAcesso.Enabled := true;
  lblStatus.Caption := 'Novo';
  btnGravar.Enabled := false;
  btnExcluir.Enabled := false;
  edtId.SetFocus;
end;

procedure TFrmCadProdutos.edtAlturaKeyPress(Sender: TObject; var Key: Char);
begin
  //Valida��o para o campo altura n�o aceitar caracteres invalidos.
  If not( key in['0'..'9',',',#08] ) then
    key:=#0;
end;

procedure TFrmCadProdutos.edtIdKeyPress(Sender: TObject; var Key: Char);
begin
  //Valida��o para o campo Id n�o aceitar caracteres invalidos.
  If not( key in['0'..'9',#08] ) then
    key:=#0;
end;

procedure TFrmCadProdutos.edtPesoKeyPress(Sender: TObject; var Key: Char);
begin
  //Valida��o para o campo peso n�o aceitar caracteres invalidos.
  If not( key in['0'..'9',',',#08] ) then
    key:=#0;
end;

procedure TFrmCadProdutos.edtVlrUnitarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  //Valida��o para o campo Valor Unit�rio n�o aceitar caracteres invalidos.
  If not( key in['0'..'9',',',#08] ) then
    key:=#0;
end;

procedure TFrmCadProdutos.Excluir;
var
  Produto: TProduto;
begin
  if lblStatus.Caption = 'Altera��o' then
  begin
    if MessageDlg('Deseja realmente remover o servi�o selecionado?',mtConfirmation, mbYesNo,0 ) = mrYes then
    begin
      Produto := TProduto.Create;
      Produto.Consultar(StrToInt(edtId.Text));
      Produto.Excluir();
      ShowMessage('Servi�o removido com sucesso.');
      Cancelar;
    end;
  end;
end;

procedure TFrmCadProdutos.FormShow(Sender: TObject);
begin
  DmCadastro := TdmCadastro.Create(Self);
  Cancelar;
end;

procedure TFrmCadProdutos.Gravar;
var
  Produto: TProduto;
begin
  if ValidarCampos then
  begin
    Produto := TProduto.Create;
    Produto.setId(StrToInt(edtId.Text));
    Produto.setCodigo(edtCodigo.Text);
    Produto.setNome(edtNome.Text);
    Produto.setDescricao(edtDescricao.Text);
    Produto.setValorUnitario(StrToFloat(edtVlrUnitario.Text));
    Produto.setPeso(StrToFloat(edtPeso.Text));
    Produto.setAltura(StrToFloat(edtAltura.Text));
    Produto.Gravar;
    ShowMessage('Servi�o gravado com sucesso.');
    Cancelar;
  end;
end;

procedure TFrmCadProdutos.grpDadosEnter(Sender: TObject);
begin
  ValidarId;
end;

function TFrmCadProdutos.RetornarProximoId: integer;
begin
  //M�todo que busca no banco de dados o proximo Id dispon�vel e preenche o campo preperando para um novo registro.
  DmCadastro.qryPesquisa.Close;
  DmCadastro.qryPesquisa.SQL.Text := 'select Coalesce(max(Id),0) + 1 prox_codigo from Item';
  DmCadastro.qryPesquisa.Open();

  Result := DmCadastro.qryPesquisa.FieldByName('prox_codigo').AsInteger;
end;

function TFrmCadProdutos.ValidarCampos: boolean;
begin
  //M�todo que valida se os campos da tela est�o preenchidos antes de seguir com o cadastro.
  Result := true;

  if Trim(edtCodigo.Text) = '' then
  begin
    ShowMessage('Deve ser informado um c�digo.');
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
    ShowMessage('Deve ser informado uma descri��o.');
    edtDescricao.SetFocus;
    Result := false;
    Exit;
  end;

  if Trim(edtVlrUnitario.Text) = '' then
  begin
    ShowMessage('Deve ser informado um valor unit�rio.');
    edtVlrUnitario.SetFocus;
    Result := false;
    Exit;
  end;

  if Trim(edtPeso.Text) = '' then
  begin
    ShowMessage('Deve ser informado um peso.');
    edtPeso.SetFocus;
    Result := false;
    Exit;
  end;

  if Trim(edtAltura.Text) = '' then
  begin
    ShowMessage('Deve ser informado uma altura.');
    edtAltura.SetFocus;
    Result := false;
    Exit;
  end;
end;

procedure TFrmCadProdutos.ValidarId;
var
  Produto: TProduto;
  Servico: TServico;
begin
  // Valida se foi informado um ID de categoria e caso esteja informado, verifica se � um registro cadastrado ou se ser� cadastrado um novo registro.
  if Trim(edtId.Text) = '' then
  begin
    //Se n�o for informado um ID mostra mensagem de valida��o e volta o foco para o campo.
    ShowMessage('Deve ser informado um Id para realizar o cadastro.');
    edtId.SetFocus;
    exit;
  end;

  if StrToInt(edtId.Text) <= 0 then
  begin
    //Se n�o for informado um ID mostra mensagem de valida��o e volta o foco para o campo.
    ShowMessage('Deve ser informado um Id maior que zero para realizar o cadastro.');
    edtId.SetFocus;
    exit;
  end;

  Produto := TProduto.Create;
  Produto.Consultar(StrToInt(edtId.Text));


  if Produto.getId = 0 then
  begin
    Servico := TServico.Create;
    Servico.Consultar(StrToInt(edtId.Text));

    if Servico.getId > 0 then
    begin
      ShowMessage('O Id informado � de um servi�o e n�o pode ser utilizado na tela de cadastro de produtos.');
      edtId.SetFocus;
      exit;
    end;

    lblStatus.Caption := 'Novo';
  end else
  begin
    lblStatus.Caption := 'Altera��o';
    edtCodigo.Text := Produto.getCodigo;
    edtNome.Text := Produto.getNome;
    edtDescricao.Text := Produto.getDescricao;
    edtVlrUnitario.Text := FloatToStr(Produto.getValorUnitario);
    edtPeso.Text := FloatToStr(Produto.getPeso);
    edtAltura.Text := FloatToStr(Produto.getAltura);
    //Em caso de altera��o habilita o bot�o de exclus�o.
    btnExcluir.Enabled := true;
  end;

  grpAcesso.Enabled := false;
  btnGravar.Enabled := true;
  edtCodigo.SetFocus;
end;

end.
