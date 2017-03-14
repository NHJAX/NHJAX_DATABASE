

create PROCEDURE [dbo].[upOR_SetLatexAllergybyId]
(
	@pat bigint,
	@ltx bit
)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE PATIENT
	SET LatexAllergy = @ltx
	WHERE PatientId = @pat
END

