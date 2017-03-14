-- =============================================
-- Author:		Robert Evans
-- Create date: 7 March 2014
-- Description:	Gets a ENET Users Audience Membership
-- =============================================
CREATE PROCEDURE [dbo].[procENET_Audience_Member_SelectListByUser] 
	@usr int=0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;




SELECT  A.AudienceDesc, A.DisplayName,AM.AudienceId,AM.TechnicianId, A.Inactive 
FROM	AUDIENCE_MEMBER as AM
INNER JOIN AUDIENCE as A ON A.AudienceId = AM.AudienceId AND A.Inactive = 0
WHERE     TechnicianId = @usr







END
