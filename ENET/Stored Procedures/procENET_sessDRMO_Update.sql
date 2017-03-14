CREATE PROCEDURE [dbo].[procENET_sessDRMO_Update]
(
	@pre varchar(50),
	@num varchar(50),
	@ser varchar(50),
	@eqp varchar(50),
	@uby int,
	@drmo int,
	@net varchar(100) = ''
)
 AS

UPDATE sessDRMO
SET
 	PlantPrefix = @pre,
	PlantNumber = @num,
	SerialNumber = @ser,
	EquipmentNumber = @eqp,
	UpdatedBy = @uby,
	UpdatedDate = getdate(),
	NetworkName = @net
WHERE DRMOId = @drmo
