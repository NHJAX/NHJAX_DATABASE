
create PROCEDURE [dbo].[procENET_Designation_SelectbyId]
(
	@desg int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 
	DesignationId,
	DesignationDesc
FROM DESIGNATION
WHERE DesignationId = @desg

END

