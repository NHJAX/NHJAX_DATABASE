
create PROCEDURE [dbo].[procODS_ADMISSION_TYPE_Select]
(
	@key numeric(8,3)
)
AS
	SET NOCOUNT ON;
	
SELECT AdmissionTypeId,
	AdmissionTypeKey,
	AdmissionTypeDesc,
	AdmissionTypeCode
FROM ADMISSION_TYPE
WHERE AdmissionTypeKey = @key;

