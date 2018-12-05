DECLARE @SetupAuditTablePrimaryKeys bit = 'false'

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


DECLARE @table_definition nvarchar(MAX) = ''

	PRINT 'CREATE TABLE [' + @AuditSchema + '].[' + @Database + '_' + @ModelSchema + '_' + @table_name + '] '
	PRINT '('
	PRINT REPLICATE(char(9), 1) + '[AuditSequenceId] [int] NOT NULL, '
	EXEC fudb_PrintTableColumnDefinitions @table_id, 1
	PRINT REPLICATE(char(9), 1) + '[Operation] [varchar](8) NOT NULL, '
	PRINT REPLICATE(char(9), 1) + '[AuditUser] [varchar](256) NOT NULL, '
	PRINT REPLICATE(char(9), 1) + '[UtcDateTime] [datetime2](7) NOT NULL'
	PRINT ')'
	PRINT 'GO'
	PRINT ''

	PRINT 'ALTER TABLE [' + @AuditSchema + '].[' + @Database + '_' + @ModelSchema + '_' + @table_name + '] ADD CONSTRAINT [DF_' + @Database + '_' + @ModelSchema + '_' + @table_name + '_Audit] DEFAULT (NEXT VALUE FOR [' + @AuditSchema + '].[AuditSequence]) FOR [AuditSequenceId]'
	PRINT 'GO'
	PRINT ''

	IF (@SetupAuditTablePrimaryKeys = 'true') AND EXISTS(SELECT COLUMN_NAME
			   FROM [INFORMATION_SCHEMA].[KEY_COLUMN_USAGE]
			   WHERE OBJECTPROPERTY(OBJECT_ID([CONSTRAINT_SCHEMA]+'.'+[CONSTRAINT_NAME]), 'IsPrimaryKey') = 1
				AND TABLE_SCHEMA = @ModelSchema
				AND TABLE_NAME = @table_name)
	BEGIN
		SELECT @table_definition = '[' + COLUMN_NAME + '], ' 
			FROM [INFORMATION_SCHEMA].[KEY_COLUMN_USAGE]
			WHERE OBJECTPROPERTY(OBJECT_ID([CONSTRAINT_SCHEMA]+'.'+[CONSTRAINT_NAME]), 'IsPrimaryKey') = 1
			 AND TABLE_SCHEMA = @ModelSchema
			 AND TABLE_NAME = @table_name
		   ORDER BY ORDINAL_POSITION

		PRINT 'ALTER TABLE [' + @AuditSchema + '].[' + @Database + '_' + @ModelSchema + '_' + @table_name + '] ADD CONSTRAINT [PK_' + @Database + '_' + @ModelSchema + '_' + @table_name + '_Audit] PRIMARY KEY CLUSTERED '
		PRINT '('
		PRINT '	   ' + ISNULL(@table_definition, '') + ' [Operation], [UtcDateTime]'
		PRINT ')'
		PRINT 'GO'
		PRINT ''

	END
	ELSE
	BEGIN 
		PRINT 'ALTER TABLE [' + @AuditSchema + '].[' + @Database + '_' + @ModelSchema + '_' + @table_name + '] ADD CONSTRAINT [PK_' + @Database + '_' + @ModelSchema + '_' + @table_name + '_Audit] PRIMARY KEY CLUSTERED'
		PRINT '('
		PRINT REPLICATE(char(9), 1) + '[AuditSequenceId]'
		PRINT ')'
		PRINT 'GO'
		PRINT ''
	END

    FETCH NEXT FROM table_cursor INTO @table_id, @table_name
END

CLOSE table_cursor
DEALLOCATE table_cursor;
