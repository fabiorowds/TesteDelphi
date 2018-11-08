unit uServico;

interface

uses
  uItem, uCategoria, uDmCadastro;
type
  TServico = class(TItem)
  private
    codigoServico: String;
    categoria: TCategoria;
    DmCadastro: TDmCadastro;
  public
    function getCodigoServico: String;
    procedure setCodigoServico(pCodigoServico: String);

    function getCategoria: TCategoria;
    procedure setCategoria(pCategoria: TCategoria);

    procedure Gravar();
    procedure Excluir();
    procedure Consultar(pId: integer);
    Constructor Create;
  end;

implementation

uses
  System.SysUtils;

{ TServico }

procedure TServico.Consultar(pId: integer);
var
  Categoria: TCategoria;
begin
  setId(0);

  DmCadastro.qryPesquisa.Close;
  DmCadastro.qryPesquisa.SQL.Text := ' select Codigo, Nome, Descricao, ValorUnitario, CodigoServico, IdCategoria' +
                                     ' from item i ' +
                                     ' inner join Servico s on s.idItem = i.id ' +
                                     ' where i.id = ' + IntToStr(pId);
  DmCadastro.qryPesquisa.Open;

  if not DmCadastro.qryPesquisa.IsEmpty then
  begin
    Categoria := TCategoria.Create;
    SetId(pId);
    SetCodigo(DmCadastro.qryPesquisa.FieldByName('codigo').AsString);
    SetNome(DmCadastro.qryPesquisa.FieldByName('nome').AsString);
    setDescricao(DmCadastro.qryPesquisa.FieldByName('Descricao').AsString);
    setValorUnitario(DmCadastro.qryPesquisa.FieldByName('ValorUnitario').AsFloat);
    setCodigoServico(DmCadastro.qryPesquisa.FieldByName('CodigoServico').AsString);
    Categoria.Consultar(DmCadastro.qryPesquisa.FieldByName('IdCategoria').AsInteger);
    setCategoria(Categoria);
  end;
end;

constructor TServico.Create;
begin
  DmCadastro := TdmCadastro.Create(DmCadastro);
end;

procedure TServico.Excluir;
begin
  DmCadastro.qryPesquisa.Close;
  DmCadastro.qryPesquisa.SQL.Text := 'delete from Servico where IdItem = ' + IntToStr(getId);
  DmCadastro.qryPesquisa.ExecSQL;

  DmCadastro.qryPesquisa.Close;
  DmCadastro.qryPesquisa.SQL.Text := 'delete from Item where Id = ' + IntToStr(getId);
  DmCadastro.qryPesquisa.ExecSQL;
end;

function TServico.getCategoria: TCategoria;
begin
  Result := categoria;
end;

function TServico.getCodigoServico: String;
begin
  Result := codigoServico;
end;

procedure TServico.Gravar;
begin
  DmCadastro.qryPesquisa.Close;
  DmCadastro.qryPesquisa.SQL.Text := 'select * from Item where Id = ' + IntToStr(getId);
  DmCadastro.qryPesquisa.Open();

  if DmCadastro.qryPesquisa.IsEmpty then
  begin
    DmCadastro.qryPesquisa.Close;
    DmCadastro.qryPesquisa.SQL.Text := ' insert into Item values (' + IntToStr(getId) +
                                                                  ',''' + getCodigo + '''' +
                                                                  ',''' + getNome + '''' +
                                                                  ',''' + getDescricao + '''' +
                                                                  ',' + StringReplace(FloatToStr(getValorUnitario),',','.',[]) + ')';
    DmCadastro.qryPesquisa.ExecSQL;
    DmCadastro.qryPesquisa.SQL.Text := ' insert into Servico values (' + IntToStr(getId) +
                                                                  ',''' + getCodigoServico + '''' +
                                                                  ',' + IntToStr(getCategoria.getId) + ')';
    DmCadastro.qryPesquisa.ExecSQL;
  end else
  begin
    DmCadastro.qryPesquisa.Close;
    DmCadastro.qryPesquisa.SQL.Text := ' update Item set Codigo = ''' + getCodigo + '''' +
                                                      ', Nome = ''' + getNome + ''' ' +
                                                      ', Descricao = ''' + getDescricao + ''' ' +
                                                      ', ValorUnitario = ' + StringReplace(FloatToStr(getValorUnitario),',','.',[]) +
                                       ' where Id = ' + IntToStr(getId);
    DmCadastro.qryPesquisa.ExecSQL;

    DmCadastro.qryPesquisa.SQL.Text := ' update Servico set CodigoServico = ''' + getCodigoServico + '''' +
                                                         ', IdCategoria = ' + IntToStr(getCategoria.getId) +
                                       ' where IdItem = ' + IntToStr(getId);
    DmCadastro.qryPesquisa.ExecSQL;
  end;
end;

procedure TServico.setCategoria(pCategoria: TCategoria);
begin
  categoria := pCategoria;
end;

procedure TServico.setCodigoServico(pCodigoServico: String);
begin
  codigoServico := pCodigoServico;
end;

end.
