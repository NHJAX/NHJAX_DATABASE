CREATE PROCEDURE [dbo].[procCIO_CheckIn_Parameters_Update]
(
@stp bigint,
@bas int,
@desg int, 
@info varchar(100),
@uby int
)
 AS

UPDATE CHECKIN_PARAMETER
SET
SpecialInformation = @info,
UpdatedBy = @uby,
UpdatedDate = getdate()
WHERE CheckInStepId = @stp
AND BaseId = @bas
AND DesignationId = @desg
AND CheckInTypeId = 1;




