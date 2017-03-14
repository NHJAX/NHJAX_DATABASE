
create PROCEDURE [dbo].[procODS_BED_UpdatePatientId]
(
	@key varchar(254),
	@pat bigint
)
AS
	SET NOCOUNT ON;
	
UPDATE BED
SET PatientId = @pat,
	UpdatedDate = Getdate()
WHERE BedKey = @key;

