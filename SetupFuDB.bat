@ECHO OFF
sqlcmd -S localhost\SQLExpress -i ./001_CreateInfrastructureScript.sql -o CreateInfrastructure.sql -f 1255
sqlcmd -S localhost\SQLExpress -i CreateInfrastructure.sql -f 1255

@ECHO 'FuDBing WebERP'
sqlcmd -S localhost\ -d WebERP -i 002_CreateStoredProcedures.sql -f 1255
sqlcmd -S localhost\ -d WebERP -i 003_CreateTablesScript.sql -o WebERP_CreateTablesScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP -i WebERP_CreateTablesScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP -i 004_CreateTriggersScript.sql -o WebERP_CreateTriggersScript.sql -f 1255
sqlcmd -S localhost\ -d WebERP -i WebERP_CreateTriggersScript.sql -f 1255

@ECHO 'Creating Model'
sqlcmd -S localhost\SQLExpress -d FuDB -i 005_CreateTransitions.sql -f 1255
