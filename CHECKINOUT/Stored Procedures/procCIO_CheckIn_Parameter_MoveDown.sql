CREATE PROCEDURE [dbo].[procCIO_CheckIn_Parameter_MoveDown]
(
	@stp bigint,
	@srt int,
	@bas int,
	@desg int
)
 AS

BEGIN TRANSACTION
UPDATE CHECKIN_PARAMETER
SET DefaultSortOrder = (@srt)
WHERE DefaultSortOrder = (@srt + 1)
AND BaseId = @bas
AND DesignationId = @desg
AND CheckInTypeId = 1;

UPDATE CHECKIN_PARAMETER
SET DefaultSortOrder = (@srt + 1)
WHERE CheckInStepId = @stp
AND BaseId = @bas
AND DesignationId = @desg
AND CheckInTypeId = 1;

COMMIT


