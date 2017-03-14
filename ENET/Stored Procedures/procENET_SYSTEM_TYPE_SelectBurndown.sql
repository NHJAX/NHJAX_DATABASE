
CREATE PROCEDURE [dbo].[procENET_SYSTEM_TYPE_SelectBurndown]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 
	SystemId,
	SystemDesc,
	IsBurndown,
	IsManagedSystem,
	IsProcessOnly,
	DoNotDisplay,
	Notes,
	Inactive,
	SystemOwnerId
FROM SYSTEM_TYPE
WHERE Inactive = 0
AND IsBurndown = 1
ORDER BY SystemDesc
END

