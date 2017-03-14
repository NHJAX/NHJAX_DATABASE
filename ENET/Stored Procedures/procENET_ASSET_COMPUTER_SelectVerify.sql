create PROCEDURE [dbo].[procENET_ASSET_COMPUTER_SelectVerify]
(
	@id int
)
AS
SELECT AssetId
FROM ASSET_COMPUTER
WHERE AssetId = @id


