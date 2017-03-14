
create PROCEDURE [dbo].[procODS_CPT_UpdateIsNSQIP]
(
	@id bigint,
	@nsq bit
)
AS
	SET NOCOUNT ON;
	
UPDATE CPT
SET IsNSQIP = @nsq,
	UpdatedDate = Getdate()
WHERE CptId = @id;

