DECLARE @AuditDatabase varchar(64) = 'FuDB'

PRINT 'USE [master]'
PRINT ''
PRINT 'ALTER DATABASE [' + @AuditDatabase + '] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE'
PRINT 'GO'
PRINT ''

PRINT 'DROP DATABASE  [' + @AuditDatabase + '];'
PRINT 'GO'
PRINT ''