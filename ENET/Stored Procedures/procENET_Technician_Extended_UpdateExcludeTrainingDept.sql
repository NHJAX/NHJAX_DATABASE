create PROCEDURE [dbo].[procENET_Technician_Extended_UpdateExcludeTrainingDept]
(
	@usr int,
	@uby int,
	@trn bit
)
AS
DECLARE @id int
SELECT @id = UserId FROM TECHNICIAN_EXTENDED
WHERE UserId = @usr

--PRINT @id

IF @id > 0
BEGIN
	UPDATE TECHNICIAN_EXTENDED SET
		ExcludeTrainingDept = @trn,
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
		ExcludeTrainingDept
	)
	VALUES
	(
		@usr,
		@uby,
		@trn
	)
END




