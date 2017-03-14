CREATE PROCEDURE [dbo].[upAIM_AssetUpdateMAC]
(
	@ast int,
	@mac varchar(50),
	@mac2 varchar(50)
)

AS

UPDATE ASSET
SET
	MacAddress = @mac,
	MacAddress2 = @mac2
WHERE
	AssetId = @ast
