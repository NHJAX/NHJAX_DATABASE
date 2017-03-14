
create PROCEDURE [dbo].[procODS_LAB_TEST_SelectbyKey]
(
	@key numeric(10,3)
)
AS
	SET NOCOUNT ON;
SELECT     
	LabTestid, 
	LabTestKey, 
	LabTestDesc, 
	LabTestTypeId, 
	UnitCost, 
	CreatedDate, 
	UpdatedDate
FROM LAB_TEST
WHERE (LabTestKey = @key)
