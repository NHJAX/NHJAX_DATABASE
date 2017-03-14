CREATE PROCEDURE [dbo].[procCAPS_Technician_UpdateRank]
(
	@usr int,
	@uby int,
	@udate datetime,
	@rank int
)
AS
UPDATE TECHNICIAN SET
	RankId = @rank,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;
