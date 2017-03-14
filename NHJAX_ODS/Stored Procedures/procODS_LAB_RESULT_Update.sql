
create PROCEDURE [dbo].[procODS_LAB_RESULT_Update]
(
	@id bigint,
	@lab bigint
)
AS
	SET NOCOUNT ON;
UPDATE LAB_RESULT
SET LabTestId = @lab,
	UpdatedDate = GETDATE()
WHERE (LabResultId = @id)


