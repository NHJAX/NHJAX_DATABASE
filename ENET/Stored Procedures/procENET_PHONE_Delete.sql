CREATE PROCEDURE [dbo].[procENET_PHONE_Delete]
(
	@usr int,
	@ph bigint
)
 AS

DECLARE @max int

SELECT @max =  MAX(PreferredContactOrder)
FROM PHONE
WHERE UserId = @usr

UPDATE PHONE
SET Inactive = 1,
UpdatedDate = GETDATE(),
PreferredContactOrder = @max
WHERE UserId = @usr
AND PhoneId = @ph;




