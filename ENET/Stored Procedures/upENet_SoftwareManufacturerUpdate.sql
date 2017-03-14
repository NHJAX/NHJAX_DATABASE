CREATE PROCEDURE [dbo].[upENet_SoftwareManufacturerUpdate]
(
	@mfr int,
	@desc varchar(50),
	@uby int,
	@udate datetime,
	@inactive bit
)
AS
UPDATE SOFTWARE_MANUFACTURER
SET 	SoftwareManufacturerDesc = @desc,
	UpdatedBy = @uby,
	UpdatedDate = @udate,
	Inactive = @inactive
WHERE SoftwareManufacturerId = @mfr

