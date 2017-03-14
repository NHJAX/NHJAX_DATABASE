CREATE PROCEDURE [dbo].[procENET_sessDRMO_Select]
(
	@usr int
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
WHERE CreatedBy = @usr

