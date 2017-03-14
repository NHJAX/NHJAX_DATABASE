


CREATE PROCEDURE [dbo].[upENet_Technician_SelectbyUserRole](
	@grp varchar(256),
	@user int
)
AS

SELECT     
	TSL.ReadOnly
FROM aspnet_Roles AS ARL 
	INNER JOIN TECHNICIAN_SECURITY_LEVEL AS TSL 
	ON ARL.RoleId = TSL.RoleId
WHERE(TSL.UserId = @user) AND (ARL.Description = @grp);



