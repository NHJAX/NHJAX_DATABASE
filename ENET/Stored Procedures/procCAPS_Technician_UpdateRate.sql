create PROCEDURE [dbo].[procCAPS_Technician_UpdateRate]
(
	@usr int,
	@uby int,
	@udate datetime,
	@rate varchar(15)
)
AS
UPDATE TECHNICIAN SET
	Rate = @rate,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


