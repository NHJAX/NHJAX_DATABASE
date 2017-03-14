CREATE PROCEDURE [dbo].[procENET_PHONE_DeleteAll]
(
	@usr int
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




