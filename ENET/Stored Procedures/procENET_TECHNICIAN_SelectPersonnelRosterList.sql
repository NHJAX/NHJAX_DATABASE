create PROCEDURE [dbo].[procENET_TECHNICIAN_SelectPersonnelRosterList]

AS

SELECT     
	UserId, 
	RTRIM(UFName) AS UFName, 
	RTRIM(ULName) AS ULName, 
	RTRIM(UMName) AS UMName, 
	Suffix
FROM   dbo.vwENET_PERSONNEL_ROSTER
ORDER BY ULName, UFName, UMName






