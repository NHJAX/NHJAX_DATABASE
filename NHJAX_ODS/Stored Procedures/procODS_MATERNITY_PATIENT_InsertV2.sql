
CREATE PROCEDURE [dbo].[procODS_MATERNITY_PATIENT_InsertV2]
(
	@ParameterTable dbo.ProcedureParameters READONLY

)
AS
	SET NOCOUNT ON;

BEGIN

DECLARE @pat bigint
DECLARE @edc datetime
DECLARE @stat int
DECLARE @com varchar(8000)
DECLARE @tm int
DECLARE @cby int
DECLARE @fpro int

SELECT @pat = CONVERT(bigint,ParameterIntegerValue) FROM @ParameterTable WHERE ParameterName = 'PatientId'
SELECT @edc = ParameterDateTimeValue FROM @ParameterTable WHERE ParameterName = 'PatientEDC'
SELECT @stat = ParameterIntegerValue FROM @ParameterTable WHERE ParameterName = 'PatientStatus'
SELECT @com = ISNULL(ParameterVarcharValue,'') FROM @ParameterTable WHERE ParameterName = 'PatientComments'
SELECT @tm = ParameterIntegerValue FROM @ParameterTable WHERE ParameterName = 'PatientTeamId'
SELECT @cby = ParameterIntegerValue FROM @ParameterTable WHERE ParameterName = 'CreatedById'
SELECT @fpro = ParameterIntegerValue FROM @ParameterTable WHERE ParameterName = 'FPProviderId'



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
