CREATE VIEW [dbo].[vwBases]
AS
SELECT     BaseId, BaseName, SortOrder, CreatedDate, CreatedBy, UpdatedDate, UpdatedBy, Inactive, BaseCode
FROM         dbo.BASE

