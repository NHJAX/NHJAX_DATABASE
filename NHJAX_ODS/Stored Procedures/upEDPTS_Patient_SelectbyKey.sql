CREATE PROCEDURE [dbo].[upEDPTS_Patient_SelectbyKey]
	@pat decimal
AS
BEGIN
	
	SET NOCOUNT ON;

    SELECT PatientKey,
	FullName,
	DisplayAge,
	SponsorSSN,
	RIGHT(SponsorSSN,4) AS SSN,
	PatientKey
	FROM PATIENT
	WHERE PatientKey = @pat
END
