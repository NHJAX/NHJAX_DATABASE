create PROCEDURE [dbo].[procENET_TECHNICIAN_EXTENDED_UpdateException]
(
	@usr int,
	@exc bit
)
 AS

--prevent errors in the event of a duplicate
UPDATE TECHNICIAN_EXTENDED
SET IsException = @exc
WHERE UserId = @usr;

