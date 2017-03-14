

create PROCEDURE [dbo].[procENET_sessEASIVSummary_UpdateProcessed]
	@id bigint
AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE sessEASIVSummary
	SET IsProcessed = 1
	WHERE EASIVSummaryId = @id
END
