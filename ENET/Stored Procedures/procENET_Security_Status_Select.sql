create PROCEDURE [dbo].[procENET_Security_Status_Select]

 AS

SELECT     
	SecurityStatusId, 
	SecurityStatusDesc,		
	CreatedDate
FROM SECURITY_STATUS
ORDER BY SecurityStatusDesc

