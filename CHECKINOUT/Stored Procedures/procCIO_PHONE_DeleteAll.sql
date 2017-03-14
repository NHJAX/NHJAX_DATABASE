create PROCEDURE [dbo].[procCIO_PHONE_DeleteAll]
(
	@pers bigint,
	@sess varchar(50)
)
 AS

IF @pers = 0
BEGIN
DELETE FROM PHONE
WHERE SessionKey = @sess;
END
ELSE
BEGIN
DELETE FROM PHONE
WHERE PersonnelId = @pers;
END



