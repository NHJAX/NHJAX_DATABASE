create PROCEDURE [dbo].[procCAPS_Technician_UpdateState]
(
	@usr int,
	@uby int,
	@udate datetime,
	@state varchar(2)
)
AS
UPDATE TECHNICIAN SET
	State = @state,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


