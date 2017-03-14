
create PROCEDURE [dbo].[procODS_PRIORITY_Select]
(
	@desc varchar(30)
)
AS
	SET NOCOUNT ON;
	
SELECT PriorityId,
	PriorityDesc,
	PriorityCode
FROM PRIORITY
WHERE PriorityDesc = @desc;

