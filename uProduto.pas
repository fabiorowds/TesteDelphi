unit uProduto;

interface

uses
  uItem, uDmCadastro;
type
  TProduto = class(TItem)
  private
    peso: Double;
    altura: Double;
    DmCadastro: TDmCadastro;
  public
    function getPeso: Double;
    procedure setPeso(pPeso:Double);

    function getAltura: Double;
    procedure setAltura(pAltura: Double);

    procedure Gravar();
    procedure Excluir();
    procedure Consultar(pId: integer);
    Constructor Create;

  end;
implementation

uses
  System.SysUtils;

{ TProduto }

procedure TProduto.Consultar(pId: integer);
begin
  setId(0);

  DmCadastro.qryPesquisa.Close;
  DmCadastro.qryPesquisa.SQL.Text := ' select Codigo, Nome, Descricao, ValorUnitario, Peso, Altura' +
                                     ' from item i ' +
                                     ' inner join Produto p on p.idItem = i.id ' +
                                     ' where i.id = ' + IntToStr(pId);
  DmCadastro.qryPesquisa.Open;

  if not DmCadastro.qryPesquisa.IsEmpty then
  begin
    SetId(pId);
    SetCodigo(DmCadastro.qryPesquisa.FieldByName('codigo').AsString);
    SetNome(DmCadastro.qryPesquisa.FieldByName('nome').AsString);
    setDescricao(DmCadastro.qryPesquisa.FieldByName('Descricao').AsString);
    setValorUnitario(DmCadastro.qryPesquisa.FieldByName('ValorUnitario').AsFloat);
    setPeso(DmCadastro.qryPesquisa.FieldByName('Peso').AsFloat);
    setAltura(DmCadastro.qryPesquisa.FieldByName('Altura').AsFloat);
  end;
end;

constructor TProduto.Create;
begin
  DmCadastro := TdmCadastro.Create(DmCadastro);
end;

procedure TProduto.Excluir;
begin
  DmCadastro.qryPesquisa.Close;
  DmCadastro.qryPesquisa.SQL.Text := 'delete from Produto where IdItem = ' + IntToStr(getId);
  DmCadastro.qryPesquisa.ExecSQL;

  DmCadastro.qryPesquisa.Close;
  DmCadastro.qryPesquisa.SQL.Text := 'delete from Item where Id = ' + IntToStr(getId);
  DmCadastro.qryPesquisa.ExecSQL;
end;

function TProduto.getAltura: Double;
begin
  Result := altura;
end;

function TProduto.getPeso: Double;
begin
  Result := peso;
end;

procedure TProduto.Gravar;
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
    DmCadastro.qryPesquisa.SQL.Text := ' insert into Produto values (' + IntToStr(getId) +
                                                                  ',' + StringReplace(FloatToStr(getPeso),',','.',[]) +
                                                                  ',' + StringReplace(FloatToStr(getAltura),',','.',[]) + ')';
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

    DmCadastro.qryPesquisa.SQL.Text := ' update Produto set Peso = ' + StringReplace(FloatToStr(getPeso),',','.',[]) +
                                                         ', Altura = ' + StringReplace(FloatToStr(getAltura),',','.',[]) +
                                       ' where IdItem = ' + IntToStr(getId);
    DmCadastro.qryPesquisa.ExecSQL;
  end;
end;

procedure TProduto.setAltura(pAltura: Double);
begin
  altura := pAltura;
end;

procedure TProduto.setPeso(pPeso: Double);
begin
  peso := pPeso;
end;

end.
