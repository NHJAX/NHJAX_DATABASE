
CREATE PROCEDURE dbo.upOR_SetLatexAllergy
(
	@key decimal,
	@ltx bit
)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE PATIENT
	SET LatexAllergy = @ltx
	WHERE PatientKey = @key
END
