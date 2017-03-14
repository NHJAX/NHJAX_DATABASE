

create PROCEDURE [dbo].[procODS_PATIENT_UpdateStateIdbyID]
	@pat bigint,
	@st bigint

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		StateId = @st,
		UpdatedDate = GetDate()
	WHERE PatientId = @pat
END

