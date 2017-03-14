CREATE VIEW [dbo].[vwMinSecurityLevelByGroup]
AS
SELECT     SecurityGroupId, MIN(SecurityLevel) AS MinSecurityLevel
FROM         dbo.SECURITY_LEVEL
GROUP BY SecurityGroupId

