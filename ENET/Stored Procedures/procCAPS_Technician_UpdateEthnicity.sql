create PROCEDURE [dbo].[procCAPS_Technician_UpdateEthnicity]
(
	@usr int,
	@uby int,
	@udate datetime,
	@eth int
)
AS
UPDATE TECHNICIAN SET
	EthnicityId = @eth,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


