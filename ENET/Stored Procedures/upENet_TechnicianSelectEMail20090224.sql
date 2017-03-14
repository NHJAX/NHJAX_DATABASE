
CREATE PROCEDURE [dbo].[upENet_TechnicianSelectEMail20090224] AS
SELECT   
	TECH.UserId,  
	ISNULL(CAST(TECH.ULName + ', ' + TECH.UFName + ' ' + TECH.UMName as char(40)),'') AS AlphaTech,
	ISNULL(CAST(TECH.UPhone as char(20)),'') AS Phone,
            	ISNULL(CAST(TECH.Location as char(50)),'') AS Room,
	ISNULL(CAST(TECH.Title as char(50)),'') AS Title,
	ISNULL(CAST(DEPT.DCBILLET as char(45)),'') AS Department,
             ISNULL(CAST(TECH.EMailAddress as char(100)),'') AS EMail
FROM   TECHNICIAN TECH 
	INNER JOIN DEPARTMENT DEPT 
	ON TECH.DepartmentId = DEPT.DepartmentId
WHERE	(TECH.Inactive = 0) 
	AND (TECH.EMailAddress LIKE '%@med.navy.mil') 
ORDER BY TECH.ServiceAccount DESC, TECH.ULName, TECH.UFName, TECH.UMName


