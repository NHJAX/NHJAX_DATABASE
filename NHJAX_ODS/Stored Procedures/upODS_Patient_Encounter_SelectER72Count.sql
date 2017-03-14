
CREATE PROCEDURE dbo.upODS_Patient_Encounter_SelectER72Count
	(
		@pat bigint
	)
AS
BEGIN
	
	SET NOCOUNT ON;

SELECT     
	Count(PatientEncounterId)
FROM
	PATIENT_ENCOUNTER
WHERE
	(HospitalLocationId = 174) 
	AND (AppointmentDateTime > DATEADD(hh, - 72, GETDATE()))
	AND PatientId = @pat
END
