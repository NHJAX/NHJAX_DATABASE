

create PROCEDURE [dbo].[procODS_PATIENT_UpdateHcdpCoverageIdbyID]
	@pat bigint,
	@hcdp bigint

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		HcdpCoverageId = @hcdp,
		UpdatedDate = GetDate()
	WHERE PatientId = @pat
END

