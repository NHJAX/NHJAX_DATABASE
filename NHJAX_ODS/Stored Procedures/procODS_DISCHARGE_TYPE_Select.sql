
create PROCEDURE [dbo].[procODS_DISCHARGE_TYPE_Select]
(
	@key numeric(8,3)
)
AS
	SET NOCOUNT ON;
	
SELECT DischargeTypeId,
	DischargeTypeKey,
	DischargeTypeDesc,
	DischargeTypeCode
FROM DISCHARGE_TYPE
WHERE DischargeTypeKey = @key;

