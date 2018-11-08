unit uCategoria;


interface
uses
  uDmCadastro;
type
  TCategoria = class
  private
    id: Integer;
    codigo: String;
    nome: String;
    DmCadastro: TDmCadastro;
  public
    function getId: Integer;
    procedure setId(pId: Integer);

    function getCodigo: String;
    procedure setCodigo(pCodigo:String);

    function getNome: String;
    procedure setNome(pNome:String);

    procedure Gravar();
    procedure Excluir();
    procedure Consultar(pId: integer);
    Constructor Create;

  end;

implementation

uses
  System.SysUtils;

{ TCategoria }


procedure TCategoria.Consultar(pId: integer);
begin
  id := 0;

  DmCadastro.qryPesquisa.Close;
  DmCadastro.qryPesquisa.SQL.Text := 'select * from Categoria where Id = ' + IntToStr(pId);
  DmCadastro.qryPesquisa.Open;

  if not DmCadastro.qryPesquisa.IsEmpty then
  begin
    id := pId;
    codigo := DmCadastro.qryPesquisa.FieldByName('codigo').AsString;
    nome := DmCadastro.qryPesquisa.FieldByName('nome').AsString;
  end;

end;

constructor TCategoria.Create;
begin
  DmCadastro := TdmCadastro.Create(DmCadastro);
end;

procedure TCategoria.Excluir();
begin
  DmCadastro.qryPesquisa.Close;
  DmCadastro.qryPesquisa.SQL.Text := 'delete from Categoria where Id = ' + IntToStr(id);
  DmCadastro.qryPesquisa.ExecSQL;
end;

function TCategoria.getCodigo: String;
begin
  Result := codigo;
end;

function TCategoria.getId: Integer;
begin
  Result := id;
end;

function TCategoria.getNome: String;
begin
  Result := nome;
end;

procedure TCategoria.Gravar();
begin

  DmCadastro.qryPesquisa.Close;
  DmCadastro.qryPesquisa.SQL.Text := 'select Id, Codigo, Nome from Categoria where Id = ' + IntToStr(id);
  DmCadastro.qryPesquisa.Open();

  if DmCadastro.qryPesquisa.IsEmpty then
  begin
    DmCadastro.qryPesquisa.Close;
    DmCadastro.qryPesquisa.SQL.Text := ' insert into Categoria values (' + IntToStr(id) + ',''' + codigo + ''',''' + nome + ''')';
  end else
  begin
    DmCadastro.qryPesquisa.Close;
    DmCadastro.qryPesquisa.SQL.Text := ' update Categoria set Codigo = ''' + codigo + ''', Nome = ''' + nome + ''' ' +
                                       ' where Id = ' + IntToStr(id);
  end;
  DmCadastro.qryPesquisa.ExecSQL;

end;

procedure TCategoria.setCodigo(pCodigo: String);
begin
  codigo := pCodigo;
end;

procedure TCategoria.setId(pId: Integer);
begin
  id := pId;
end;

procedure TCategoria.setNome(pNome: String);
begin
  nome := pNome;
end;

end.
