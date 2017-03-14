create PROCEDURE [dbo].[procENET_TECHNICIAN_TIMEKEEPER_TYPE_Select]
(
	@usr int
)
 AS

SELECT     
	TechnicianTimekeeperTypeId, 
	UserId, 
	TimekeeperTypeId, 
	AudienceId
FROM TECHNICIAN_TIMEKEEPER_TYPE
WHERE UserId = @usr

