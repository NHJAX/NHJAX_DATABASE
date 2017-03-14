
CREATE PROCEDURE [dbo].[procODS_BED_SelectbyKey]
(
	@key varchar(254)
)
AS
	SET NOCOUNT ON;
SELECT     
	BedId,
	BedKey,
	PatientId,
	BedStatusId,
	BedNumber,
	DepartmentId,
	BedDesc
	CreatedDate,
	UpdatedDate
FROM BED
WHERE (BedKey = @key)
