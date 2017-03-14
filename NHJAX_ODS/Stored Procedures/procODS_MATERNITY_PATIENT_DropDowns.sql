-- =============================================
-- Author:		Robert Evans
-- Create date: 19 Aug 2011
-- Description:	Gets The Dropdown Data for the Maternity Page
-- =============================================
CREATE PROCEDURE [dbo].[procODS_MATERNITY_PATIENT_DropDowns]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

DECLARE @RC int
DECLARE @aud bigint


SET @aud = 0
-- TODO: Set parameter values here.
EXECUTE @RC = [NHJAX-SQL-1A].[ENET].[dbo].[procENET_Technician_SelectActiveFPProvidersbyAudience] 
   @aud

		--SELECT DISTINCT
		--	ISNULL(PRO.ProviderId,0) as ProviderId,
		--	ISNULL(PRO.ProviderName,'UNKNOWN') as ProviderName
		--FROM PROVIDER AS PRO 
		--	INNER JOIN PRIMARY_CARE_MANAGER AS PCM 
		--	ON PRO.ProviderId = PCM.ProviderId 
		--	RIGHT OUTER JOIN MATERNITY_PATIENT AS MPAT 
		--	INNER JOIN PATIENT AS PAT 
		--	ON MPAT.PatientId = PAT.PatientId 
		--	LEFT OUTER JOIN FAMILY_MEMBER_PREFIX AS FMP 
		--	ON PAT.FamilyMemberPrefixId = FMP.FamilyMemberPrefixId 
		--	LEFT OUTER JOIN GEOGRAPHIC_LOCATION AS LOC 
		--	ON PAT.StateId = LOC.GeographicLocationId 
		--	ON PCM.PatientID = PAT.PatientId
		--ORDER BY ProviderName


	SELECT [MaternityStatusId]
		  ,[MaternityStatusDesc]
	  FROM [NHJAX_ODS].[dbo].[MATERNITY_STATUS]
	ORDER BY [MaternityStatusDesc]

	  
	SELECT [MaternityTeamId]
		  ,[MaternityTeamDesc]
	  FROM [NHJAX_ODS].[dbo].[MATERNITY_TEAM]
	ORDER BY [MaternityTeamDesc]  

END
