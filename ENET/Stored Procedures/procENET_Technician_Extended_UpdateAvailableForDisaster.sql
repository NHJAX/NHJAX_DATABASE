create PROCEDURE [dbo].[procENET_Technician_Extended_UpdateAvailableForDisaster]
(
	@usr int,
	@uby int,
	@dis bit
)
AS
DECLARE @id int
SELECT @id = UserId FROM TECHNICIAN_EXTENDED
WHERE UserId = @usr

--PRINT @id

IF @id > 0
BEGIN
	UPDATE TECHNICIAN_EXTENDED SET
		AvailableForDisaster = @dis,
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
		AvailableForDisaster
	)
	VALUES
	(
		@usr,
		@uby,
		@dis
	)
END




