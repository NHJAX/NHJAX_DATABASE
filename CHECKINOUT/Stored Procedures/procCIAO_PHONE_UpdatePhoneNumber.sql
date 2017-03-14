create PROCEDURE [dbo].[procCIAO_PHONE_UpdatePhoneNumber]
(
@ph bigint, 
@num nvarchar(50),
@uby int
)
 AS

UPDATE PHONE
SET PhoneNumber = @num
WHERE PhoneId = @ph;



