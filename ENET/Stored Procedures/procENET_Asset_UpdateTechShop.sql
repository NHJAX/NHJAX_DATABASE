create PROCEDURE [dbo].[procENET_Asset_UpdateTechShop]
(
	@ast int,
	@disp int,
	@aud bigint,
	@bldg int,
	@deck int,
	@room varchar(50),
	@uby int	
	
)
AS
UPDATE ASSET 
        SET  
        DispositionId = @disp, 
        AudienceId = @aud,
        BuildingId = @bldg, 
        DeckId = @deck, 
        Room = @room, 
        UpdatedDate = GETDATE(), 
        UpdatedBy = @uby
        WHERE AssetId = @ast;


