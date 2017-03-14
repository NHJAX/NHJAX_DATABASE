
create PROCEDURE [dbo].[procODS_CPT_Select]

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

