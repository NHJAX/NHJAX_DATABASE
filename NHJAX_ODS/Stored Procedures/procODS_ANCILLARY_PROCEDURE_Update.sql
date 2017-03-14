
create PROCEDURE [dbo].[procODS_ANCILLARY_PROCEDURE_Update]
(
	@desc varchar(30),
	@key numeric(10,3)
)
AS
	SET NOCOUNT ON;
	
UPDATE ANCILLARY_PROCEDURE
SET AncillaryProcedureDesc = @desc,
	UpdatedDate = Getdate()
WHERE AncillaryProcedureKey = @key;

