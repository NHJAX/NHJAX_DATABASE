CREATE PROCEDURE [dbo].[procENET_PHONE_UpdatePhoneTypeId]
(
@ph bigint, 
@typ int,
@uby int
)
 AS

UPDATE PHONE
SET PhoneTypeId = @typ,
UpdatedDate = GETDATE(),
UpdatedBy = @uby
WHERE PhoneId = @ph;



