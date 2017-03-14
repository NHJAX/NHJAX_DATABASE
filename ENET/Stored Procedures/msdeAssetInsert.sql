CREATE PROCEDURE [dbo].[msdeAssetInsert]
(
	@mod int, 
	@pre varchar(50),
	@num varchar(50),
	@ser varchar(50),
	@rem varchar(1000),
	@bar varchar(15),
	@net varchar(100),
	@atyp int,
	@astyp int,
	@dept int,
	@bldg int,
	@deck int,
	@room varchar(50),
	@udate datetime,
	@idate datetime,
	@config int,
	@share int,
	@uby int,
	@cby int,
	@disp int
)
AS

IF DataLength(@ser) > 0
	SET @ser = UPPER(@ser)
 
INSERT INTO ASSET
(
	ModelId,
	PlantAccountPrefix,
    	PlantAccountNumber,
    	SerialNumber,
	Remarks,
	EqpMgtBarCode,
	NetworkName,
    	AssetTypeId, 
	AssetSubtypeId,
	AudienceId,
	BuildingId,
	DeckId,
	Room,
	UpdatedDate,
	InventoryDate,
	PrinterConfig,
	SharePC,
	UpdatedBy,
	CreatedBy,
	DispositionId,
	UpdateSourceSystemId
)
VALUES(
	@mod, 
	@pre,
	@num,
	@ser,
	@rem,
	@bar,
	@net,
	@atyp,
	@astyp,
	@dept,
	@bldg,
	@deck,
	@room,
	@udate,
	@idate,
	@config,
	@share,
	@uby,
	@cby,
	@disp,
	24
);

SELECT SCOPE_IDENTITY();
