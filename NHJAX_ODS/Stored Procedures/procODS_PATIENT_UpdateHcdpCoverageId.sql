

create PROCEDURE [dbo].[procODS_PATIENT_UpdateHcdpCoverageId]
	@pat decimal,
	@hcdp bigint

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		HcdpCoverageId = @hcdp,
		UpdatedDate = GetDate()
	WHERE PatientKey = @pat
END

