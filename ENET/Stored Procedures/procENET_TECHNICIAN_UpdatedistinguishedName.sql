create PROCEDURE [dbo].[procENET_TECHNICIAN_UpdatedistinguishedName]
(
@dist varchar(255), 
@usr int
)
 AS

UPDATE TECHNICIAN
SET distinguishedName = @dist
WHERE UserId = @usr;



