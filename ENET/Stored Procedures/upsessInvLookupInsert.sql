CREATE PROCEDURE [dbo].[upsessInvLookupInsert]
(
	@lk int,
	@lkval varchar(50),
	@cby int
)
AS
	BEGIN TRANSACTION
	
	INSERT INTO sessINV_LOOKUP
	(
	LookupId,
	LookupValue,
	Createdby
	)
	VALUES
	(
	@lk,
	@lkval,
	@cby
	);
	COMMIT TRANSACTION
