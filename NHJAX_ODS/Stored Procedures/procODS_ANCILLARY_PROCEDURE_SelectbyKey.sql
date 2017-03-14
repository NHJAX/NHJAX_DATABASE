
create PROCEDURE [dbo].[procODS_ANCILLARY_PROCEDURE_SelectbyKey]
(
	@key numeric(10,3)
)
AS
	SET NOCOUNT ON;
	
SELECT 	
	AncillaryProcedureId,
	AncillaryProcedureKey, 
	AncillaryProcedureDesc,
	CreatedDate,
	UpdatedDate,
	SourceSystemId
FROM
	ANCILLARY_PROCEDURE
WHERE 	
	(AncillaryProcedureKey = @key)
