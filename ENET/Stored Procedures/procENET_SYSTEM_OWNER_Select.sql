
create PROCEDURE [dbo].[procENET_SYSTEM_OWNER_Select]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 
	SystemOwnerId,
	SystemOwnerDesc
FROM SYSTEM_OWNER
WHERE Inactive = 0
ORDER BY SystemOwnerDesc

END

