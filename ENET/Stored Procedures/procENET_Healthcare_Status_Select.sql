
CREATE PROCEDURE [dbo].[procENET_Healthcare_Status_Select]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 
	HealthcareStatusId,
	HealthcareStatusDesc
FROM HEALTHCARE_STATUS
WHERE HealthcareStatusId > 0
ORDER BY HealthcareStatusDesc
END

