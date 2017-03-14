
create PROCEDURE [dbo].[procENET_Security_Group_Select]
(
	@grp int
) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT DISTINCT 
	SecurityGroupId, 
	SecurityGroupDesc,
	Inactive,
	HasAlternates,
	ReturnPage
FROM SECURITY_GROUP 
WHERE SecurityGroupId = @grp
END

