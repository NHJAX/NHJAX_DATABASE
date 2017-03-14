CREATE PROCEDURE [dbo].[procCIO_Language_Spoken_DeleteAll]
(
	@pers bigint,
	@sess varchar(50)
)
 AS

IF @pers = 0
BEGIN
DELETE FROM LANGUAGE_SPOKEN
WHERE SessionKey = @sess;
END
ELSE
BEGIN
DELETE FROM LANGUAGE_SPOKEN
WHERE PersonnelId = @pers;
END



