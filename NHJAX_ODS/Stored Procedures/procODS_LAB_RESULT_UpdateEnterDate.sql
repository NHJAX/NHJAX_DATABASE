
create PROCEDURE [dbo].[procODS_LAB_RESULT_UpdateEnterDate]
(
	@id bigint,
	@edate datetime
)
AS
	SET NOCOUNT ON;
UPDATE LAB_RESULT
SET EnterDate = @edate,
	UpdatedDate = GETDATE()
WHERE (LabResultId = @id)


