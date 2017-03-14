

CREATE PROCEDURE [dbo].[AAA_ManualRun]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Exec [nhjax-cache].STAGING.dbo.upCreateIndexes_Prescription
	EXEC [nhjax-cache].STAGING.dbo.upCreateIndexes_Prescription$Fill_Dates
	
	
	exec dbo.upODS_LabresultChemistryResult
	
	exec dbo.upODS_PatientOrder

	exec [nhjax-cache].STAGING.dbo.upSTG_PATIENT_ACTIVITY
	exec dbo.upODS_Patient
	exec dbo.upODS_PatientActivity
	exec dbo.upODS_PatientAllergy
	
	exec dbo.upODS_AppointmentAuditTrail	
	exec dbo.upODS_PrimaryCareManager

	exec dbo.upODS_PHMammo_Patient_Encounters

	exec dbo.upODS_DM_CIP_Encounter
	exec dbo.upODS_DM_CIP_Order

	exec dbo.upODS_Labresults
	exec dbo.upODS_Procedure
	exec dbo.upODS_PatientEncounter
	exec dbo.upODS_AppointmentAuditTrail
	exec dbo.upODS_EncounterDiagnosis
END










