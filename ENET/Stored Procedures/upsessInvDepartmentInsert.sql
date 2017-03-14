CREATE PROCEDURE [dbo].[upsessInvDepartmentInsert]
(
	@dept int,
	@cby int
)
AS
	BEGIN TRANSACTION
	
	INSERT INTO sessINV_DEPARTMENT
	(
	DepartmentId,
	Createdby
	)
	VALUES
	(
	@dept,
	@cby
	);
	COMMIT TRANSACTION

