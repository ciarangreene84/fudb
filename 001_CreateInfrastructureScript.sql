DECLARE @AuditDatabase varchar(64) = 'FuDB'
DECLARE @AuditSchema varchar(64) = 'Audit'


PRINT 'USE [master]'
PRINT ''
PRINT 'CREATE DATABASE [' + @AuditDatabase + ']'
PRINT 'GO'
PRINT ''

PRINT 'USE [' + @AuditDatabase + '];'
PRINT 'GO'
PRINT ''

PRINT 'CREATE SCHEMA [' + @AuditSchema + ']'
PRINT 'GO'
PRINT ''

PRINT 'CREATE SEQUENCE [' + @AuditSchema + '].[AuditSequence] '
PRINT REPLICATE(CHAR(9), 1) + 'AS [int]'
PRINT REPLICATE(CHAR(9), 1) + 'START WITH 1'
PRINT REPLICATE(CHAR(9), 1) + 'INCREMENT BY 1'
PRINT REPLICATE(CHAR(9), 1) + 'MINVALUE 1'
PRINT REPLICATE(CHAR(9), 1) + 'MAXVALUE 2147483647'
PRINT 'GO'
PRINT ''

PRINT 'CREATE TABLE [' + @AuditSchema + '].[MasterSequenceRecords] '
PRINT '('
PRINT REPLICATE(CHAR(9), 1) + 'AuditSequenceId [int] NOT NULL, '
PRINT REPLICATE(CHAR(9), 1) + 'DatabaseName varchar(256) NOT NULL,'
PRINT REPLICATE(CHAR(9), 1) + 'SchemaName varchar(256) NOT NULL,'
PRINT REPLICATE(CHAR(9), 1) + 'TableName varchar(256) NOT NULL,'
PRINT REPLICATE(CHAR(9), 1) + '[Operation] [varchar](8) NOT NULL,'
PRINT REPLICATE(CHAR(9), 1) + '[Message] [varchar](MAX) NULL'
PRINT ')'
PRINT 'GO'
PRINT ''

PRINT 'ALTER TABLE [' + @AuditSchema + '].[MasterSequenceRecords] ADD  CONSTRAINT [PK_MasterSequenceRecords] PRIMARY KEY CLUSTERED '
PRINT '('
PRINT REPLICATE(CHAR(9), 1) + '[AuditSequenceId] ASC'
PRINT ')'
PRINT 'GO'
PRINT ''
