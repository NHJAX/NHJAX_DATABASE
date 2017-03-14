

create PROCEDURE [dbo].[procENET_sessCurrentDMHRSiPositions_Select]
	@proc bit
AS
BEGIN
	
	SET NOCOUNT ON;

	IF @proc = 0
	BEGIN
    SELECT     
		CurrentDMHRSiPositionsId, 
		OrganizationName, 
		OfficialPositionName, 
		PositionStartDate, 
		PositionService, 
		PositionUIC, 
		PositionBillet, 
		PositionTitle, 
		Blank, 
		PositionRank, 
		PositionManpowerType, 
		DMHRSiPositionNumber, 
		HiringStatus, 
		BIN, 
		PositionJob, 
		CreatedDate, 
		CreatedBy, 
		IsProcessed
	FROM sessCurrentDMHRSiPositionsy
	WHERE IsProcessed = 0
	END
	ELSE
	BEGIN
	SELECT     
		CurrentDMHRSiPositionsId, 
		OrganizationName, 
		OfficialPositionName, 
		PositionStartDate, 
		PositionService, 
		PositionUIC, 
		PositionBillet, 
		PositionTitle, 
		Blank, 
		PositionRank, 
		PositionManpowerType, 
		DMHRSiPositionNumber, 
		HiringStatus, 
		BIN, 
		PositionJob, 
		CreatedDate, 
		CreatedBy, 
		IsProcessed
	FROM sessCurrentDMHRSiPositionsy
	WHERE IsProcessed = 1
	END
END



