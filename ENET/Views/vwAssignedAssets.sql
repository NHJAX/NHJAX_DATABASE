﻿CREATE VIEW [dbo].[vwAssignedAssets] AS 

SELECT AssetId 
FROM ASSET_ASSIGNMENT
 WHERE PrimaryUser = 1 

UNION 
SELECT AssetId 
FROM ASSET_ASSIGNMENT 
GROUP BY AssetId 
HAVING (COUNT(AssignedTo) = 1) 

