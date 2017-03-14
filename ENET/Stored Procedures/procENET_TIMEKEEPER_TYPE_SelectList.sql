
create PROCEDURE [dbo].[procENET_TIMEKEEPER_TYPE_SelectList]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 
	TimekeeperTypeId,
	TimekeeperTypeDesc
FROM TIMEKEEPER_TYPE

END

