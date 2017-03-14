
CREATE PROCEDURE [dbo].[procFLOW_SecurityGroup_Select]

AS
SELECT SecurityGroupId,
	SecurityGroupDesc
FROM SECURITY_GROUP
WHERE inactive = 0
and securitygroupid > 0
ORDER BY SecurityGroupDesc


