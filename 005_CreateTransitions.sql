CREATE SCHEMA [Model]
GO


CREATE TABLE [Model].[Sequences](
	[SequenceId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Sequences] PRIMARY KEY CLUSTERED 
(
	[SequenceId] ASC
)
)

GO

ALTER TABLE [Model].[Sequences]  WITH CHECK ADD  CONSTRAINT [CK_Sequences_Description] CHECK  (((0)<len([Description])))
GO

ALTER TABLE [Model].[Sequences] CHECK CONSTRAINT [CK_Sequences_Description]
GO


CREATE TABLE [Model].[Transitions](
	[TransitionId] [int] IDENTITY(1,1) NOT NULL,
	[SequenceId] [int] NOT NULL,
	[StartAuditSequenceId] [int] NOT NULL,
	[EndAuditSequenceId] [int] NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[Image] [varbinary](max) NULL,
 CONSTRAINT [PK_Transitions] PRIMARY KEY CLUSTERED 
(
	[TransitionId] ASC
),
 CONSTRAINT [UQ_Transitions_End] UNIQUE NONCLUSTERED 
(
	[EndAuditSequenceId] ASC
),
 CONSTRAINT [UQ_Transitions_Start] UNIQUE NONCLUSTERED 
(
	[StartAuditSequenceId] ASC
)
) 
GO

ALTER TABLE [Model].[Transitions]  WITH CHECK ADD  CONSTRAINT [FK_Transitions_Sequences] FOREIGN KEY([SequenceId])
REFERENCES [Model].[Sequences] ([SequenceId])
GO

ALTER TABLE [Model].[Transitions]  WITH CHECK ADD  CONSTRAINT [CK_Transitions_Description] CHECK  (((0)<len([Description])))
GO

ALTER TABLE [Model].[Transitions] CHECK CONSTRAINT [CK_Transitions_Description]
GO

ALTER TABLE [Model].[Transitions]  WITH CHECK ADD  CONSTRAINT [CK_Transitions_StartLessThanEnd] CHECK  (([StartAuditSequenceId]<[EndAuditSequenceId]))
GO

ALTER TABLE [Model].[Transitions] CHECK CONSTRAINT [CK_Transitions_StartLessThanEnd]
GO

CREATE TABLE [Model].[ExcludedTables](
	[DatabaseName] [varchar](256) NOT NULL,
	[SchemaName] [varchar](256) NOT NULL,
	[TableName] [varchar](256) NOT NULL
)

GO


CREATE SCHEMA Facade
GO

CREATE FUNCTION Facade.GetTransitionMasterSequenceRecords
(	
	@TransitionId int
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT [MasterSequenceRecords].AuditSequenceId
			,[MasterSequenceRecords].DatabaseName
			,[MasterSequenceRecords].SchemaName
			,[MasterSequenceRecords].TableName
			,[MasterSequenceRecords].Operation
			,[MasterSequenceRecords].[Message]
		FROM [Model].[Transitions]
		INNER JOIN [Audit].[MasterSequenceRecords]
				ON AuditSequenceId BETWEEN [Transitions].StartAuditSequenceId AND [Transitions].EndAuditSequenceId
		LEFT OUTER JOIN [Model].[ExcludedTables]
					 ON [MasterSequenceRecords].DatabaseName = [ExcludedTables].DatabaseName
					AND [MasterSequenceRecords].SchemaName = [ExcludedTables].SchemaName
					AND [MasterSequenceRecords].TableName = [ExcludedTables].TableName
		WHERE TransitionId = @TransitionId
		  AND [ExcludedTables].TableName IS NOT NULL
)
GO
