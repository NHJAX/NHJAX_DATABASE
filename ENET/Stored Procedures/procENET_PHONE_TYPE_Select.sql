
CREATE PROCEDURE [dbo].[procENET_PHONE_TYPE_Select]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 
	PhoneTypeId,
	PhoneTypeDesc
FROM PHONE_TYPE
ORDER BY PhoneTypeDesc

END

