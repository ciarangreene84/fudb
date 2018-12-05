DECLARE @Database varchar(64) = DB_NAME()
DECLARE @ModelSchema varchar(64) = 'dbo'

DECLARE @AuditDatabase varchar(64) = 'FuDB'
DECLARE @AuditSchema varchar(64) = 'Audit'

DECLARE @table_id int
DECLARE @table_name nvarchar(128)

PRINT 'USE [' + @Database + '];'
PRINT 'GO'
PRINT ''

DECLARE table_cursor CURSOR FOR 
SELECT [object_id], [name]
    FROM fudb_GetTables(@ModelSchema)

OPEN table_cursor
FETCH NEXT FROM table_cursor INTO @table_id, @table_name

WHILE @@FETCH_STATUS = 0
BEGIN

	PRINT 'DROP TRIGGER [' + @ModelSchema + '].[TR_' + @Database + '_' + @ModelSchema + '_' + @table_name  + '_' + @AuditDatabase + '_Audit_AI]'
	PRINT 'GO'
	PRINT ''

	PRINT 'DROP TRIGGER [' + @ModelSchema + '].[TR_' + @Database + '_' + @ModelSchema + '_' + @table_name  + '_' + @AuditDatabase + '_Audit_AU]'
	PRINT 'GO'
	PRINT ''

	PRINT 'DROP TRIGGER [' + @ModelSchema + '].[TR_' + @Database + '_' + @ModelSchema + '_' + @table_name  + '_' + @AuditDatabase + '_Audit_AD]'
	PRINT 'GO'
	PRINT ''

    FETCH NEXT FROM table_cursor INTO @table_id, @table_name
END

CLOSE table_cursor
DEALLOCATE table_cursor;
