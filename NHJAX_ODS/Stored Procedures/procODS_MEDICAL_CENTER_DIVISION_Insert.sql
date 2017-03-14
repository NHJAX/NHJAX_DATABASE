
create PROCEDURE [dbo].[procODS_MEDICAL_CENTER_DIVISION_Insert]
(
	@key numeric(8,3),
	@desc varchar(30)
	
)
AS
	SET NOCOUNT ON;
	
INSERT INTO MEDICAL_CENTER_DIVISION
(
	MedicalCenterDivisionKey,
	MedicalCenterDivisionDesc
) 
VALUES
(
	@key, 
	@desc
);
SELECT SCOPE_IDENTITY();
