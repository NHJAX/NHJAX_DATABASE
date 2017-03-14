create PROCEDURE [dbo].[procCIO_PHONE_Delete]
(
	@pers bigint,
	@ph bigint,
	@sess varchar(50)
)
 AS

IF @pers = 0
BEGIN
DELETE FROM PHONE
WHERE SessionKey = @sess
AND PhoneId = @ph;
END
ELSE
BEGIN
DELETE FROM PHONE
WHERE PersonnelId = @pers
AND PhoneId = @ph;
END




