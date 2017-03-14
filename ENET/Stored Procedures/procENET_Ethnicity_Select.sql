
create PROCEDURE [dbo].[procENET_Ethnicity_Select]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 
	EthnicityId,
	EthnicityDesc
FROM ETHNICITY
WHERE EthnicityId > 0
ORDER BY EthnicityDesc
END

