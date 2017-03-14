create PROCEDURE [dbo].[procENET_TECHNICIAN_EXTENDED_UpdateTimekeeperTypeId]
(
	@usr int,
	@ttyp int,
	@uby int
)
 AS

--prevent errors in the event of a duplicate
UPDATE TECHNICIAN_EXTENDED
SET TimekeeperTypeId = @ttyp,
UpdatedBy = @uby
WHERE UserId = @usr;

