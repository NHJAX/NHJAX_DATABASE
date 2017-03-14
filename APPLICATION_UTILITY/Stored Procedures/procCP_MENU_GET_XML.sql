-- =============================================
-- Author:		Robert Evans
-- Create date: 13 March 2014
-- Description:	Gets The application Menu in XML Format
-- =============================================
CREATE PROCEDURE [dbo].[procCP_MENU_GET_XML]
	@ParameterTable dbo.ProcedureParameters READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
DECLARE @MenuId int = 0
DECLARE @UsersENETId int = 0
DECLARE @UsersLogin nvarchar(25) = ''
DECLARE @UsersRoles TABLE (AudienceId int)
SELECT @MenuId = ParameterIntegerValue FROM @ParameterTable WHERE ParameterName = 'MenuId'
SELECT @UsersLogin = ParameterVarcharValue FROM @ParameterTable WHERE ParameterName = 'UsersLogin'
INSERT INTO @UsersRoles (AudienceId) VALUES (@MenuId)
IF @MenuId = 2
	BEGIN
		IF @UsersLogin != ''
			BEGIN
				SELECT TOP 1 @UsersENETId = UserId 
				FROM [NHJAX-SQL-1A].[ENET].[DBO].TECHNICIAN 
				WHERE RTRIM(LoginId) = RTRIM(@UsersLogin)

				INSERT INTO @UsersRoles (AudienceId)
				SELECT AudienceId FROM [NHJAX-SQL-1A].[ENET].[DBO].AUDIENCE_MEMBER WHERE TechnicianId = @UsersENETId

			END
	END

SELECT m0.[MenuItemId]
      ,m0.[ParentItemId]
      ,m0.[MenuItemText]
      ,m0.[MenuItemURL]
	  ,m0.[MenuId]
	  ,dbo.NumberOfChildren(m0.[MenuItemId]) as NumberOfChildren
	  ,m0.[TargetLocation]
      ,(SELECT m1.[MenuItemId]
			  ,m1.[ParentItemId]
			  ,m1.[MenuItemText]
			  ,m1.[MenuItemURL]
			  ,m1.[MenuId]
			  ,dbo.NumberOfChildren(m1.[MenuItemId]) as NumberOfChildren
			  ,m1.[TargetLocation]
			  ,(SELECT m2.[MenuItemId]
					  ,m2.[ParentItemId]
					  ,m2.[MenuItemText]
					  ,m2.[MenuItemURL]
					  ,m2.[MenuId]
					  ,dbo.NumberOfChildren(m2.[MenuItemId]) as NumberOfChildren
					  ,m2.[TargetLocation]
					  ,(SELECT m3.[MenuItemId]
							  ,m3.[ParentItemId]
							  ,m3.[MenuItemText]
							  ,m3.[MenuItemURL]
							  ,m3.[MenuId]
							  ,dbo.NumberOfChildren(m3.[MenuItemId]) as NumberOfChildren
							  ,m3.[TargetLocation]
							  ,(SELECT m4.[MenuItemId]
									  ,m4.[ParentItemId]
									  ,m4.[MenuItemText]
									  ,m4.[MenuItemURL]
									  ,m4.[DisplayOrder]
									  ,m4.[ExternalLink]
									  ,m4.[MenuId]
									  ,dbo.NumberOfChildren(m4.[MenuItemId]) as NumberOfChildren
									  ,m4.[TargetLocation]
								  FROM [MENU_ITEMS] as m4
								  WHERE m4.ParentItemId = m3.MenuItemId AND m4.MenuId = @MenuId AND m4.AudienceId IN (SELECT AudienceId FROM @UsersRoles)
								  ORDER BY m4.DisplayOrder
								  FOR XML AUTO, TYPE)					  							  
							  ,m3.[DisplayOrder]
							  ,m3.[ExternalLink]
						  FROM [MENU_ITEMS] as m3
						  WHERE m3.ParentItemId = m2.MenuItemId AND m3.MenuId = @MenuId AND m3.AudienceId IN (SELECT AudienceId FROM @UsersRoles)
						  ORDER BY m3.DisplayOrder
						  FOR XML AUTO, TYPE)					  
					  ,m2.[DisplayOrder]
					  ,m2.[ExternalLink]
				  FROM [MENU_ITEMS] as m2
				  WHERE m2.ParentItemId = m1.MenuItemId AND m2.MenuId = @MenuId AND m2.AudienceId IN (SELECT AudienceId FROM @UsersRoles)
				  ORDER BY m2.DisplayOrder
				  FOR XML AUTO, TYPE)
			  ,m1.[DisplayOrder]
			  ,m1.[ExternalLink]
		  FROM [MENU_ITEMS] as m1
		  WHERE m1.ParentItemId = m0.MenuItemId AND m1.MenuId = @MenuId AND m1.AudienceId IN (SELECT AudienceId FROM @UsersRoles)
		  ORDER BY m1.DisplayOrder
		  FOR XML AUTO, TYPE)
      ,m0.[DisplayOrder]
      ,m0.[ExternalLink]
FROM [MENU_ITEMS] as m0
WHERE m0.ParentItemId = 0 AND m0.MenuId = @MenuId AND m0.AudienceId IN (SELECT AudienceId FROM @UsersRoles)
ORDER BY m0.DisplayOrder
FOR XML AUTO, TYPE, ROOT('menu');

END