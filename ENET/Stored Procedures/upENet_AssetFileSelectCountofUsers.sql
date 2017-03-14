CREATE PROCEDURE [dbo].[upENet_AssetFileSelectCountofUsers] 
(
	@sft int
)
AS
SELECT ISNULL(COUNT(AssetFileId),0)
FROM ASSET_FILE
WHERE SoftwareId = @sft
AND Removed = 0

