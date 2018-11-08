object dmCadastro: TdmCadastro
  OldCreateOrder = False
  Height = 232
  Width = 357
  object Connection: TFDConnection
    Params.Strings = (
      'SERVER=USUARIO\SQLEXPRESS'
      'User_Name=teste'
      'Password=teste'
      'ApplicationName=Enterprise/Architect/Ultimate'
      'Workstation=USUARIO'
      'DATABASE=TesteDelphi'
      'MARS=yes'
      'DriverID=MSSQL')
    Connected = True
    LoginPrompt = False
    Left = 280
    Top = 72
  end
  object qryPesquisa: TFDQuery
    Connection = Connection
    Left = 160
    Top = 128
  end
end
