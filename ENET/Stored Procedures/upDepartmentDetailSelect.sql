CREATE PROCEDURE [dbo].[upDepartmentDetailSelect]
(
@deptid int
)
AS

SELECT 
	D.DepartmentId,
       	D.DCBILLET,
             	D.DepartmentCode,
            	D.Inactive,
            	D.DepartmentHeadId,
	TECH.EMailAddress,
	D.DirectorateId,
	D.DeptPhone,
	D.DeptFax,
	D.DeptPager
FROM DEPARTMENT D
LEFT OUTER  JOIN TECHNICIAN TECH
ON D.DepartmentHeadId = TECH.UserId
WHERE D.DepartmentId = @deptid
