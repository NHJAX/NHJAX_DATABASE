
create PROCEDURE [dbo].[upENet_Technician_Security_Level_Insert]
(
	@user int,
	@secgrp int,
	@ro bit,
	@role uniqueidentifier,
	@cby int
)
AS
INSERT INTO TECHNICIAN_SECURITY_LEVEL
(
	UserId, 
	SecurityGroupId,
	ReadOnly, 
	RoleId,
	CreatedBy
)
VALUES(
	@user, 
	@secgrp,
	@ro,
	@role, 
	@cby
);
SELECT SCOPE_IDENTITY();


