
create PROCEDURE [dbo].[procODS_DEPARTMENT_SelectbyKey]
(
	@key numeric(9,3)
)
AS
	SET NOCOUNT ON;
SELECT     
	DepartmentId,
	DepartmentKey,
	DepartmentDesc,
	DepartmentAbbrev,
	CreatedDate,
	UpdatedDate
FROM DEPARTMENT
WHERE (DepartmentKey = @key)
