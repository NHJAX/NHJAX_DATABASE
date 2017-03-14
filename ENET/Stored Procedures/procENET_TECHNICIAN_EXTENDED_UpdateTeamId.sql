CREATE PROCEDURE [dbo].[procENET_TECHNICIAN_EXTENDED_UpdateTeamId]
(
	@usr int,
	@team int,
	@uby int
)
 AS

--prevent errors in the event of a duplicate
UPDATE TECHNICIAN_EXTENDED
SET TeamId = @team,
UpdatedBy = @uby
WHERE UserId = @usr;

