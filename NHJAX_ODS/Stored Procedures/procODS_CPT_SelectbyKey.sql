
CREATE PROCEDURE [dbo].[procODS_CPT_SelectbyKey]
(
	@key numeric(11,3)
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
	(CptHcpcsKey = @key)
