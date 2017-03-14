create PROCEDURE [dbo].[procENET_PHONE_UpdatePreferredContactOrder]
(
@ph bigint, 
@ord int,
@uby int
)
 AS

UPDATE PHONE
SET PreferredContactOrder = @ord,
UpdatedDate = GETDATE(),
UpdatedBy = @uby
WHERE PhoneId = @ph;



