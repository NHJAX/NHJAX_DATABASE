

create PROCEDURE [dbo].[upOR_GetLatexAllergyById]
(
	@pat bigint
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT LatexAllergy
	FROM PATIENT
	WHERE PatientId = @pat
END

