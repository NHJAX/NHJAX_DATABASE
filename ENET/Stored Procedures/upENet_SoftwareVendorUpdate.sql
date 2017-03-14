CREATE PROCEDURE [dbo].[upENet_SoftwareVendorUpdate]
(
	@vnd int,
	@desc varchar(50),
	@uby int,
	@udate datetime,
	@inactive bit
)
AS
UPDATE SOFTWARE_VENDOR
SET 	SoftwareVendorDesc = @desc,
	UpdatedBy = @uby,
	UpdatedDate = @udate,
	Inactive = @inactive
WHERE SoftwareVendorId = @vnd

