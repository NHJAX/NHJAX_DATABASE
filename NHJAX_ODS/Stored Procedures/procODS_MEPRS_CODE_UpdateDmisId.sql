
create PROCEDURE [dbo].[procODS_MEPRS_CODE_UpdateDmisId]
(
	@key numeric(10,3),
	@dmis bigint
)
AS
	SET NOCOUNT ON;
	
UPDATE MEPRS_CODE
SET DmisId = @dmis,
	UpdatedDate = Getdate()
WHERE MeprsCodeKey = @key;

