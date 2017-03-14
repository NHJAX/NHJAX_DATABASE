-- =============================================
-- Author:		Robert E Evans
-- Create date: 4 April 2012
-- Description:	Selects all the Audiences that Report to a given Directorate
-- =============================================
CREATE PROCEDURE [dbo].[procENET_Directorate_Audience_Select]
	@DirectorateId int=0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT A.[AudienceId]
		  ,A.[AudienceDesc]
		  ,A.[DisplayName]
		  ,A.[OrgChartCode]
		  ,A.[ReportsUnder]
		  ,A.[IsSubGroup]
		  ,A.[Inactive]
		  ,A.[SortOrder]
	FROM AUDIENCE as A
	INNER JOIN vwENET_AUDIENCE_DIRECTORATE as vAD ON vAD.AudienceId = A.AudienceId
		AND vAD.DirectorateId = @DirectorateId
	ORDER BY A.[SortOrder], A.DisplayName


END
