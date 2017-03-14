

create PROCEDURE [dbo].[procENET_sessEASIVSummary_Delete]
(
	@key bigint
)
AS
	

DELETE FROM sessEASIVSummary
WHERE EASIVSummaryId = @key;



