CREATE VIEW [dbo].[vwPointOfContact]
AS

SELECT     AST.AssetId, CASE ISNULL(BASE.LeadTechId,38)
				WHEN 38 THEN
					7066 
				ELSE
					BASE.LeadTechId
			END AS POCid
FROM      BASE INNER JOIN
          BUILDING ON BASE.BaseId = BUILDING.BaseId RIGHT OUTER JOIN
          ASSET AST ON BUILDING.BuildingId = AST.BuildingId LEFT OUTER JOIN
          vwCountOfAssignments CNT ON AST.AssetId = CNT.AssetId LEFT OUTER JOIN
          AUDIENCE AUD ON AST.AudienceId = AUD.AudienceId
WHERE     (CNT.CountOfAssignments IS NULL)
UNION
SELECT     AST.AssetId, ASG.AssignedTo
FROM         ASSET AST LEFT OUTER JOIN
                      vwCountOfAssignments CNT ON AST.AssetId = CNT.AssetId INNER JOIN
                      ASSET_ASSIGNMENT ASG ON AST.AssetId = ASG.AssetId
WHERE     CNT.CountOfAssignments = 1 AND ASG.Inactive = 0
UNION
SELECT     ASG.AssetId, ASG.AssignedTo
FROM         ASSET_ASSIGNMENT ASG INNER JOIN
                      vwCountOfAssignments CNT ON ASG.AssetId = CNT.AssetId
WHERE     CNT.SumOfAssignments = 1 AND CNT.CountOfAssignments > 1 AND ASG.PrimaryUser = 1 AND ASG.Inactive = 0
UNION
SELECT DISTINCT ASG.AssetId, CASE ISNULL(BASE.LeadTechId,38)
				WHEN 38 THEN
					7066 
				ELSE
					BASE.LeadTechId
			END AS POCid
FROM      BASE INNER JOIN
          BUILDING ON BASE.BaseId = BUILDING.BaseId RIGHT OUTER JOIN
          ASSET AST INNER JOIN
          ASSET_ASSIGNMENT ASG ON AST.AssetId = ASG.AssetId INNER JOIN
          vwCountOfAssignments CNT ON ASG.AssetId = CNT.AssetId ON BUILDING.BuildingId = AST.BuildingId LEFT OUTER JOIN
          AUDIENCE AUD ON AST.DepartmentId = AUD.AudienceId

WHERE     CNT.SumOfAssignments <> 1 AND CNT.CountOfAssignments > 1 AND ASG.Inactive = 0
