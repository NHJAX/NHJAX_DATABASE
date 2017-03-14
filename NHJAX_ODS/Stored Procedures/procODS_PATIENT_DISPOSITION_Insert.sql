
create PROCEDURE [dbo].[procODS_PATIENT_DISPOSITION_Insert]
(
	@key numeric(8,3),
	@desc varchar(30),
	@code varchar(4)
)
AS
	SET NOCOUNT ON;
	
INSERT INTO PATIENT_DISPOSITION
(
	PatientDispositionKey,
	PatientDispositionDesc,
	PatientDispositionCode
) 
VALUES
(
	@key,
	@desc,
	@code
);
SELECT SCOPE_IDENTITY();
