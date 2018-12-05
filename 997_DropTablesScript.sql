DECLARE @Database varchar(64) = DB_NAME()
DECLARE @ModelSchema varchar(64) = 'dbo'

DECLARE @AuditDatabase varchar(64) = 'FuDB'
DECLARE @AuditSchema varchar(64) = 'Audit'

PRINT 'USE [' + @AuditDatabase + '];'
PRINT '';

DECLARE @table_id int
DECLARE @table_name nvarchar(128)

DECLARE table_cursor CURSOR FOR 
SELECT [object_id], [name]
    FROM fudb_GetTables (@ModelSchema)

OPEN table_cursor
FETCH NEXT FROM table_cursor INTO @table_id, @table_name

WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT 'DROP TABLE [' + @AuditSchema + '].[' + @Database + '_' + @ModelSchema + '_' + @table_name + '] '
    FETCH NEXT FROM table_cursor INTO @table_id, @table_name
END

CLOSE table_cursor
DEALLOCATE table_cursor;
