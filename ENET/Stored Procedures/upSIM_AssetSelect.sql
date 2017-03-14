CREATE PROCEDURE [dbo].[upSIM_AssetSelect] 
(
	@network varchar(100)
)
AS
SELECT     
	ASSET.AssetId, 
	ASSET.NetworkName, 
	ISNULL(ASSET_FILE_SEARCH.SearchAll, 0) AS SearchAll, 
	ISNULL(ASSET_FILE_SEARCH.IncludeDefaults, 0) AS IncludeDefaults,
	ISNULL(ASSET_FILE_SEARCH.RunAudit,0) AS RunAudit
FROM
	ASSET 
	LEFT OUTER JOIN ASSET_FILE_SEARCH 
	ON ASSET.AssetId = ASSET_FILE_SEARCH.AssetId
WHERE (ASSET.NetworkName = @network) 
	AND (ASSET.DispositionId IN(0,1,9,14,15))
