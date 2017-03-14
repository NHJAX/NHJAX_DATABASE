CREATE PROCEDURE [dbo].[procENET_sessDRMO_SelectbyID]
(
	@drmo int
)
 AS

SELECT 
	DRMOId,
	PlantPrefix,
	PlantNumber,
	SerialNumber,
	EquipmentNumber,
	CreatedDate,
	CreatedBy,
	UpdatedDate,
	UpdatedBy,
	StatusFlag,
	NetworkName
FROM sessDRMO
WHERE DRMOId = @drmo

