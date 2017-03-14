CREATE PROCEDURE [dbo].[procCIO_ScheduledToCheckOut_Update]
(
@sch bigint,
@uby int
)
 AS

UPDATE ScheduledToCheckOut
SET CheckedOut = getdate(),
UpdatedBy = @uby
WHERE ScheduledCheckOutId = @sch
AND CheckedOut Is NULL;



