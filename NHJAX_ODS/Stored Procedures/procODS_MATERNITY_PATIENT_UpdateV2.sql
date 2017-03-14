
CREATE PROCEDURE [dbo].[procODS_MATERNITY_PATIENT_UpdateV2]
(
	@ParameterTable dbo.ProcedureParameters READONLY
)
AS
	SET NOCOUNT ON;

BEGIN
DECLARE @matpat bigint
DECLARE @pat bigint
DECLARE @edc datetime
DECLARE @stat int
DECLARE @com varchar(8000)
DECLARE @tm int
DECLARE @cby int
DECLARE @fpro int

SELECT @matpat = CONVERT(bigint,ParameterIntegerValue) FROM @ParameterTable WHERE ParameterName = 'PatientId'
/*
Note the Page Javascript pulls the "MaternityPatientId not the PatientId, even though its labeled PatientId its
really the MaternityPatientId coming into the proc. REE 11-2-2015
*/
SELECT @edc = ParameterDateTimeValue FROM @ParameterTable WHERE ParameterName = 'PatientEDC'
SELECT @stat = ParameterIntegerValue FROM @ParameterTable WHERE ParameterName = 'PatientStatus'
SELECT @com = ParameterVarcharValue FROM @ParameterTable WHERE ParameterName = 'PatientComments'
SELECT @tm = ParameterIntegerValue FROM @ParameterTable WHERE ParameterName = 'PatientTeamId'
SELECT @cby = ParameterIntegerValue FROM @ParameterTable WHERE ParameterName = 'CreatedById'
SELECT @fpro = ParameterIntegerValue FROM @ParameterTable WHERE ParameterName = 'FPProviderId'

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


