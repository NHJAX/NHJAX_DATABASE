create PROCEDURE [dbo].[procENET_Security_Group_HasAlternates]
(
	@grp int
)
 AS

SELECT     
	COUNT(SecurityGroupId) AS GrpCount
FROM
	SECURITY_GROUP
WHERE
	(SecurityGroupId = @grp) 
	AND (HasAlternates = 1)
