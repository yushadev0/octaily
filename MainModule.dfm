object UniMainModule: TUniMainModule
  OnCreate = UniGUIMainModuleCreate
  Theme = 'uni_win11'
  MonitoredKeys.Keys = <>
  Height = 750
  Width = 1000
  PixelsPerInch = 120
  object UniConnection1: TUniConnection
    ProviderName = 'SQL Server'
    Database = 'octaily'
    Server = '167.86.118.127\MSSQL2017'
    LoginPrompt = False
    Left = 40
    Top = 56
  end
  object SQLServerUniProvider1: TSQLServerUniProvider
    Left = 120
    Top = 56
  end
  object LoginTable: TUniQuery
    Connection = UniConnection1
    SQL.Strings = (
      'select * from users')
    Left = 280
    Top = 56
  end
  object RegisterTable: TUniQuery
    Connection = UniConnection1
    Left = 280
    Top = 128
  end
  object StatsTable: TUniQuery
    Connection = UniConnection1
    Left = 280
    Top = 200
  end
  object StatsExec: TUniQuery
    Connection = UniConnection1
    Left = 280
    Top = 264
  end
  object QueryExec: TUniQuery
    Connection = UniConnection1
    Left = 352
    Top = 264
  end
end
