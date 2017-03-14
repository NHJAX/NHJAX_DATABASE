

create PROCEDURE [dbo].[procODS_PATIENT_UpdateStateId]
	@pat decimal,
	@st bigint

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		StateId = @st,
		UpdatedDate = GetDate()
	WHERE PatientKey = @pat
END

