
create PROCEDURE [dbo].[procODS_RELEASE_CONDITION_Select]
(
	@desc varchar(30)
)
AS
	SET NOCOUNT ON;
	
SELECT ReleaseConditionId,
	ReleaseConditionDesc
FROM RELEASE_CONDITION
WHERE ReleaseConditionDesc = @desc;

