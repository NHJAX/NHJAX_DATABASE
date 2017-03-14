CREATE PROCEDURE [dbo].[upENet_SoftwareLocationUpdate]
(
	@loc int,
	@desc varchar(50),
	@uby int,
	@udate datetime,
	@inactive bit
)
AS
UPDATE SOFTWARE_LOCATION
SET 	SoftwareLocationDesc = @desc,
	UpdatedBy = @uby,
	UpdatedDate = @udate,
	Inactive = @inactive
WHERE SoftwareLocationId = @loc

