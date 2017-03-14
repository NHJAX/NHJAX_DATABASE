CREATE PROCEDURE [dbo].[upsessInvProjectInsert]
(
	@proj int,
	@cby int
)
AS
	BEGIN TRANSACTION
	
	INSERT INTO sessINV_PROJECT
	(
	ProjectId,
	Createdby
	)
	VALUES
	(
	@proj,
	@cby
	);
	COMMIT TRANSACTION
