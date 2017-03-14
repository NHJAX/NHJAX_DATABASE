
CREATE PROCEDURE [dbo].[procENET_Citizenship_Select]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 
	CitizenshipId,
	CitizenshipDesc
FROM CITIZENSHIP
WHERE CitizenshipId > 0
ORDER BY citizenshipid
END

