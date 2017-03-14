
create PROCEDURE [dbo].[procODS_MEPRS_CODE_UpdateMeprsCode]
(
	@key numeric(10,3),
	@code varchar(4)
)
AS
	SET NOCOUNT ON;
	
UPDATE MEPRS_CODE
SET MeprsCode = @code,
	UpdatedDate = Getdate()
WHERE MeprsCodeKey = @key;

