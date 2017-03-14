create PROCEDURE [dbo].[procCIAO_PHONE_UpdateInactive]
(
@ph bigint, 
@inac bit,
@uby int
)
 AS
DECLARE @sess bigint
DECLARE @max int

SELECT @sess = SessionKey
FROM PHONE
WHERE PhoneId = @ph

SELECT @max =  MAX(PreferredContactOrder)
FROM PHONE
WHERE SessionKey = @sess

UPDATE PHONE
SET Inactive = @inac,
UpdatedDate = GETDATE(),
PreferredContactOrder = @max
WHERE PhoneId = @ph;



