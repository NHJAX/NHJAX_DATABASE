CREATE PROCEDURE [dbo].[upENet_SoftwareVendorInsert]
(
	@desc varchar(50),
	@cby int
)
AS
INSERT INTO SOFTWARE_VENDOR
(
	SoftwareVendorDesc, 
	CreatedBy
)
VALUES(
	@desc, 
	@cby
);

