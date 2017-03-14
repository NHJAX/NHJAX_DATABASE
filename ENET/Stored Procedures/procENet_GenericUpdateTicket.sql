


CREATE PROCEDURE [dbo].[procENet_GenericUpdateTicket] 
AS
BEGIN

DECLARE @dept int
DECLARE @deptnew int
DECLARE @tkt int
DECLARE @aud bigint
Declare @exists int

EXEC dbo.upLog 'Begin Audience Update';

	DECLARE curAud CURSOR FAST_FORWARD FOR
	SELECT 
	DepartmentId, TicketId
	FROM Ticket
	WHERE AudienceId Is NULL or AudienceId = 0

	OPEN curAud
	
	FETCH NEXT FROM curAud INTO @dept,@tkt

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
				UPDATE TICKET
				SET AudienceId = 0
				WHERE TicketId = @tkt
			END
		ELSE
			BEGIN
				UPDATE TICKET
				SET AudienceId = @aud
				WHERE TicketId = @tkt
			END

			FETCH NEXT FROM curAud INTO @dept,@tkt

		END
	END

	CLOSE curAud
	DEALLOCATE curAud

	EXEC dbo.upLog 'End Audience Update';

END





