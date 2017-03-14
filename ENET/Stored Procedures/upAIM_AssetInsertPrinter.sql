CREATE PROCEDURE [dbo].[upAIM_AssetInsertPrinter]
(
	@net varchar(100),
	@type int,
	@cby int,
	@uby int,
	@udate datetime
)
AS
INSERT INTO ASSET
(
	NetworkName,
	AssetTypeId,
	DispositionId,
	CreatedBy,
	UpdatedBy,
	UpdatedDate
)
VALUES
(
	@net,
	@type,
	0,
	@cby,
	@uby,
	@udate
)

