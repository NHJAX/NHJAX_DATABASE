CREATE PROCEDURE [dbo].[procCIO_Personnel_Inprocess_Delete]
(
@inp bigint,
@srt int,
@max int,
@pers bigint,
@for bigint
)
 AS

DELETE PERSONNEL_INPROCESS
WHERE PersonnelInProcessId = @inp;

IF @for = 0
	BEGIN
	DELETE PERSONNEL_INPROCESS
	WHERE SortOrder = @srt
	AND PersonnelId = @pers
	END

IF @srt < @max AND @for = 0
	BEGIN
	UPDATE PERSONNEL_INPROCESS
	SET SortOrder = SortOrder - 1
	WHERE PersonnelId = @pers
	AND SortOrder > @srt
	END




