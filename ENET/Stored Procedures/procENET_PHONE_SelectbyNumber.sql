
CREATE PROCEDURE [dbo].[procENET_PHONE_SelectbyNumber]
(
	@num varchar(50),
	@usr int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

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
WHERE PhoneNumber = @num
AND PHONE.UserId = @usr

END

