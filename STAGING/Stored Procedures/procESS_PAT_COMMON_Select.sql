create PROCEDURE [dbo].[procESS_PAT_COMMON_Select]
(
	@adm datetime,
	@ess bigint
)
AS
	SET NOCOUNT ON;
SELECT     
	PatientKey,
	EssPatientKey,
	HospNo,
	ProviderName,
	MoveTime,
	EditTime,
	Unit,
	BedName,
	AdmTime
FROM ESS_PATCOMMON
WHERE (AdmTime = @adm
	AND EssPatientKey = @ess)
