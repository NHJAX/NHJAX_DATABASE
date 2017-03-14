
create PROCEDURE [dbo].[procODS_LAB_RESULT_UpdateTakenDate]
(
	@id bigint,
	@tdate datetime
)
AS
	SET NOCOUNT ON;
UPDATE LAB_RESULT
SET TakenDate = @tdate,
	UpdatedDate = GETDATE()
WHERE (LabResultId = @id)


