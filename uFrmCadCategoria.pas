unit uFrmCadCategoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  uDmCadastro;

type
  TFrmCadCategoria = class(TForm)
    pnlCampos: TPanel;
    grpDados: TGroupBox;
    lblCodigo: TLabel;
    lblNome: TLabel;
    edtCodigo: TEdit;
    edtNome: TEdit;
    grpAcesso: TGroupBox;
    lblId: TLabel;
    lblStatus: TLabel;
    edtId: TEdit;
    pnlBotoes: TPanel;
    btnGravar: TButton;
    btnCancelar: TButton;
    btnExcluir: TButton;
    btnFechar: TButton;
    procedure FormShow(Sender: TObject);
    procedure edtIdKeyPress(Sender: TObject; var Key: Char);
    procedure btnFecharClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure grpDadosEnter(Sender: TObject);
  private
    { Private declarations }
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
  FrmCadCategoria: TFrmCadCategoria;
  DmCadastro: TDmCadastro;

implementation

uses
  uCategoria;

{$R *.dfm}

{ TFrmCadCategoria }

procedure TFrmCadCategoria.btnCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TFrmCadCategoria.btnExcluirClick(Sender: TObject);
begin
  Excluir;
end;

procedure TFrmCadCategoria.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCadCategoria.btnGravarClick(Sender: TObject);
begin
  Gravar;
end;

procedure TFrmCadCategoria.Cancelar;
begin
  // Método que retorna a tela para o estado inicial.
  edtId.Text := IntToStr(RetornarProximoId);
  edtCodigo.Text := '';
  edtNome.Text := '';
  grpAcesso.Enabled := true;
  lblStatus.Caption := 'Novo';
  btnGravar.Enabled := false;
  btnExcluir.Enabled := false;
  edtId.SetFocus;
end;

procedure TFrmCadCategoria.edtIdKeyPress(Sender: TObject; var Key: Char);
begin
  //Validação para o campo Id não aceitar caracteres invalidos.
  If not( key in['0'..'9',#08] ) then
    key:=#0;
end;

procedure TFrmCadCategoria.Excluir;
var
  Categoria : TCategoria;
begin
  //Método que verifica se tem um registro previamente cadastrado,
  //questiona o usuário se realmente deseja remover o registro e em caso de confirmação exclui do banco de dados.
  if lblStatus.Caption = 'Alteração' then
  begin
    if MessageDlg('Deseja realmente remover a categoria selecionada?',mtConfirmation, mbYesNo,0 ) = mrYes then
    begin
      Categoria := TCategoria.Create;
      Categoria.Consultar(StrToInt(edtId.Text));
      Categoria.Excluir();
      ShowMessage('Categoria removida com sucesso.');
      Cancelar;
    end;
  end;
end;

procedure TFrmCadCategoria.FormShow(Sender: TObject);
begin
  // Cria o componente DataModulo para acesso ao banco de dados ao inicializar a tela.
  DmCadastro := TdmCadastro.Create(Self);
  Cancelar;
end;

procedure TFrmCadCategoria.Gravar;
var
  Categoria : TCategoria;
begin
  //Método que valida os campos informados e grava a categoria no banco de dados.
  if ValidarCampos then
  begin
    Categoria := TCategoria.Create;
    Categoria.setId(StrToInt(edtId.Text));
    Categoria.setCodigo(edtCodigo.Text);
    Categoria.setNome(edtNome.Text);
    Categoria.Gravar;
    ShowMessage('Categoria cadastrada com sucesso.');
    Cancelar;
  end;
end;

procedure TFrmCadCategoria.grpDadosEnter(Sender: TObject);
begin
  ValidarId;
end;

function TFrmCadCategoria.RetornarProximoId: integer;
begin
  //Método que busca no banco de dados o proximo Id disponível e preenche o campo preperando para um novo registro.
  DmCadastro.qryPesquisa.Close;
  DmCadastro.qryPesquisa.SQL.Text := 'select Coalesce(max(Id),0) + 1 prox_codigo from Categoria';
  DmCadastro.qryPesquisa.Open();

  Result := DmCadastro.qryPesquisa.FieldByName('prox_codigo').AsInteger;
end;

function TFrmCadCategoria.ValidarCampos: boolean;
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

end;

procedure TFrmCadCategoria.ValidarId;
var
  Categoria : TCategoria;
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

  Categoria := TCategoria.Create;
  Categoria.Consultar(StrToInt(edtId.Text));

  if Categoria.getId = 0 then
  begin
    lblStatus.Caption := 'Novo';
  end else
  begin
    lblStatus.Caption := 'Alteração';
    edtCodigo.Text := Categoria.getCodigo;
    edtNome.Text := Categoria.getNome;
    //Em caso de alteração habilita o botão de exclusão.
    btnExcluir.Enabled := true;
  end;

  grpAcesso.Enabled := false;
  btnGravar.Enabled := true;
  edtCodigo.SetFocus;
end;

end.
