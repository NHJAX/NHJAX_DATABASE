
create PROCEDURE [dbo].[procODS_PATIENT_CATEGORY_SelectbyKey]
(
	@key numeric(10,3)
)
AS
	SET NOCOUNT ON;
SELECT     
	PatientCategoryId,
	PatientCategoryKey,
	PatientCategoryCode,
	PatientCategoryDesc,
	CreatedDate,
	UpdatedDate
FROM PATIENT_CATEGORY
WHERE (PatientCategoryKey = @key)
