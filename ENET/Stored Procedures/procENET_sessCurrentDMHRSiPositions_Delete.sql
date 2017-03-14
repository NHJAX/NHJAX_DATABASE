

create PROCEDURE [dbo].[procENET_sessCurrentDMHRSiPositions_Delete]
(
	@key bigint
)
AS
	

DELETE FROM sessCurrentDMHRSiPositions
WHERE CurrentDMHRSiPositionsId = @key;



