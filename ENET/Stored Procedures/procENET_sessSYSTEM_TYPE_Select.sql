create PROCEDURE [dbo].[procENET_sessSYSTEM_TYPE_Select]
(
	@tech int
)
AS
SELECT STYP.SystemId,
	STYP.SystemDesc
FROM SYSTEM_TYPE AS STYP
WHERE STYP.SystemId NOT IN (
	SELECT sessSYSTEM_TYPE.SystemTypeId
	FROM sessSYSTEM_TYPE
	WHERE sessSYSTEM_TYPE.CreatedBy = @tech)
ORDER BY STYP.SystemDesc
