SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fudb_GetTables
(	
	@ModelSchema varchar(64) 
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT t.object_id, t.name
		FROM sys.schemas s
		INNER JOIN sys.tables t
			  ON s.schema_id = t.schema_id
		WHERE s.Name = @ModelSchema
		  AND t.name NOT IN ('PCS_SyncLog')
)
GO

CREATE PROCEDURE [fudb_PrintTableColumnDefinitions]
	@table_id int,
	@indent int
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @column_name nvarchar(256)
	DECLARE column_cursor CURSOR FOR 
		SELECT '[' + c.Name + ']' + ' ' + 
		   CASE ts.name 
			  WHEN 'char' THEN '[' + ts.name + ']' + ' (' + CASE c.max_length WHEN -1 THEN 'MAX' ELSE CONVERT(varchar, c.max_length) END + ')'
			  WHEN 'nchar' THEN '[' + ts.name + ']' + ' (' + CASE c.max_length WHEN -1 THEN 'MAX' ELSE CONVERT(varchar, c.max_length) END + ')'
			  WHEN 'varchar' THEN '[' + ts.name + ']' + ' (' + CASE c.max_length WHEN -1 THEN 'MAX' ELSE CONVERT(varchar, c.max_length) END + ')' 
			  WHEN 'nvarchar' THEN '[' + ts.name + ']' + ' (' + CASE c.max_length WHEN -1 THEN 'MAX' WHEN 8000 THEN 'MAX' WHEN 6000 THEN 'MAX' ELSE CONVERT(varchar, c.max_length) END + ')' 
			  WHEN 'decimal' THEN '[' + ts.name + ']' + ' (' + CONVERT(varchar, c.precision) + ', ' + CONVERT(varchar, c.scale) + ')'
			  ELSE '[' + ts.name + ']'
		   END + ' ' + 
		   CASE c.is_nullable
			  WHEN CONVERT(bit, 'false') THEN 'NOT NULL'
			  ELSE 'NULL'
		   END + ', '
		FROM sys.columns c
		INNER JOIN sys.types ts
			  ON c.system_type_id = ts.system_type_id
		WHERE c.object_id = @table_id
		   AND ts.name NOT IN ('sysname', 'image', 'text', 'ntext', 'geography', 'geometry', 'hierarchyid')

	OPEN column_cursor
	FETCH NEXT FROM column_cursor INTO @column_name

	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT REPLICATE(CHAR(9), @indent) + @column_name
		FETCH NEXT FROM column_cursor INTO @column_name
	END
	CLOSE column_cursor
	DEALLOCATE column_cursor;
END

GO

CREATE PROCEDURE [fudb_PrintTableColumns]
	@table_id int,
	@indent int
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @column_name nvarchar(256)
	DECLARE column_cursor CURSOR FOR 
		SELECT '[' + c.name + '], '
		   FROM sys.columns c
		   INNER JOIN sys.types ts
				 ON c.system_type_id = ts.system_type_id
		   WHERE c.object_id = @table_id
			 AND ts.name NOT IN ('sysname', 'image', 'text', 'ntext', 'geography', 'geometry', 'hierarchyid')

	OPEN column_cursor
	FETCH NEXT FROM column_cursor INTO @column_name

	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT REPLICATE(CHAR(9), @indent) + @column_name
		FETCH NEXT FROM column_cursor INTO @column_name
	END
	CLOSE column_cursor
	DEALLOCATE column_cursor;
END

GO


