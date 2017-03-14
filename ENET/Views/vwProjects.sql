CREATE VIEW [dbo].[vwProjects]
AS
SELECT     ProjectId, ProjectDesc, CreatedDate, CreatedBy, UpdatedDate, UpdatedBy, Inactive
FROM         dbo.PROJECT

