CREATE VIEW [dbo].[vwCountOfAssignments]
AS
SELECT    
	AssetId, 
	COUNT(AssignedTo) AS CountOfAssignments,
	SUM(CASE PRIMARYUser WHEN 1 THEN 1 ELSE 0 END) AS SumOfAssignments
FROM         
	dbo.ASSET_ASSIGNMENT
WHERE dbo.ASSET_ASSIGNMENT.Inactive = 0
GROUP BY AssetId




