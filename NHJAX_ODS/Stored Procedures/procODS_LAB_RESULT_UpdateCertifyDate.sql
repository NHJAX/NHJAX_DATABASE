
create PROCEDURE [dbo].[procODS_LAB_RESULT_UpdateCertifyDate]
(
	@id bigint,
	@cdate datetime
)
AS
	SET NOCOUNT ON;
UPDATE LAB_RESULT
SET CertifyDate = @cdate,
	UpdatedDate = GETDATE()
WHERE (LabResultId = @id)


