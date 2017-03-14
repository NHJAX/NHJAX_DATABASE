create PROCEDURE [dbo].[procENET_TECHNICIAN_LastUpdated]
(
	@usr		int
)
 AS

SELECT UpdatedDate
FROM TECHNICIAN
WHERE UserId = @usr

