
CREATE procedure [dbo].[procCP_SELECT_PROVIDERS_WITH_PATCOUNT_WITH_HIGH_A1C]

AS 
BEGIN

SET NOCOUNT ON

SELECT DISTINCT			PRO.PROVIDERID
						,PRO.ProviderName 
						,count(p.patientid) as PatientCount						
--						,LR.Result
FROM					PROVIDER PRO INNER JOIN	
						PRIMARY_CARE_MANAGER PCM ON PCM.PROVIDERID = PRO.PROVIDERID
						INNER JOIN
                        PATIENT P ON PCM.PATIENTID = P.PATIENTID INNER JOIN
                        DM_DIABETES_LAB_RESULTS LR ON P.PatientId = LR.PatientId

AND						lr.labresulttypeid = 1
AND						lr.result >=  cast(8.0 as nvarchar(4))
AND						PRO.PROVIDERID NOT IN (SELECT PCMEXCEPTIONID FROM PCM_EXCEPTION)
--AND		LR.RESULT IS NOT NULL
--AND		LR.RESULT <> 0

group by  pro.providername
			,PRO.PROVIDERID
order by pro.providername

END