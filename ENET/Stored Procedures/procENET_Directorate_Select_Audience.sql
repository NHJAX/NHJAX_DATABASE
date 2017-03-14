-- =============================================
-- Author:		Robert E Evans
-- Create date: 6 Feb 2012
-- Description:	Selects Audiences grouped by Directorate
-- =============================================
CREATE PROCEDURE [dbo].[procENET_Directorate_Select_Audience] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT D.DirectorateId
		  ,D.ShortName
		  ,D.DirectorateCode
		  ,D.DirectorateDesc
		  ,A.AudienceId
		  ,A.AudienceDesc
		  ,A.OrgChartCode
	FROM vwENET_AUDIENCE_DIRECTORATE as EAD
	INNER JOIN AUDIENCE as A ON A.AudienceId = EAD.AudienceId AND A.AudienceCategoryId IN (0,1,2,3,7)
	INNER JOIN DIRECTORATE as D ON D.DirectorateId = EAD.DirectorateId
	ORDER BY D.DirectorateDesc, A.AudienceDesc

END

