CREATE VIEW [dbo].[vwAssetAssignments]
AS
SELECT     AssignmentId, AssetId, AssignedTo, CreatedDate, CreatedBy, UpdatedDate, UpdatedBy, Inactive, PrimaryUser
FROM         dbo.ASSET_ASSIGNMENT

