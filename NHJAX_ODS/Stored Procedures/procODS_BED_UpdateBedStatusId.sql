
create PROCEDURE [dbo].[procODS_BED_UpdateBedStatusId]
(
	@key varchar(254),
	@stat int
)
AS
	SET NOCOUNT ON;
	
UPDATE BED
SET BedStatusId = @stat,
	UpdatedDate = Getdate()
WHERE BedKey = @key;

