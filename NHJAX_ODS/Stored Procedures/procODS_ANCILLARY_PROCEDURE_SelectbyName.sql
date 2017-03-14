
create PROCEDURE [dbo].[procODS_ANCILLARY_PROCEDURE_SelectbyName]
(
	@desc varchar(30)
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
	(AncillaryProcedureDesc = @desc)
