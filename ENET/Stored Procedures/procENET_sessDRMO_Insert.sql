CREATE PROCEDURE [dbo].[procENET_sessDRMO_Insert]
(
	@pre varchar(50),
	@num varchar(50),
	@ser varchar(50),
	@eqp varchar(50),
	@cby int,
	@net varchar(100) = ''
)
 AS

INSERT INTO sessDRMO
(
 	PlantPrefix,
	PlantNumber,
	SerialNumber,
	EquipmentNumber,
	CreatedBy,
	CreatedDate,
	NetworkName
)
VALUES
(
	@pre,
	@num,
	@ser,
	@eqp,
	@cby,
	getdate(),
	@net
);
SELECT SCOPE_IDENTITY();
