create PROCEDURE [dbo].[procENET_sessSYSTEM_TYPE_SelectList]
(
	@tech int
)
 AS

SELECT ST.SystemTypeId, 
	STYP.SystemDesc
FROM sessSYSTEM_TYPE ST
        	INNER JOIN SYSTEM_TYPE AS STYP
        	ON ST.SystemTypeId = STYP.SystemId
WHERE ST.CreatedBy = @tech 
ORDER BY STYP.SystemDesc
