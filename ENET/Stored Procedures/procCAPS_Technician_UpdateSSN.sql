create PROCEDURE [dbo].[procCAPS_Technician_UpdateSSN]
(
	@usr int,
	@uby int,
	@udate datetime,
	@ssn varchar(11)
)
AS
UPDATE TECHNICIAN SET
	SSN = @ssn,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


