object dmServer: TdmServer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 145
  Width = 277
  object mConnection: TZConnection
    ControlsCodePage = cCP_UTF16
    ClientCodepage = 'UTF8'
    Properties.Strings = (
      'codepage=UTF8'
      'controls_cp=CP_UTF16')
    TransactIsolationLevel = tiReadCommitted
    SQLHourGlass = True
    Port = 0
    Database = 'D:\Work\projects\privat\server\bin\database\PRIVATE.FDB'
    User = 'SYSDBA'
    Protocol = 'firebird-2.5'
    Left = 48
    Top = 32
  end
  object qrEvents: TZQuery
    Connection = mConnection
    SQL.Strings = (
      'select'
      'evt.edate as edatetime,'
      'obpr.pnumber,'
      'obpr.address,'
      'obpr.rname as region,'
      'te.name as etype,'
      'obpr.is_group as isgroup,'
      'evt.description,'
      'evt.number,'
      'evt.dispatcher_msg'
      'from'
      'events evt'
      'join ('
      'select'
      'obj.id,'
      'p.number as pnumber,'
      'p.is_group,'
      'reg.name as rname,'
      'obj.address'
      'from '
      'objects obj'
      'join pcns p on (obj.id_pcn=p.id)'
      'join regions reg on (obj.id_regions=reg.id)'
      ') obpr ON (evt.id_objects=obpr.id)'
      'join type_evens te on (evt.id_type_events=te.id)'
      'where'
      'evt.edate between :startDate and :endDate'
      'order by evt.edate')
    Params = <
      item
        DataType = ftDateTime
        Name = 'startDate'
        ParamType = ptUnknown
      end
      item
        DataType = ftDateTime
        Name = 'endDate'
        ParamType = ptUnknown
      end>
    Left = 120
    Top = 32
    ParamData = <
      item
        DataType = ftDateTime
        Name = 'startDate'
        ParamType = ptUnknown
      end
      item
        DataType = ftDateTime
        Name = 'endDate'
        ParamType = ptUnknown
      end>
  end
  object SQLMonitor: TZSQLMonitor
    FileName = 'sql.log'
    MaxTraceCount = 100
    Left = 192
    Top = 32
  end
end
