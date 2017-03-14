CREATE PROCEDURE [dbo].[upOrderUpdateStatus]
(
	@orderid int,
	@stat int,
	@uby int
) 
AS
UPDATE ASSET_ORDER
SET
	AssetOrderStatusId = @stat,
	UpdatedBy = @uby,
	UpdatedDate = getdate()
WHERE
	AssetOrderId = @orderid;
