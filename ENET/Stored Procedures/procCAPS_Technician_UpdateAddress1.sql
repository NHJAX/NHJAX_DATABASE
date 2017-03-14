CREATE PROCEDURE [dbo].[procCAPS_Technician_UpdateAddress1]
(
	@usr int,
	@uby int,
	@udate datetime,
	@add1 varchar(100)
)
AS
UPDATE TECHNICIAN SET
	Address1 = @add1,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


