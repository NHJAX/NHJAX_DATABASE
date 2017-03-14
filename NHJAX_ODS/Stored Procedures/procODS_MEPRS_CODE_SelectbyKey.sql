
create PROCEDURE [dbo].[procODS_MEPRS_CODE_SelectbyKey]
(
	@key numeric(10,3)
)
AS
	SET NOCOUNT ON;
SELECT 
	MeprsCodeId,
	MeprsCodeKey,
	MeprsCode,
	MeprsCodeDesc,    
	DmisId,
	CreatedDate,
	UpdatedDate
FROM MEPRS_CODE
WHERE (MeprsCodeKey = @key)
