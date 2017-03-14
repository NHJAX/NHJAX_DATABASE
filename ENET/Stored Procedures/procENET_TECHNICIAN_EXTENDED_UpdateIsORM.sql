CREATE PROCEDURE [dbo].[procENET_TECHNICIAN_EXTENDED_UpdateIsORM]
(
	@usr int,
	@uby int,
	@orm bit
)
AS
DECLARE @id int
SELECT @id = UserId FROM TECHNICIAN_EXTENDED
WHERE UserId = @usr

--PRINT @id

IF @id > 0
BEGIN
	UPDATE TECHNICIAN_EXTENDED SET
		IsORM = @orm,
		UpdatedBy = @uby,
		UpdatedDate = getdate()
	WHERE UserId = @usr;
END
ELSE
BEGIN
	INSERT INTO TECHNICIAN_EXTENDED
	(
		UserId,
		UpdatedBy,
		IsORM
	)
	VALUES
	(
		@usr,
		@uby,
		@orm
	)
END




