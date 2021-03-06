SELECT TOP 1000 *
	FROM [FuDB].[Audit].[MasterSequenceRecords]
	WHERE TableName NOT IN ('Log4Net', 'sqlsplog')
	  AND 53325 < AuditSequenceId
	  AND AuditSequenceId <= 54115
	ORDER BY [AuditSequenceId] DESC

SELECT DatabaseName, 
		SchemaName, 
		TableName
		,CASE Operation 
			WHEN 'UPDATE_I' THEN 'UPDATE'
			WHEN 'UPDATE_D' THEN 'UPDATE'
		ELSE Operation
		END
		,CASE Operation 
			WHEN 'UPDATE_I' THEN 0.5
			WHEN 'UPDATE_D' THEN 0.5
		ELSE 1.0
		END		 
	FROM [FuDB].[Audit].[MasterSequenceRecords]
	WHERE 53325 < AuditSequenceId
	  AND AuditSequenceId <= 54115
	ORDER BY [AuditSequenceId] DESC


/*
DELETE FROM [FuDB].[Audit].[MasterSequenceRecords]
*/