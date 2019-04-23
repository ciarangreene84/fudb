@ECHO OFF

@ECHO 'DeFuDBing WebERP'
sqlcmd -S localhost\ -d WebERP -i 996_DropTriggersScript.sql -o WebERP_DropTriggersScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP -i WebERP_DropTriggersScript.sql
DEL WebERP_DropTriggersScript.sql
sqlcmd -S localhost\ -d WebERP -i 997_DropTablesScript.sql -o WebERP_DropTablesScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP -i WebERP_DropTablesScript.sql
DEL WebERP_DropTablesScript.sql
sqlcmd -S localhost\ -d WebERP -i 998_DropStoredProcedures.sql

sqlcmd -S localhost\SQLExpress -i ./999_DropInfrastructureScript.sql -o DropInfrastructure.sql -f 1255
sqlcmd -S localhost\SQLExpress -i DropInfrastructure.sql
DEL DropInfrastructure.sql
