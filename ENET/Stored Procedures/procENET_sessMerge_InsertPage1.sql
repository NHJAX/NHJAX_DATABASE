create PROCEDURE [dbo].[procENET_sessMerge_InsertPage1]
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
	@remark varchar(1000),
	@cby int,
	@poc int
)
AS
	BEGIN TRANSACTION
	
	INSERT INTO sessMERGE
	(
    SessionKey,
    PlantAccountPrefix,
    PlantAccountNumber,
    SerialNumber,
    ModelId,
    ManufacturerId,
    ProjectId,
    AssetTypeId,
    DispositionId,
    NetworkName,
    BaseId,
    BuildingId,
    DeckId,
    AudienceId,
    Room,
    AssetSubTypeId,
    Remarks,
    CreatedBy,
    POCId
	)
    VALUES(@sess, @pre, @num, @serial, @mod, @man,
    @pro, @atyp, @disp,
    @net, @base, @bldg, @deck, @aud, @room,
    @sub, @remark, @cby, @poc);
	COMMIT TRANSACTION




