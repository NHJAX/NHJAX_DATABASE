CREATE PROCEDURE [dbo].[procCAPS_Technician_UpdateAddress2]
(
	@usr int,
	@uby int,
	@udate datetime,
	@add2 varchar(100)
)
AS
UPDATE TECHNICIAN SET
	Address2 = @add2,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


