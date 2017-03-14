CREATE VIEW [dbo].[vwTechnicians]
AS
SELECT     UserId, UFName, ULName, UMName, Title, EMailAddress, DepartmentId, Location, LastFour, UPhone, Extension, Comments, UPager, ComputerName, 
                      SecurityLevelId, AltPhone, LoginId, CreatedDate, CreatedBy, UpdatedDate, UpdatedBy, Inactive, Password
FROM         dbo.TECHNICIAN

