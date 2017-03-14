create PROCEDURE [dbo].[procCIAO_PHONE_UpdatePreferredContactOrder]
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



