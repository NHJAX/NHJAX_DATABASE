CREATE PROCEDURE [dbo].[procAIM_AssetUpdateRestricted]
(
	@aud bigint,
	@bldg int,
	@deck int,
	@room varchar(50),
	@mac	varchar(50),
	@mac2 varchar(50) = '',
	@udate datetime,
	@uby int,
	@network varchar(100)
)
AS

IF DataLength(@mac2) > 0
	BEGIN
		UPDATE ASSET SET
		AudienceId = @aud,
		BuildingId = @Bldg,
		DeckId = @Deck,
		Room = @Room,
		MacAddress = @Mac,
		DispositionId = 1, 
		UpdateSourceSystemId = 23,
		MacAddress2 = @mac2,
		UpdatedDate = @UDate,
		UpdatedBy = @UBy
		WHERE DispositionId IN(SELECT DispositionId FROM DISPOSITION WHERE ViewLevelId = 1)
		AND NetworkName = @network
	END
ELSE
	BEGIN
		UPDATE ASSET SET
		AudienceId = @aud,
		BuildingId = @Bldg,
		DeckId = @Deck,
		Room = @Room,
		MacAddress = @Mac,
		DispositionId = 1, 
		UpdateSourceSystemId = 23,
		UpdatedDate = @UDate,
		UpdatedBy = @UBy
		WHERE DispositionId IN(SELECT DispositionId FROM DISPOSITION WHERE ViewLevelId = 1)
		AND NetworkName = @network
	END	

