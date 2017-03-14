CREATE PROCEDURE [dbo].[upTechnicianUpdatebySSN]
(
	@ssn varchar(11),
	@uby int,
	@udate datetime
)
AS
UPDATE TECHNICIAN SET
	Inactive = 1,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE SSN = @ssn;
