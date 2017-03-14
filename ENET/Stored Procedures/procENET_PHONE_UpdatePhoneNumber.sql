CREATE PROCEDURE [dbo].[procENET_PHONE_UpdatePhoneNumber]
(
@ph bigint, 
@num nvarchar(50),
@uby int
)
 AS

UPDATE PHONE
SET PhoneNumber = @num
WHERE PhoneId = @ph;



