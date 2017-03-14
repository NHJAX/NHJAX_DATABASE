CREATE PROCEDURE [dbo].[upENet_SoftwareNameInsert]
(
	@desc varchar(50),
	@afn varchar(100),
	@mfr int,
	@cby int
)
AS
INSERT INTO SOFTWARE_NAME
(
	SoftwareDesc, 
	AssetFileName,
	SoftwareManufacturerId, 
	CreatedBy
)
VALUES(
	@desc, 
	@afn,
	@mfr, 
	@cby
);
SELECT SCOPE_IDENTITY();

