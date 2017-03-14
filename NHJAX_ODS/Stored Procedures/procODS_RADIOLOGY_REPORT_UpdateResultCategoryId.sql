
create PROCEDURE [dbo].[procODS_RADIOLOGY_REPORT_UpdateResultCategoryId]
(
	@id bigint,
	@cat bigint
)
AS
	SET NOCOUNT ON;
UPDATE RADIOLOGY_REPORT
SET ResultCategoryId = @cat,
	UpdatedDate = GETDATE()
WHERE (RadiologyReportId = @id)


