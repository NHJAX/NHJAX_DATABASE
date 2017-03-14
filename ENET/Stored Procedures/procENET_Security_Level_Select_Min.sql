
CREATE PROCEDURE [dbo].[procENET_Security_Level_Select_Min]
(
	@grp int
) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT DISTINCT 
	LVL.RoleId,
	LVL.RoleName
FROM SECURITY_GROUP AS GRP 
	INNER JOIN aspnet_Roles AS LVL 
	ON GRP.SecurityGroupDesc = LVL.Description
WHERE (GRP.SecurityGroupId > 0) 
	AND (GRP.Inactive = 0) 
	AND (GRP.SecurityGroupId = @grp)
	AND (LVL.LoweredRoleName LIKE '%Select%')

END

