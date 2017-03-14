create PROCEDURE [dbo].[procCIO_ScheduledToCheckOut_Delete]
(
@sch bigint
)
 AS

DELETE
FROM ScheduledToCheckOut
WHERE ScheduledCheckOutId = @sch;



