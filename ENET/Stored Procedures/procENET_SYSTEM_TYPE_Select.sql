
CREATE PROCEDURE [dbo].[procENET_SYSTEM_TYPE_Select]
(
	@sys int
)
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
WHERE SystemId = @sys
ORDER BY SystemDesc
END

