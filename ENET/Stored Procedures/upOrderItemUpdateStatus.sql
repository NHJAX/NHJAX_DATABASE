CREATE PROCEDURE [dbo].[upOrderItemUpdateStatus]
(
	@oitemid int,
	@rej bit,
	@rejres varchar(1000),
	@uby int
) 
AS
UPDATE ASSET_ORDER_ITEM
SET
	Rejected = @rej,
	RejectedReason = @rejres, 
	UpdatedBy = @uby,
	UpdatedDate = getdate()
WHERE
	AssetOrderItemId = @oitemid;
