
CREATE PROCEDURE [dbo].[procODS_LAB_RESULT_SelectbyKey]
(
	@key numeric(13,3),
	@lab bigint,
	@sub numeric(26,9)
)
AS
	SET NOCOUNT ON;
SELECT     
	LabResultId, 
	PatientId, 
	LabTestId, 
	OrderId, 
	LabWorkElementId, 
	TakenDate, 
	EnterDate, 
	CertifyDate, 
	AppendDate, 
	Result, 
	UnitCost, 
	CreatedDate, 
    UpdatedDate, 
    LabResultKey, 
    AccessionTypeId, 
    LabResultSubKey, 
    SourceSystemId, 
    Alert
FROM LAB_RESULT
WHERE (LabResultKey = @key)
	AND LabTestId = @lab
	AND LabResultSubKey = @sub
