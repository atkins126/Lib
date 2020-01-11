object BaseDM: TBaseDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 482
  Width = 776
  object sqlConnection: TSQLConnection
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXDataSnap'
      'HostName=localhost'
      'Port=1020'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=24.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      'Filters={}')
    Left = 35
    Top = 10
    UniqueId = '{45AE0068-59BA-46A0-AF87-8D2869AB66DA}'
  end
end
