
CREATE PROCEDURE [dbo].[procCIAO_PHONE_SelectbyUser]
(
	@pers bigint,
	@ball bit = 0,
	@sess varchar(50)
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
	PHONE.PersonnelId,
	PHONE.PhoneTypeId,
	PHONE.PhoneNumber,
	PHONE.CreatedDate,
	PHONE.CreatedBy,
	PHONE.UpdatedDate,
	PHONE.UpdatedBy,
	PHONE.Inactive,
	PHONE.PreferredContactOrder,
	PHT.PhoneTypeDesc,
	PHONE.Extension
FROM PHONE
INNER JOIN ENET.dbo.PHONE_TYPE AS PHT
ON PHONE.PhoneTypeId = PHT.PhoneTypeId
WHERE Inactive = 0
AND SessionKey = @sess
ORDER BY PreferredContactOrder
END

ELSE
BEGIN
SELECT 
	PHONE.PhoneId,
	PHONE.PersonnelId,
	PHONE.PhoneTypeId,
	PHONE.PhoneNumber,
	PHONE.CreatedDate,
	PHONE.CreatedBy,
	PHONE.UpdatedDate,
	PHONE.UpdatedBy,
	PHONE.Inactive,
	PHONE.PreferredContactOrder,
	PHT.PhoneTypeDesc,
	PHONE.Extension
FROM PHONE
INNER JOIN ENET.dbo.PHONE_TYPE AS PHT
ON PHONE.PhoneTypeId = PHT.PhoneTypeId
WHERE SessionKey = @sess
ORDER BY PreferredContactOrder
END

END

