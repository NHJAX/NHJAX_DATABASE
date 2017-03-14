CREATE PROCEDURE [dbo].[procCIO_CheckIn_Parameters_Delete]
(
@stp bigint,
@bas int,
@desg int, 
@max int,
@srt int
)
 AS

DELETE CHECKIN_PARAMETER
WHERE CheckInStepId = @stp
AND BaseId = @bas
AND DesignationId = @desg
AND CheckInTypeId = 1;

IF @srt < @max
	BEGIN
	UPDATE CHECKIN_PARAMETER
	SET DefaultSortOrder = DefaultSortOrder - 1
	WHERE BaseId = @bas
	AND DesignationId = @desg
	AND DefaultSortOrder > @srt
	AND CheckInTypeId = 1
	END




