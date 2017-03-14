CREATE PROCEDURE [dbo].[upOrderInsert]
(
	@user int,
	@base varchar(5),
	@c4 int,
	@orderid int OUT
)
AS
	BEGIN TRANSACTION
	
	INSERT INTO ASSET_ORDER
	(
	OrderNumber,
	CreatedBy,
	UpdatedBy,
	CreatedFor
	)
	VALUES
	(
	dbo.NewOrderNumber(@base,getdate(),@user),
	@user,
	@user,
	@c4
	);
SET @orderid = SCOPE_IDENTITY();
	COMMIT TRANSACTION
