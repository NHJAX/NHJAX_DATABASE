create PROCEDURE [dbo].[procENET_TECHNICIAN_EXTENDED_UpdateHasServerAccess]
(
	@usr int,
	@uby int,
	@srv bit
)
AS
DECLARE @id int
SELECT @id = UserId FROM TECHNICIAN_EXTENDED
WHERE UserId = @usr

--PRINT @id

IF @id > 0
BEGIN
	UPDATE TECHNICIAN_EXTENDED SET
		HasServerAccess = @srv,
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
		HasServerAccess
	)
	VALUES
	(
		@usr,
		@uby,
		@srv
	)
END




