
create PROCEDURE [dbo].[procODS_MEPRS_CODE_UpdateMeprsCodeDesc]
(
	@key numeric(10,3),
	@desc varchar(50)
)
AS
	SET NOCOUNT ON;
	
UPDATE MEPRS_CODE
SET MeprsCodeDesc = @desc,
	UpdatedDate = Getdate()
WHERE MeprsCodeKey = @key;

