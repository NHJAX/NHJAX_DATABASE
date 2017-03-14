


CREATE PROCEDURE [dbo].[procENet_GenericUpdate] 
AS
BEGIN

DECLARE @dept int
DECLARE @deptnew int
DECLARE @tech int
DECLARE @aud bigint
Declare @exists int

EXEC dbo.upLog 'Begin Audience Update';

	DECLARE curAud CURSOR FAST_FORWARD FOR
	SELECT 
	DepartmentId, UserId
	FROM Technician
	WHERE AudienceId Is NULL or AudienceId = 0

	OPEN curAud
	
	FETCH NEXT FROM curAud INTO @dept,@tech

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
				UPDATE TECHNICIAN
				SET AudienceId = 0
				WHERE UserId = @tech
			END
		ELSE
			BEGIN
				UPDATE TECHNICIAN
				SET AudienceId = @aud
				WHERE UserId = @tech
			END

			FETCH NEXT FROM curAud INTO @dept,@tech

		END
	END

	CLOSE curAud
	DEALLOCATE curAud

	EXEC dbo.upLog 'End Audience Update';

END






