CREATE PROCEDURE [dbo].[upENet_SoftwareManufacturerInsert]
(
	@desc varchar(50),
	@cby int
)
AS
INSERT INTO SOFTWARE_MANUFACTURER
(
	SoftwareManufacturerDesc, 
	CreatedBy
)
VALUES(
	@desc, 
	@cby
);
SELECT SCOPE_IDENTITY();
