CREATE PROCEDURE [dbo].[upOrderItemInsert]
(
	@orderid int,
	@atyp int,
	@astyp int,
	@bldg int,
	@deck int,
	@loc varchar(50),
	@qty int,
	@just varchar(1000),
	@cby int,
	@uby int
	
)
AS
	BEGIN TRANSACTION
	
	INSERT INTO ASSET_ORDER_ITEM
	(
	AssetOrderId,
	AssetTypeId,
	AssetSubTypeId,
	BuildingId,
	DeckId,
	ItemLocation,
	ItemQuantity,
	ItemJustification,
	CreatedBy,
	UpdatedBy
	)
	VALUES
	(
	@orderid,
	@atyp,
	@astyp,
	@bldg,
	@deck,
	@loc,
	@qty,
	@just,
	@cby,
	@uby
	);
	COMMIT TRANSACTION
