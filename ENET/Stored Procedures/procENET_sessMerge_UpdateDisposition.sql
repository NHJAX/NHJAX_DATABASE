CREATE PROCEDURE [dbo].[procENET_sessMerge_UpdateDisposition]
(
	@ast int
)
AS
	BEGIN TRANSACTION
	
	UPDATE ASSET
    SET DispositionId = 7,
	UpdateSourceSystemId = 25
    WHERE AssetId = @ast;
	COMMIT TRANSACTION




