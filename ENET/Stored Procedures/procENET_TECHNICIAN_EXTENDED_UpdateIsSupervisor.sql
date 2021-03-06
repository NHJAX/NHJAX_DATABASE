﻿create PROCEDURE [dbo].[procENET_TECHNICIAN_EXTENDED_UpdateIsSupervisor]
(
	@usr int,
	@uby int,
	@sup bit
)
AS
DECLARE @id int
SELECT @id = UserId FROM TECHNICIAN_EXTENDED
WHERE UserId = @usr

--PRINT @id

IF @id > 0
BEGIN
	UPDATE TECHNICIAN_EXTENDED SET
		IsSupervisor = @sup,
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
		@sup
	)
END




