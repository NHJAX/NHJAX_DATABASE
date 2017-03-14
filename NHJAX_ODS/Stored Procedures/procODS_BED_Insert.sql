
CREATE PROCEDURE [dbo].[procODS_BED_Insert]
(
	@key varchar(254),
	@pat bigint,
	@stat int,
	@num varchar(2),
	@dept bigint,
	@desc varchar(30)
	
)
AS
	SET NOCOUNT ON;
	
INSERT INTO BED
(
	BedKey,
	PatientId,
	BedStatusId,
	BedNumber,
	DepartmentId,
	BedDesc
) 
VALUES
(
	@key, 
	@pat,
	@stat,
	@num,
	@dept,
	@desc
);
SELECT SCOPE_IDENTITY();
