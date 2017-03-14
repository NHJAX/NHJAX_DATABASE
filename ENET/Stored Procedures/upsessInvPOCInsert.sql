CREATE PROCEDURE [dbo].[upsessInvPOCInsert]
(
	@poc int,
	@cby int
)
AS
	BEGIN TRANSACTION
	
	INSERT INTO sessINV_POC
	(
	POCId,
	Createdby
	)
	VALUES
	(
	@poc,
	@cby
	);
	COMMIT TRANSACTION
