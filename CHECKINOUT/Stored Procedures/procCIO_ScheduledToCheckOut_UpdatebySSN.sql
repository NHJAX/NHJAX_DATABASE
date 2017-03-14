CREATE PROCEDURE [dbo].[procCIO_ScheduledToCheckOut_UpdatebySSN]
(
@ssn varchar(11),
@uby int
)
 AS

UPDATE ScheduledToCheckOut
SET CheckedOut = getdate(),
UpdatedBy = @uby
WHERE SSN = @ssn
AND CheckedOut IS NULL;



