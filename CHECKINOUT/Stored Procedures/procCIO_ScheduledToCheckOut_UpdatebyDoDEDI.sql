CREATE PROCEDURE [dbo].[procCIO_ScheduledToCheckOut_UpdatebyDoDEDI]
(
@dod nvarchar(10),
@uby int
)
 AS

UPDATE ScheduledToCheckOut
SET CheckedOut = getdate(),
UpdatedBy = @uby
WHERE DoDEDI = @dod
AND CheckedOut IS NULL;



