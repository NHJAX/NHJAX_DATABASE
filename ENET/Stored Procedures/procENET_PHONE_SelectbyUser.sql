
CREATE PROCEDURE [dbo].[procENET_PHONE_SelectbyUser]
(
	@usr int,
	@ball bit = 0
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

IF @ball = 0
BEGIN
SELECT 
	PHONE.PhoneId,
	PHONE.UserId,
	PHONE.PhoneTypeId,
	PHONE.PhoneNumber,
	PHONE.CreatedDate,
	PHONE.CreatedBy,
	PHONE.UpdatedDate,
	PHONE.UpdatedBy,
	PHONE.Inactive,
	PHONE.PreferredContactOrder,
	PHONE_TYPE.PhoneTypeDesc,
	PHONE.Extension
FROM PHONE
INNER JOIN PHONE_TYPE
ON PHONE.PhoneTypeId = PHONE_TYPE.PhoneTypeId
WHERE UserId = @usr
AND Inactive = 0
ORDER BY PreferredContactOrder
END

ELSE
BEGIN
SELECT 
	PHONE.PhoneId,
	PHONE.UserId,
	PHONE.PhoneTypeId,
	PHONE.PhoneNumber,
	PHONE.CreatedDate,
	PHONE.CreatedBy,
	PHONE.UpdatedDate,
	PHONE.UpdatedBy,
	PHONE.Inactive,
	PHONE.PreferredContactOrder,
	PHONE_TYPE.PhoneTypeDesc,
	PHONE.Extension
FROM PHONE
INNER JOIN PHONE_TYPE
ON PHONE.PhoneTypeId = PHONE_TYPE.PhoneTypeId
WHERE UserId = @usr
ORDER BY PreferredContactOrder
END

END

