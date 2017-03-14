CREATE PROCEDURE [dbo].[procENET_ASSET_SelectbyNetworkName]
(
	@net varchar(100)
)
AS
SELECT ASSET.AssetId, 
	UPPER(NetworkName) AS ServerName,
	ASSET_COMPUTER.ServerNotes,
	ASSET_COMPUTER.TimeToShutdown,
	ASSET_COMPUTER.ShutdownPriorityId,
	ASSET_COMPUTER.RackLocation,
	DISP.DispositionDesc,
	ASSET_COMPUTER.IsManagedServer
FROM ASSET
INNER JOIN DISPOSITION DISP 
	ON DISP.DispositionId = ASSET.DispositionId
	INNER JOIN ASSET_COMPUTER
	ON ASSET.AssetId = ASSET_COMPUTER.AssetId
WHERE AssetSubtypeId = 2 
	AND DISP.ViewLevelId = 1
	AND NetworkName LIKE '%' + @net + '%'
ORDER BY NetworkName

