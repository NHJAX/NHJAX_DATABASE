CREATE PROCEDURE [dbo].[procESS_TOBACCO_USE_Select]
(
	@key datetime,
	@ess bigint
)
AS
	SET NOCOUNT ON;
SELECT     
	KeyDate,
	EssPatientKey,
	PatientKey,
	Tobacco
FROM ESS_TOBACCO_USE
WHERE (KeyDate = @key
	AND EssPatientKey = @ess)
