CREATE PROCEDURE [dbo].[upENet_SoftwareLicenseInsert]
(
	@sft int,
	@desc varchar(1000),
	@ver varchar(30),
	@upg bit,
	@pur datetime,
	@cost decimal,
	@dsk int,
	@reg varchar(50),
	@key varchar(50),
	@loc int,
	@oth varchar(50),
	@cby int,
	@vnd int,
	@req varchar(50),
	@po varchar(50),
	@usr int,
	@exp datetime
)
AS
INSERT INTO SOFTWARE_LICENSE
(
	SoftwareId,
	SoftwareLicenseDesc, 
	SoftwareVersion,
	Upgrade, 
	PurchaseDate,
	Cost,
	NumberofDisks,
	SoftwareRegistration,
	CDKey,
	SoftwareLocationId,
	OtherLocation,
	CreatedBy,
	SoftwareVendorId,
	RequisitionNumber,
	PurchaseOrder,
	NumberofUsers,
	ExpirationDate
)
VALUES(
	@sft, 
	@desc,
	@ver, 
	@upg,
	@pur,
	@cost,
	@dsk,
	@reg,
	@key,
	@loc,
	@oth,
	@cby,
	@vnd,
	@req,
	@po,
	@usr,
	@exp
);
SELECT SCOPE_IDENTITY();

