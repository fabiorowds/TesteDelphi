program prjTesteDelphi;

uses
  Vcl.Forms,
  uFrmPrincipal in 'uFrmPrincipal.pas' {FrmPrincipal},
  uItem in 'uItem.pas',
  uProduto in 'uProduto.pas',
  uServico in 'uServico.pas',
  uCategoria in 'uCategoria.pas',
  uDmCadastro in 'uDmCadastro.pas' {dmCadastro: TDataModule},
  uFrmCadProdutos in 'uFrmCadProdutos.pas' {FrmCadProdutos},
  uFrmCadServicos in 'uFrmCadServicos.pas' {FrmCadServicos},
  uFrmCadCategoria in 'uFrmCadCategoria.pas' {FrmCadCategoria};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TdmCadastro, dmCadastro);
  Application.CreateForm(TFrmCadProdutos, FrmCadProdutos);
  Application.CreateForm(TFrmCadServicos, FrmCadServicos);
  Application.CreateForm(TFrmCadCategoria, FrmCadCategoria);
  Application.Run;
end.
