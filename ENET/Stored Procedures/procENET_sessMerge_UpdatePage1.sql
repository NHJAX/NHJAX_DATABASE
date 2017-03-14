create PROCEDURE [dbo].[procENET_sessMerge_UpdatePage1]
(
	@sess varchar(100),
	@pre varchar(50),
	@num varchar(50),
	@serial varchar(50),
	@mod int,
	@man int,
	@pro int,
	@atyp int,
	@disp int,
	@net varchar(50),
	@base int,
	@bldg int,
	@deck int,
	@aud bigint,
	@room varchar(50),
	@sub int,
	@poc int
)
AS
	BEGIN TRANSACTION
	
	UPDATE sessMERGE SET 
	PlantAccountPrefix = @pre,
    PlantAccountNumber = @num,
    SerialNumber = @serial,
    ModelId = @mod,
    ManufacturerId = @man,
    ProjectId = @pro,
    AssetTypeId = @atyp,
    DispositionId = @disp,   
	NetworkName = @net,
    BaseId = @base,
    BuildingId = @bldg,
    DeckId = @deck,
    AudienceId = @aud,
    Room = @room,
    AssetSubTypeId = @sub,
    POCId = @poc
    WHERE SessionKey = @sess;
	COMMIT TRANSACTION




