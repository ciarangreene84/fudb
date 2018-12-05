DECLARE @Database varchar(64) = DB_NAME()
DECLARE @ModelSchema varchar(64) = 'dbo'

DECLARE @AuditDatabase varchar(64) = 'FuDB'
DECLARE @AuditSchema varchar(64) = 'Audit'

DECLARE @table_id int
DECLARE @table_name nvarchar(128)
DECLARE @column_name nvarchar(256)

PRINT 'USE [' + @Database + '];'
PRINT 'GO'
PRINT ''

DECLARE table_cursor CURSOR FOR 
SELECT [object_id], [name]
    FROM fudb_GetTables (@ModelSchema)

OPEN table_cursor
FETCH NEXT FROM table_cursor INTO @table_id, @table_name

WHILE @@FETCH_STATUS = 0
BEGIN

PRINT 'CREATE TRIGGER [' + @ModelSchema + '].[TR_' + @Database + '_' + @ModelSchema + '_' + @table_name  + '_' + @AuditDatabase + '_Audit_AI] '
PRINT REPLICATE(CHAR(9), 1) + 'ON [' + @ModelSchema + '].[' + @table_name + ']'
PRINT REPLICATE(CHAR(9), 1) + 'AFTER INSERT '
PRINT 'AS '
PRINT 'SET XACT_ABORT OFF'
PRINT 'BEGIN '
PRINT REPLICATE(CHAR(9), 1) + 'SET NOCOUNT ON;'
PRINT ''
PRINT REPLICATE(CHAR(9), 1) + 'BEGIN TRY'
PRINT REPLICATE(CHAR(9), 2) + 'INSERT INTO [' + @AuditDatabase + '].[' + @AuditSchema + '].[' + @Database + '_' + @ModelSchema + '_' + @table_name + '] '
PRINT REPLICATE(CHAR(9), 4) + '(' 
EXEC fudb_PrintTableColumns @table_id, 5
PRINT REPLICATE(CHAR(9), 5) + '[Operation],'
PRINT REPLICATE(CHAR(9), 5) + '[AuditUser],'
PRINT REPLICATE(CHAR(9), 5) + '[UtcDateTime]'
PRINT REPLICATE(CHAR(9), 4) + ')'
PRINT REPLICATE(CHAR(9), 4) + 'OUTPUT INSERTED.AuditSequenceId, '''+ @Database + ''', ''' + @ModelSchema + ''', ''' + @table_name +''', INSERTED.Operation'
PRINT REPLICATE(CHAR(9), 4) + 'INTO [' + @AuditDatabase + '].[' + @AuditSchema + '].[MasterSequenceRecords] (AuditSequenceId, DatabaseName, SchemaName, TableName, Operation)'
PRINT REPLICATE(CHAR(9), 3) + 'SELECT '
EXEC fudb_PrintTableColumns @table_id, 5
PRINT REPLICATE(CHAR(9), 5) + '''INSERT'' AS Operation,'
PRINT REPLICATE(CHAR(9), 5) + 'SYSTEM_USER AS [AuditUser],'
PRINT REPLICATE(CHAR(9), 5) + 'SYSUTCDATETIME() AS [UtcDateTime]'
PRINT REPLICATE(CHAR(9), 4) + 'FROM inserted'
PRINT REPLICATE(CHAR(9), 1) + 'END TRY'
PRINT REPLICATE(CHAR(9), 1) + 'BEGIN CATCH'
PRINT REPLICATE(CHAR(9), 2) + 'INSERT INTO [' + @AuditDatabase + '].[' + @AuditSchema + '].MasterSequenceRecords (AuditSequenceId, DatabaseName, SchemaName, TableName, Operation, Message) VALUES (NEXT VALUE FOR [' + @AuditDatabase + '].[' + @AuditSchema + '].[AuditSequence], '''+ @Database + ''', ''' + @ModelSchema + ''', ''' + @table_name +''', ''INSERT'', ERROR_MESSAGE())'
PRINT REPLICATE(CHAR(9), 1) + 'END CATCH'
PRINT 'END'
PRINT 'GO'
PRINT ''

PRINT 'CREATE TRIGGER [' + @ModelSchema + '].[TR_' + @Database + '_' + @ModelSchema + '_' + @table_name  + '_' + @AuditDatabase + '_Audit_AU]'
PRINT REPLICATE(CHAR(9), 1) + 'ON [' + @ModelSchema + '].[' + @table_name + ']'
PRINT REPLICATE(CHAR(9), 1) + 'AFTER UPDATE '
PRINT 'AS '
PRINT 'SET XACT_ABORT OFF'
PRINT 'BEGIN '
PRINT REPLICATE(CHAR(9), 1) + 'SET NOCOUNT ON; '
PRINT ''
PRINT REPLICATE(CHAR(9), 1) + 'BEGIN TRY'
PRINT REPLICATE(CHAR(9), 2) + 'INSERT INTO [' + @AuditDatabase + '].[' + @AuditSchema + '].[' + @Database + '_' + @ModelSchema + '_' + @table_name + '] '
PRINT REPLICATE(CHAR(9), 4) + '('
EXEC fudb_PrintTableColumns @table_id, 5
PRINT REPLICATE(CHAR(9), 5) + '[Operation],'
PRINT REPLICATE(CHAR(9), 5) + '[AuditUser],'
PRINT REPLICATE(CHAR(9), 5) + '[UtcDateTime]'
PRINT REPLICATE(CHAR(9), 4) + ')'
PRINT REPLICATE(CHAR(9), 4) + 'OUTPUT INSERTED.AuditSequenceId, '''+ @Database + ''', ''' + @ModelSchema + ''', ''' + @table_name +''', INSERTED.Operation'
PRINT REPLICATE(CHAR(9), 4) + 'INTO [' + @AuditDatabase + '].[' + @AuditSchema + '].[MasterSequenceRecords] (AuditSequenceId, DatabaseName, SchemaName, TableName, Operation)'
PRINT REPLICATE(CHAR(9), 3) + 'SELECT '
EXEC fudb_PrintTableColumns @table_id, 5
PRINT REPLICATE(CHAR(9), 5) + '''UPDATE_D'' AS Operation,'
PRINT REPLICATE(CHAR(9), 5) + 'SYSTEM_USER AS [AuditUser],'
PRINT REPLICATE(CHAR(9), 5) + 'SYSUTCDATETIME() AS [UtcDateTime]'
PRINT REPLICATE(CHAR(9), 4) + 'FROM deleted'
PRINT ''
PRINT REPLICATE(CHAR(9), 2) + 'INSERT INTO [' + @AuditDatabase + '].[' + @AuditSchema + '].[' + @Database + '_' + @ModelSchema + '_' + @table_name + '] '
PRINT REPLICATE(CHAR(9), 4) + '('
EXEC fudb_PrintTableColumns @table_id, 5
PRINT REPLICATE(CHAR(9), 5) + '[Operation],'
PRINT REPLICATE(CHAR(9), 5) + '[AuditUser],'
PRINT REPLICATE(CHAR(9), 5) + '[UtcDateTime]'
PRINT REPLICATE(CHAR(9), 4) + ')'
PRINT REPLICATE(CHAR(9), 4) + 'OUTPUT INSERTED.AuditSequenceId, '''+ @Database + ''', ''' + @ModelSchema + ''', ''' + @table_name +''', INSERTED.Operation'
PRINT REPLICATE(CHAR(9), 4) + 'INTO [' + @AuditDatabase + '].[' + @AuditSchema + '].[MasterSequenceRecords] (AuditSequenceId, DatabaseName, SchemaName, TableName, Operation)'
PRINT REPLICATE(CHAR(9), 3) + 'SELECT '
EXEC fudb_PrintTableColumns @table_id, 5
PRINT REPLICATE(CHAR(9), 5) + '''UPDATE_I'' AS Operation,'
PRINT REPLICATE(CHAR(9), 5) + 'SYSTEM_USER AS [AuditUser],'
PRINT REPLICATE(CHAR(9), 5) + 'SYSUTCDATETIME() AS [UtcDateTime]'
PRINT REPLICATE(CHAR(9), 4) + 'FROM inserted'
PRINT REPLICATE(CHAR(9), 1) + 'END TRY'
PRINT REPLICATE(CHAR(9), 1) + 'BEGIN CATCH'
PRINT REPLICATE(CHAR(9), 2) + 'INSERT INTO [' + @AuditDatabase + '].[' + @AuditSchema + '].MasterSequenceRecords (AuditSequenceId, DatabaseName, SchemaName, TableName, Operation, Message) VALUES (NEXT VALUE FOR [' + @AuditDatabase + '].[' + @AuditSchema + '].[AuditSequence], '''+ @Database + ''', ''' + @ModelSchema + ''', ''' + @table_name +''', ''UPDATE'', ERROR_MESSAGE())'
PRINT REPLICATE(CHAR(9), 1) + 'END CATCH'
PRINT 'END'
PRINT 'GO'
PRINT ''

PRINT 'CREATE TRIGGER [' + @ModelSchema + '].[TR_' + @Database + '_' + @ModelSchema + '_' + @table_name  + '_' + @AuditDatabase + '_Audit_AD] '
PRINT REPLICATE(CHAR(9), 1) + 'ON [' + @ModelSchema + '].[' + @table_name + ']  '
PRINT REPLICATE(CHAR(9), 1) + 'AFTER DELETE '
PRINT 'AS '
PRINT 'SET XACT_ABORT OFF'
PRINT 'BEGIN '
PRINT REPLICATE(CHAR(9), 1) + 'SET NOCOUNT ON; '
PRINT ''
PRINT REPLICATE(CHAR(9), 1) + 'BEGIN TRY'
PRINT REPLICATE(CHAR(9), 2) + 'INSERT INTO [' + @AuditDatabase + '].[' + @AuditSchema + '].[' + @Database + '_' + @ModelSchema + '_' + @table_name + '] '
PRINT REPLICATE(CHAR(9), 4) + '('
EXEC fudb_PrintTableColumns @table_id, 5
PRINT REPLICATE(CHAR(9), 5) + '[Operation],'
PRINT REPLICATE(CHAR(9), 5) + '[AuditUser],'
PRINT REPLICATE(CHAR(9), 5) + '[UtcDateTime]'
PRINT REPLICATE(CHAR(9), 4) + ')'
PRINT REPLICATE(CHAR(9), 4) + 'OUTPUT INSERTED.AuditSequenceId, '''+ @Database + ''', ''' + @ModelSchema + ''', ''' + @table_name +''', INSERTED.Operation'
PRINT REPLICATE(CHAR(9), 4) + 'INTO [' + @AuditDatabase + '].[' + @AuditSchema + '].[MasterSequenceRecords] (AuditSequenceId, DatabaseName, SchemaName, TableName, Operation)'
PRINT REPLICATE(CHAR(9), 3) + 'SELECT '
EXEC fudb_PrintTableColumns @table_id, 5
PRINT REPLICATE(CHAR(9), 5) + '''UPDATE_D'' AS Operation,'
PRINT REPLICATE(CHAR(9), 5) + 'SYSTEM_USER AS [AuditUser],'
PRINT REPLICATE(CHAR(9), 5) + 'SYSUTCDATETIME() AS [UtcDateTime]'
PRINT REPLICATE(CHAR(9), 4) + 'FROM deleted'
PRINT REPLICATE(CHAR(9), 1) + 'END TRY'
PRINT REPLICATE(CHAR(9), 1) + 'BEGIN CATCH'
PRINT REPLICATE(CHAR(9), 2) + 'INSERT INTO [' + @AuditDatabase + '].[' + @AuditSchema + '].MasterSequenceRecords (AuditSequenceId, DatabaseName, SchemaName, TableName, Operation, Message) VALUES (NEXT VALUE FOR [' + @AuditDatabase + '].[' + @AuditSchema + '].[AuditSequence], '''+ @Database + ''', ''' + @ModelSchema + ''', ''' + @table_name +''', ''DELETE'', ERROR_MESSAGE())'
PRINT REPLICATE(CHAR(9), 1) + 'END CATCH'
PRINT 'END'
PRINT 'GO'
PRINT ''

    FETCH NEXT FROM table_cursor INTO @table_id, @table_name
END

CLOSE table_cursor
DEALLOCATE table_cursor;
