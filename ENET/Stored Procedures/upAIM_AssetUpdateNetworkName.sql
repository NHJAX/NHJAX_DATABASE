CREATE PROCEDURE [dbo].[upAIM_AssetUpdateNetworkName]
(
	@ast int,
	@net varchar(100)
)

AS

UPDATE ASSET
SET
	NetworkName = @net
WHERE
	AssetId = @ast
