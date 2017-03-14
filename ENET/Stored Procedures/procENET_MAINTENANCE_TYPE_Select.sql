
create PROCEDURE [dbo].[procENET_MAINTENANCE_TYPE_Select]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 
	MaintenanceTypeId,
	MaintenanceTypeDesc
FROM MAINTENANCE_TYPE

END

