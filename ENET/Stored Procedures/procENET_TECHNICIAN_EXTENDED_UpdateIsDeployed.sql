create PROCEDURE [dbo].[procENET_TECHNICIAN_EXTENDED_UpdateIsDeployed]
(
	@usr int,
	@dep bit
)
AS
DECLARE @id int
DECLARE @desg int

SELECT @id = UserId FROM TECHNICIAN_EXTENDED
WHERE UserId = @usr

SELECT @desg = DesignationId
FROM TECHNICIAN
WHERE UserId = @usr
--PRINT @id
IF @desg = 3
BEGIN
	IF @id > 0
	BEGIN
		
		UPDATE TECHNICIAN_EXTENDED SET
			Deployed = @dep,
			UpdatedDate = getdate()
		WHERE UserId = @usr;
	END
	ELSE
	BEGIN
		INSERT INTO TECHNICIAN_EXTENDED
		(
			UserId,
			Deployed
		)
		VALUES
		(
			@usr,
			@dep
		)
	END
END



