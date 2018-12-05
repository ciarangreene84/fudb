@ECHO OFF
sqlcmd -S localhost\SQLExpress -i ./001_CreateInfrastructureScript.sql -o CreateInfrastructure.sql -f 1255
sqlcmd -S localhost\SQLExpress -i CreateInfrastructure.sql -f 1255

@ECHO 'FuDBing WebERP'
sqlcmd -S localhost\ -d WebERP -i 002_CreateStoredProcedures.sql -f 1255
sqlcmd -S localhost\ -d WebERP -i 003_CreateTablesScript.sql -o WebERP_CreateTablesScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP -i WebERP_CreateTablesScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP -i 004_CreateTriggersScript.sql -o WebERP_CreateTriggersScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP -i WebERP_CreateTriggersScript.sql -f 1255

@ECHO 'FuDBing WebERP_Archive'
sqlcmd -S localhost\ -d WebERP_Archive -i 002_CreateStoredProcedures.sql -f 1255
sqlcmd -S localhost\ -d WebERP_Archive -i 003_CreateTablesScript.sql -o WebERP_Archive_CreateTablesScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP_Archive -i WebERP_Archive_CreateTablesScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP_Archive -i 004_CreateTriggersScript.sql -o WebERP_Archive_CreateTriggersScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP_Archive -i WebERP_Archive_CreateTriggersScript.sql -f 1255

@ECHO 'FuDBing WebERP_Claims'
sqlcmd -S localhost\ -d WebERP_Claims -i 002_CreateStoredProcedures.sql -f 1255
sqlcmd -S localhost\ -d WebERP_Claims -i 003_CreateTablesScript.sql -o WebERP_Claims_CreateTablesScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP_Claims -i WebERP_Claims_CreateTablesScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP_Claims -i 004_CreateTriggersScript.sql -o WebERP_Claims_CreateTriggersScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP_Claims -i WebERP_Claims_CreateTriggersScript.sql -f 1255

@ECHO 'FuDBing WebERP_Finance'
sqlcmd -S localhost\ -d WebERP_Finance -i 002_CreateStoredProcedures.sql -f 1255
sqlcmd -S localhost\ -d WebERP_Finance -i 003_CreateTablesScript.sql -o WebERP_Finance_CreateTablesScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP_Finance -i WebERP_Finance_CreateTablesScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP_Finance -i 004_CreateTriggersScript.sql -o WebERP_Finance_CreateTriggersScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP_Finance -i WebERP_Finance_CreateTriggersScript.sql -f 1255

@ECHO 'FuDBing WebERP_SystemLogs'
sqlcmd -S localhost\ -d WebERP_SystemLogs -i 002_CreateStoredProcedures.sql -f 1255
sqlcmd -S localhost\ -d WebERP_SystemLogs -i 003_CreateTablesScript.sql -o WebERP_SystemLogs_CreateTablesScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP_SystemLogs -i WebERP_SystemLogs_CreateTablesScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP_SystemLogs -i 004_CreateTriggersScript.sql -o WebERP_SystemLogs_CreateTriggersScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP_SystemLogs -i WebERP_SystemLogs_CreateTriggersScript.sql -f 1255

@ECHO 'Creating Model'
sqlcmd -S localhost\SQLExpress -d FuDB -i 005_CreateTransitions.sql -f 1255
