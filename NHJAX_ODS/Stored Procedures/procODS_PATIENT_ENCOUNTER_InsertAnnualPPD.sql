
CREATE PROCEDURE [dbo].[procODS_PATIENT_ENCOUNTER_InsertAnnualPPD]
(
	@pat bigint,
	@dt datetime
)
AS
	SET NOCOUNT ON;
	
DECLARE @enc numeric(13,3)
BEGIN TRANSACTION

BEGIN TRY
	SET @enc = dbo.GenerateEncounterKey(@pat)
		
	UPDATE GENERATOR SET LastNumber=LastNumber+1
	WHERE GeneratorTypeId = 1

	INSERT INTO NHJAX_ODS.dbo.PATIENT_ENCOUNTER
	(
		EncounterKey,
		PatientAppointmentKey, 
		PatientId,
		AppointmentDateTime,
		ProviderId,
		AppointmentStatusId,
		ReasonForAppointment,
		SourceSystemId,
		DMISId
	) 
	VALUES
	(
		@enc,
		0,
		@pat,
		@dt,
		0,
		2,
		'Custom Annual PPD Record',
		8,
		1527
	);
	SELECT 1;
	COMMIT TRANSACTION	
END TRY	
BEGIN CATCH
	ROLLBACK TRANSACTION
	SELECT -1;
END CATCH
