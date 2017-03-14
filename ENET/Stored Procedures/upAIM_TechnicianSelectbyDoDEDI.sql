
CREATE PROCEDURE [dbo].[upAIM_TechnicianSelectbyDoDEDI]
(
	@dod nvarchar(10)
)
AS

SELECT     
	Count(UserId)
FROM   TECHNICIAN
WHERE
	DoDEDI = @dod;

