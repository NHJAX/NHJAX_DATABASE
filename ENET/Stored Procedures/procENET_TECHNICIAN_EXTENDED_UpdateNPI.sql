create PROCEDURE [dbo].[procENET_TECHNICIAN_EXTENDED_UpdateNPI]
(
	@usr int,
	@npi numeric(16,3),
	@uby int
)
 AS

--prevent errors in the event of a duplicate
UPDATE TECHNICIAN_EXTENDED
SET NPIKey = @npi,
UpdatedBy = @uby
WHERE UserId = @usr;

