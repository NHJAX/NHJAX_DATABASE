create PROCEDURE [dbo].[procENET_ASSET_SelectServers]

AS
SELECT AssetId, UPPER(NetworkName) AS ServerName
FROM ASSET
INNER JOIN DISPOSITION DISP 
ON DISP.DispositionId = ASSET.DispositionId
WHERE AssetSubtypeId = 2 AND DISP.ViewLevelId = 1
AND NetworkName <> ''
ORDER BY NetworkName

