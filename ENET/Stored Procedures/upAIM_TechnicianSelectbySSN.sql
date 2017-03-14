
CREATE PROCEDURE [dbo].[upAIM_TechnicianSelectbySSN]
(
	@ssn varchar(11)
)
AS

SELECT     
	Count(UserId)
FROM   TECHNICIAN
WHERE
	SSN = @ssn;

