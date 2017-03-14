
create PROCEDURE [dbo].[procODS_MEDICAL_CENTER_DIVISION_SelectbyKey]
(
	@key numeric(8,3)
)
AS
	SET NOCOUNT ON;
SELECT     
	MedicalCenterDivisionId,
	MedicalCenterDivisionKey,
	MedicalCenterDivisionDesc,
	CreatedDate,
	UpdatedDate
FROM MEDICAL_CENTER_DIVISION
WHERE (MedicalCenterDivisionKey = @key)
