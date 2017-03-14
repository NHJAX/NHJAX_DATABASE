

create PROCEDURE [dbo].[procENET_sessCurrentDMHRSiPositions_UpdateProcessed]
	@id bigint
AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE sessCurrentDMHRSiPositions
	SET IsProcessed = 1
	WHERE CurrentDMHRSiPositionsId = @id
END
