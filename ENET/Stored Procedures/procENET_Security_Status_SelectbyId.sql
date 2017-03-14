create PROCEDURE [dbo].[procENET_Security_Status_SelectbyId]
(
	@ss int
)
 AS

SELECT     
	SecurityStatusId, 
	SecurityStatusDesc,		
	CreatedDate
FROM SECURITY_STATUS
WHERE SecurityStatusId = @ss

