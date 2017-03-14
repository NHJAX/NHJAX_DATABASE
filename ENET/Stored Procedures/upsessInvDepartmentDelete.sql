CREATE PROCEDURE [dbo].[upsessInvDepartmentDelete]
(
	@tech int
)
AS
DELETE     	
FROM         	sessINV_DEPARTMENT
WHERE	CreatedBy = @tech

