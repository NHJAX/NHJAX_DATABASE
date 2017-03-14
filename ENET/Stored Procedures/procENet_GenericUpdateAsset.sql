


CREATE PROCEDURE [dbo].[procENet_GenericUpdateAsset] 
AS
BEGIN

DECLARE @dept int
DECLARE @deptnew int
DECLARE @ast int
DECLARE @aud bigint
Declare @exists int


	DECLARE curAud CURSOR FAST_FORWARD FOR
	SELECT 
	DepartmentId, AssetId
	FROM Asset
	WHERE AudienceId Is NULL

	OPEN curAud
	
	FETCH NEXT FROM curAud INTO @dept,@ast

	if(@@FETCH_STATUS = 0)

	BEGIN

		WHILE(@@FETCH_STATUS = 0)
		BEGIN
		SELECT	TOP 1 @aud = AudienceId
		FROM	AUDIENCE
		WHERE	(OldDepartmentId = @dept)
		AND AudienceCategoryId = 3
		SET @exists = @@RowCount


		If @exists = 0 
			BEGIN
				UPDATE ASSET
				SET AudienceId = 0
				WHERE AssetId = @ast
			END
		ELSE
			BEGIN
				UPDATE ASSET
				SET AudienceId = @aud
				WHERE AssetId = @ast
			END

			FETCH NEXT FROM curAud INTO @dept,@ast

		END
	END

	CLOSE curAud
	DEALLOCATE curAud


END







