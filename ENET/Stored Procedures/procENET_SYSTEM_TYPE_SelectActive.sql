
CREATE PROCEDURE [dbo].[procENET_SYSTEM_TYPE_SelectActive]

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
AND DoNotDisplay = 0
ORDER BY SystemDesc
END

