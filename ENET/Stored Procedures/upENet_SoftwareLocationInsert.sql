CREATE PROCEDURE [dbo].[upENet_SoftwareLocationInsert]
(
	@desc varchar(50),
	@cby int
)
AS
INSERT INTO SOFTWARE_LOCATION
(
	SoftwareLocationDesc, 
	CreatedBy
)
VALUES(
	@desc, 
	@cby
); SELECT SCOPE_IDENTITY()

