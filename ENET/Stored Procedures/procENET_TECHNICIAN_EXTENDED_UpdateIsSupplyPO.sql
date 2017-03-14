create PROCEDURE [dbo].[procENET_TECHNICIAN_EXTENDED_UpdateIsSupplyPO]
(
	@usr int,
	@uby int,
	@spo bit
)
AS
DECLARE @id int
SELECT @id = UserId FROM TECHNICIAN_EXTENDED
WHERE UserId = @usr

--PRINT @id

IF @id > 0
BEGIN
	UPDATE TECHNICIAN_EXTENDED SET
		IsSupplyPO = @spo,
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
		IsSupplyPO
	)
	VALUES
	(
		@usr,
		@uby,
		@spo
	)
END




