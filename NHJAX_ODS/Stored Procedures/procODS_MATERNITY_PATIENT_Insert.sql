
CREATE PROCEDURE [dbo].[procODS_MATERNITY_PATIENT_Insert]
(
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
DECLARE @NewMaternityPatientId int
DECLARE @xmlAfter as xml

INSERT INTO MATERNITY_PATIENT
(
	PatientId,
	EDC,
	MaternityStatusId,
	Notes,
	MaternityTeamId,
	CreatedBy,
	UpdatedBy,
	FPProviderId
)
VALUES
(
	@pat,
	@edc,
	@stat,
	@com,
	@tm,
	@cby,
	@cby,
	@fpro
)

SET @NewMaternityPatientId = SCOPE_IDENTITY();

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
  WHERE [MaternityPatientId] = @NewMaternityPatientId
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
VALUES (1, 'MATERNITY_PATIENT',@NewMaternityPatientId,NULL,@xmlAfter,getdate(),@cby)

END

return 1
