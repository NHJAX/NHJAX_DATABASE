
CREATE PROCEDURE [dbo].[procODS_MATERNITY_PATIENT_Update]
(
	@matpat bigint,
	@pat bigint,
	@edc datetime,
	@stat int,
	@com varchar(8000),
	@tm int,
	@cby int,
	@fpro int
)
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

UPDATE [NHJAX_ODS].[dbo].[MATERNITY_PATIENT]
   SET [EDC] = @edc
      ,[MaternityStatusId] = @stat
      ,[Notes] = @com
      ,[MaternityTeamId] = @tm
      ,[UpdatedDate] = getdate()
      ,[UpdatedBy] = @cby
      ,[FPProviderId] = @fpro
 WHERE [MaternityPatientId] = @matpat
 AND [PatientId] = @pat

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
VALUES (2, 'MATERNITY_PATIENT',@matpat,@xmlBefore,@xmlAfter,getdate(),@cby)


END


