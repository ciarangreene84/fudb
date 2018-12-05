@ECHO OFF

@ECHO 'DeFuDBing WebERP'
sqlcmd -S localhost\ -d WebERP -i 996_DropTriggersScript.sql -o WebERP_DropTriggersScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP -i WebERP_DropTriggersScript.sql
DEL WebERP_DropTriggersScript.sql
sqlcmd -S localhost\ -d WebERP -i 997_DropTablesScript.sql -o WebERP_DropTablesScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP -i WebERP_DropTablesScript.sql
DEL WebERP_DropTablesScript.sql
sqlcmd -S localhost\ -d WebERP -i 998_DropStoredProcedures.sql

@ECHO 'DeFuDBing WebERP_Archive'
sqlcmd -S localhost\ -d WebERP_Archive -i 996_DropTriggersScript.sql -o WebERP_Archive_DropTriggersScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP_Archive -i WebERP_Archive_DropTriggersScript.sql
DEL WebERP_Archive_DropTriggersScript.sql
sqlcmd -S localhost\ -d WebERP_Archive -i 997_DropTablesScript.sql -o WebERP_Archive_DropTablesScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP_Archive -i WebERP_Archive_DropTablesScript.sql
DEL WebERP_Archive_DropTablesScript.sql
sqlcmd -S localhost\ -d WebERP_Archive -i 998_DropStoredProcedures.sql

@ECHO 'DeFuDBing WebERP_Claims'
sqlcmd -S localhost\ -d WebERP_Claims -i 996_DropTriggersScript.sql -o WebERP_Claims_DropTriggersScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP_Claims -i WebERP_Claims_DropTriggersScript.sql
DEL WebERP_Claims_DropTriggersScript.sql
sqlcmd -S localhost\ -d WebERP_Claims -i 997_DropTablesScript.sql -o WebERP_Claims_DropTablesScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP_Claims -i WebERP_Claims_DropTablesScript.sql
DEL WebERP_Claims_DropTablesScript.sql
sqlcmd -S localhost\ -d WebERP_Claims -i 998_DropStoredProcedures.sql

@ECHO 'DeFuDBing WebERP_Finance'
sqlcmd -S localhost\ -d WebERP_Finance -i 996_DropTriggersScript.sql -o WebERP_Finance_DropTriggersScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP_Finance -i WebERP_Finance_DropTriggersScript.sql
DEL WebERP_Finance_DropTriggersScript.sql
sqlcmd -S localhost\ -d WebERP_Finance -i 997_DropTablesScript.sql -o WebERP_Finance_DropTablesScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP_Finance -i WebERP_Finance_DropTablesScript.
DEL WebERP_Finance_DropTablesScript.sql
sqlcmd -S localhost\ -d WebERP_Finance -i 998_DropStoredProcedures.sql

@ECHO 'DeFuDBing WebERP_SystemLogs'
sqlcmd -S localhost\ -d WebERP_SystemLogs -i 996_DropTriggersScript.sql -o WebERP_SystemLogs_DropTriggersScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP_SystemLogs -i WebERP_SystemLogs_DropTriggersScript.sql
DEL WebERP_SystemLogs_DropTriggersScript.sql
sqlcmd -S localhost\ -d WebERP_SystemLogs -i 997_DropTablesScript.sql -o WebERP_SystemLogs_DropTablesScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP_SystemLogs -i WebERP_SystemLogs_DropTablesScript.sql
DEL WebERP_SystemLogs_DropTablesScript.sql
sqlcmd -S localhost\ -d WebERP_SystemLogs -i 998_DropStoredProcedures.sql

sqlcmd -S localhost\SQLExpress -i ./999_DropInfrastructureScript.sql -o DropInfrastructure.sql -f 1255
sqlcmd -S localhost\SQLExpress -i DropInfrastructure.sql
DEL DropInfrastructure.sql