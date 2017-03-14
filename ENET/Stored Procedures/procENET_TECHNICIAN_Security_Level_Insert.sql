
create PROCEDURE [dbo].[procENET_TECHNICIAN_Security_Level_Insert]
(
	@grp int,
	@usr int,
	@rol uniqueidentifier,
	@ro bit,
	@cby int
) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

INSERT INTO TECHNICIAN_SECURITY_LEVEL
(
	UserId,
	RoleId,
	SecurityGroupId,
	ReadOnly,
	CreatedBy
)
VALUES
(
	@usr,
	@rol,
	@grp,
	@ro,
	@cby
)

END

