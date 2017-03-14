
create PROCEDURE [dbo].[procODS_MEDICAL_CENTER_DIVISION_UpdateDesc]
(
	@key numeric(8,3),
	@desc varchar(30)
)
AS
	SET NOCOUNT ON;
	
UPDATE MEDICAL_CENTER_DIVISION
SET MedicalCenterDivisionDesc = @desc,
	UpdatedDate = Getdate()
WHERE MedicalCenterDivisionKey = @key;

