CREATE PROCEDURE [dbo].[procENET_Technician_Extended_UpdateDeployed]
(
	@usr int,
	@uby int,
	@dep bit,
	@ddate datetime,
	@rdate datetime
)
AS
DECLARE @id int
SELECT @id = UserId FROM TECHNICIAN_EXTENDED
WHERE UserId = @usr

--PRINT @id

IF @id > 0
BEGIN
	UPDATE TECHNICIAN_EXTENDED SET
		Deployed = @dep,
		UpdatedBy = @uby,
		UpdatedDate = getdate(),
		DeployDate = @ddate,
		ReturnDate = @rdate
	WHERE UserId = @usr;
END
ELSE
BEGIN
	INSERT INTO TECHNICIAN_EXTENDED
	(
		UserId,
		UpdatedBy,
		Deployed,
		DeployDate,
		ReturnDate
	)
	VALUES
	(
		@usr,
		@uby,
		@dep,
		@ddate,
		@rdate
	)
END




