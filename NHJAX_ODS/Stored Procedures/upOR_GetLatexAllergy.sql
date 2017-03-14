
CREATE PROCEDURE dbo.upOR_GetLatexAllergy
(
	@key decimal
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT LatexAllergy
	FROM PATIENT
	WHERE PatientKey = @key
END
