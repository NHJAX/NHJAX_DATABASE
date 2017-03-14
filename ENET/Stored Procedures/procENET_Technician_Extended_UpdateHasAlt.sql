CREATE PROCEDURE [dbo].[procENET_Technician_Extended_UpdateHasAlt]
(
	@usr int,
	@uby int,
	@alt bit,
	@aid varchar(25),
	@aidate datetime = '1/1/1776'
)
AS
DECLARE @id int
SELECT @id = UserId FROM TECHNICIAN_EXTENDED
WHERE UserId = @usr

--PRINT @id

IF @id > 0
BEGIN
	UPDATE TECHNICIAN_EXTENDED SET
		HasAlt = @alt,
		UpdatedBy = @uby,
		UpdatedDate = getdate(),
		AltId = @aid,
		AltIssueDate = @aidate
	WHERE UserId = @usr;
END
ELSE
BEGIN
	SET @aidate = GETDATE()
	INSERT INTO TECHNICIAN_EXTENDED
	(
		UserId,
		UpdatedBy,
		HasAlt,
		AltId,
		AltIssueDate
	)
	VALUES
	(
		@usr,
		@uby,
		@alt,
		@aid,
		@aidate
	)
END




