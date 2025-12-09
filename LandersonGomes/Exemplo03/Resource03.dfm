object CoderageResource1: TCoderageResource1
  Height = 375
  Width = 750
  PixelsPerInch = 120
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=EMPLOYEE')
    LoginPrompt = False
    Left = 38
    Top = 20
  end
  object qryCOUNTRY: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from COUNTRY'
      '{if !SORT}order by !SORT{fi}')
    Left = 163
    Top = 20
    MacroData = <
      item
        Value = Null
        Name = 'SORT'
      end>
  end
  object dsrCOUNTRY: TEMSDataSetResource
    AllowedActions = [List, Get, Post, Put, Delete]
    DataSet = qryCOUNTRY
    Left = 163
    Top = 80
  end
  object qryEMPLOYEE: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from EMPLOYEE'
      '{if !SORT}order by !SORT{fi}')
    Left = 288
    Top = 20
    MacroData = <
      item
        Value = Null
        Name = 'SORT'
      end>
  end
  object dsrEMPLOYEE: TEMSDataSetResource
    AllowedActions = [List, Get, Post, Put, Delete]
    DataSet = qryEMPLOYEE
    Left = 288
    Top = 80
  end
end
