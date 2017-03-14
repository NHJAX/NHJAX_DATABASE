CREATE VIEW [dbo].[vwMinSecurityLevel]
AS
SELECT     dbo.SECURITY_LEVEL.SecurityGroupId, dbo.SECURITY_LEVEL.SecurityLevelId
FROM         dbo.SECURITY_LEVEL INNER JOIN
                      dbo.vwMinSecurityLevelByGroup ON dbo.SECURITY_LEVEL.SecurityGroupId = dbo.vwMinSecurityLevelByGroup.SecurityGroupId AND 
                      dbo.SECURITY_LEVEL.SecurityLevel = dbo.vwMinSecurityLevelByGroup.MinSecurityLevel

