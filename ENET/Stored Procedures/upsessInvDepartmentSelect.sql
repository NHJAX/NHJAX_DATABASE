CREATE PROCEDURE [dbo].[upsessInvDepartmentSelect]
(
	@tech int
)
AS
SELECT     	DepartmentId 
FROM         	sessINV_DEPARTMENT
WHERE	CreatedBy = @tech

