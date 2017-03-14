create PROCEDURE [dbo].[procCAPS_Technician_UpdateOtherStu]
(
	@usr int,
	@uby int,
	@udate datetime,
	@oth varchar(50)
)
AS
UPDATE TECHNICIAN SET
	OtherStu = @oth,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


