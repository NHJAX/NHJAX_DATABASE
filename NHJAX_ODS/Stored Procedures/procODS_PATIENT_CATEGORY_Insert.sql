
create PROCEDURE [dbo].[procODS_PATIENT_CATEGORY_Insert]
(
	@key numeric(8,3),
	@cd varchar(30),
	@desc varchar(50)
)
AS
	SET NOCOUNT ON;
	
INSERT INTO NHJAX_ODS.dbo.PATIENT_CATEGORY
(
	PatientCategoryKey,
	PatientCategoryCode,
	PatientCategoryDesc
) 
VALUES
(
	@key, 
	@cd,
	@desc
);
SELECT SCOPE_IDENTITY();