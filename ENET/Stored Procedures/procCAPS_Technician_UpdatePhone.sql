create PROCEDURE [dbo].[procCAPS_Technician_UpdatePhone]
(
	@usr int,
	@uby int,
	@udate datetime,
	@ph varchar(50)
)
AS
UPDATE TECHNICIAN SET
	UPhone = @ph,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


