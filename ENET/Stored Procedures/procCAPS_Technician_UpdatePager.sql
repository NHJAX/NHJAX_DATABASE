create PROCEDURE [dbo].[procCAPS_Technician_UpdatePager]
(
	@usr int,
	@uby int,
	@udate datetime,
	@pgr varchar(50)
)
AS
UPDATE TECHNICIAN SET
	UPager = @pgr,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


