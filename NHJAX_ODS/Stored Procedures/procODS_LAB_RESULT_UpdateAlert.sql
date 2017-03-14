
create PROCEDURE [dbo].[procODS_LAB_RESULT_UpdateAlert]
(
	@id bigint,
	@alrt varchar(5)
)
AS
	SET NOCOUNT ON;
UPDATE LAB_RESULT
SET Alert = @alrt,
	UpdatedDate = GETDATE()
WHERE (LabResultId = @id)


