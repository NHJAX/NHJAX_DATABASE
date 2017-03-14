CREATE PROCEDURE [dbo].[procENET_PHONE_UpdateInactive]
(
@ph bigint, 
@inac bit,
@uby int
)
 AS
DECLARE @usr int
DECLARE @max int

SELECT @usr = UserId
FROM PHONE
WHERE PhoneId = @ph

SELECT @max =  MAX(PreferredContactOrder)
FROM PHONE
WHERE UserId = @usr

UPDATE PHONE
SET Inactive = @inac,
UpdatedDate = GETDATE(),
PreferredContactOrder = @max
WHERE PhoneId = @ph;



