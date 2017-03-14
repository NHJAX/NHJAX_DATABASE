
create PROCEDURE [dbo].[procODS_LAB_RESULT_UpdateResult]
(
	@id bigint,
	@res varchar(19)
)
AS
	SET NOCOUNT ON;
UPDATE LAB_RESULT
SET Result = @res,
	UpdatedDate = GETDATE()
WHERE (LabResultId = @id)


