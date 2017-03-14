
create PROCEDURE [dbo].[procODS_CPT_SelectbyCode]
(
	@cd varchar(30)
)
AS
	SET NOCOUNT ON;
SELECT 	
	CptId,
	CptHcpcsKey, 
	CptCode,
	CptDesc,
	CptTypeId,
	RVU,
	CMACUnit,
	CreatedDate,
	UpdatedDate,
	IsNSQIP
FROM
	CPT
WHERE 	
	(CptCode = @cd)
