create PROCEDURE [dbo].[procENET_TECHNICIAN_EXTENDED_UpdateHasDriversLicense]
(
	@usr int,
	@uby int,
	@dl bit
)
AS
DECLARE @id int
SELECT @id = UserId FROM TECHNICIAN_EXTENDED
WHERE UserId = @usr

--PRINT @id

IF @id > 0
BEGIN
	UPDATE TECHNICIAN_EXTENDED SET
		HasDriversLicense = @dl,
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
		HasDriversLicense
	)
	VALUES
	(
		@usr,
		@uby,
		@dl
	)
END




