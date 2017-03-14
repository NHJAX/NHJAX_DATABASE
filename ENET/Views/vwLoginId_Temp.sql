CREATE VIEW [dbo].[vwLoginId_Temp]
AS
SELECT     UserId, LoginId, ULName, UFName, UMName, Inactive, EMailAddress, UpdatedDate, Location, SecurityLevelId, Title
FROM         dbo.TECHNICIAN
WHERE     (UserId > 119)

