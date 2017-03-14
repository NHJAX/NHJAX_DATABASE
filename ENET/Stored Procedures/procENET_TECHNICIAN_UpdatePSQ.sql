CREATE PROCEDURE [dbo].[procENET_TECHNICIAN_UpdatePSQ]
(
@usr int, 
@psq bit,
@uby int
)
 AS

UPDATE TECHNICIAN
SET PSQ = @psq,
PSQBy = @uby,
PSQDate = getdate()
WHERE UserId = @usr;



