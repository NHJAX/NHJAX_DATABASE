create PROCEDURE [dbo].[procENET_TECHNICIAN_UpdateLB]
(
@usr int, 
@lb bit,
@uby int
)
 AS

UPDATE TECHNICIAN
SET LB = @lb,
LBBy = @uby,
LBDate = getdate()
WHERE UserId = @usr;



