
create PROCEDURE [dbo].[procODS_MATERNITY_STATUS_Select]

AS
	SET NOCOUNT ON;
SELECT 	
	MaternityStatusId,
	MaternityStatusDesc,
	CreatedDate,
	IsInactive
FROM
	MATERNITY_STATUS 
ORDER BY MaternityStatusDesc
