CREATE PROCEDURE [dbo].[procODS_MATERNITY_PATIENT_ServiceUpdate]
@matpat bigint = 0, @pat bigint = 0, @itemstringvalue varchar(8000), @itemname nvarchar(50), @itemintvalue int = 0, @itemdatevalue datetime, @userid int = 0
WITH EXEC AS CALLER
AS
SET NOCOUNT ON;

BEGIN
DECLARE @xmlBefore as xml
DECLARE @xmlAfter as xml

SET @xmlBefore = (
SELECT [MaternityPatientId]
      ,[PatientId]
      ,[EDC]
      ,[MaternityStatusId]
      ,[Notes]
      ,[MaternityTeamId]
      ,[CreatedDate]
      ,[UpdatedDate]
      ,[CreatedBy]
      ,[UpdatedBy]
      ,[FPProviderId]
  FROM [NHJAX_ODS].[dbo].[MATERNITY_PATIENT] as maternitypatient
  WHERE [MaternityPatientId] = @matpat
  FOR XML AUTO, ELEMENTS, ROOT('maternitypatients')
)

IF @itemname = 'TEAMUPDATE'
  BEGIN
    UPDATE [NHJAX_ODS].[dbo].[MATERNITY_PATIENT]
       SET [MaternityTeamId] = @itemintvalue
          ,[UpdatedDate] = getdate()
          ,[UpdatedBy] = @userid
     WHERE [MaternityPatientId] = @matpat
     AND [PatientId] = @pat
  END
IF @itemname = 'PROVIDERUPDATE'
  BEGIN
    UPDATE [NHJAX_ODS].[dbo].[MATERNITY_PATIENT]
       SET [FPProviderId] = @itemintvalue
          ,[UpdatedDate] = getdate()
          ,[UpdatedBy] = @userid
     WHERE [MaternityPatientId] = @matpat
     AND [PatientId] = @pat
  END
IF @itemname = 'STATUSUPDATE'
  BEGIN
    UPDATE [NHJAX_ODS].[dbo].[MATERNITY_PATIENT]
       SET [MaternityStatusId] = @itemintvalue
          ,[UpdatedDate] = getdate()
          ,[UpdatedBy] = @userid
     WHERE [MaternityPatientId] = @matpat
     AND [PatientId] = @pat
  END
IF @itemname = 'EDCUPDATE'
  BEGIN
    UPDATE [NHJAX_ODS].[dbo].[MATERNITY_PATIENT]
       SET [EDC] = @itemdatevalue
          ,[UpdatedDate] = getdate()
          ,[UpdatedBy] = @userid
     WHERE [MaternityPatientId] = @matpat
     AND [PatientId] = @pat  
  END
IF @itemname = 'COMMENTUPDATE'
  BEGIN
    UPDATE [NHJAX_ODS].[dbo].[MATERNITY_PATIENT]
       SET [Notes] = @itemstringvalue
          ,[UpdatedDate] = getdate()
          ,[UpdatedBy] = @userid
     WHERE [MaternityPatientId] = @matpat
     AND [PatientId] = @pat
  END

SET @xmlAfter = (
SELECT [MaternityPatientId]
      ,[PatientId]
      ,[EDC]
      ,[MaternityStatusId]
      ,[Notes]
      ,[MaternityTeamId]
      ,[CreatedDate]
      ,[UpdatedDate]
      ,[CreatedBy]
      ,[UpdatedBy]
      ,[FPProviderId]
  FROM [NHJAX_ODS].[dbo].[MATERNITY_PATIENT] as maternitypatient
  WHERE [MaternityPatientId] = @matpat
  FOR XML AUTO, ELEMENTS, ROOT('maternitypatients')
)
INSERT INTO [NHJAX_ODS].[dbo].[AUDIT_LOG]
           ([AuditTypeId]
           ,[TargetTableName]
           ,[TargetRecordId]
           ,[DataBefore]
           ,[DataAfter]
           ,[EntryDate]
           ,[UserId])
VALUES (2, 'MATERNITY_PATIENT',@matpat,@xmlBefore,@xmlAfter,getdate(),@userid)


END