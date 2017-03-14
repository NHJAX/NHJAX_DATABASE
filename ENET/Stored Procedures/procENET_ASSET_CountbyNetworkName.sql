CREATE PROCEDURE [dbo].[procENET_ASSET_CountbyNetworkName]
(
	@cn varchar(50)
)
 AS

SELECT 
	COUNT(AssetId)
FROM ASSET
INNER JOIN DISPOSITION
ON ASSET.DispositionId = DISPOSITION.DispositionId
WHERE NetworkName = @cn
AND DISPOSITION.ViewLevelId < 3

