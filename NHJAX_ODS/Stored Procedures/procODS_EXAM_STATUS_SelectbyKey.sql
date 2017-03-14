
create PROCEDURE [dbo].[procODS_EXAM_STATUS_SelectbyKey]
(
	@key bigint
)
AS
	SET NOCOUNT ON;
	
SELECT ExamStatusId,
	ExamStatusKey,
	ExamStatusDesc
FROM EXAM_STATUS
WHERE ExamStatusKey = @key;

