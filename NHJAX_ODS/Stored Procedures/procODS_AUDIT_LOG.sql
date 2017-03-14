-- =============================================
-- Author:		Robert E Evans
-- Create date: 24 Aug 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[procODS_AUDIT_LOG]
	@AuditTable dbo.AuditLogType READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		INSERT INTO [AUDIT_LOG]
           ([AuditTypeId]
           ,[TargetTableName]
           ,[TargetRecordId]
           ,[DataBefore]
           ,[DataAfter]
           ,[EntryDate]
           ,[UserId])
        SELECT AT.[AuditTypeId]
			  ,AT.[TargetTableName]
			  ,AT.[TargetRecordId]
			  ,AT.[DataBefore]
			  ,AT.[DataAfter]
			  ,GETDATE()
			  ,AT.[UserId]
		  FROM @AuditTable as AT
	
END
