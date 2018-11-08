unit uItem;

interface

type
  TItem = class
  private
    id: Integer;
    codigo: String;
    nome: String;
    descricao: String;
    valorUnitario: Double;
  protected

  public
    function getId: Integer;
    procedure setId(pId:Integer);

    function getCodigo: String;
    procedure setCodigo(pCodigo:String);

    function getNome: String;
    procedure setNome(pNome:String);

    function getDescricao: String;
    procedure setDescricao(pDescricao:String);

    function getValorUnitario: Double;
    procedure setValorUnitario(pValorUnitario:Double);

end;

implementation

{ TItem }

function TItem.getCodigo: String;
begin
  Result := codigo;
end;

function TItem.getDescricao: String;
begin
  Result := descricao;
end;

function TItem.getId: Integer;
begin
  Result := id;
end;

function TItem.getNome: String;
begin
  Result := nome;
end;

function TItem.getValorUnitario: Double;
begin
  Result := valorUnitario;
end;

procedure TItem.setCodigo(pCodigo: String);
begin
  codigo := pCodigo;
end;

procedure TItem.setDescricao(pDescricao: String);
begin
  descricao := pDescricao;
end;

procedure TItem.setId(pId: Integer);
begin
  id := pId;
end;

procedure TItem.setNome(pNome: String);
begin
  nome := pNome;
end;

procedure TItem.setValorUnitario(pValorUnitario: Double);
begin
  valorUnitario := pValorUnitario;
end;

end.
