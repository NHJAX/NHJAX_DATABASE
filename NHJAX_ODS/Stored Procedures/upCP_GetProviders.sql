
CREATE PROCEDURE [dbo].[upCP_GetProviders]
	
AS
BEGIN

	SET NOCOUNT ON;
SELECT DISTINCT				PCM.ProviderId
							,PRO.ProviderName
--							,tech.userid
FROM						PATIENT P INNER JOIN
							PRIMARY_CARE_MANAGER PCM
							ON P.PatientId = PCM.PatientID INNER JOIN
							PROVIDER PRO ON PCM.ProviderId = PRO.ProviderId
							inner join 
							[NHJAX-SQL-1A].ENET.DBO.TECHNICIAN TECH
							ON TECH.SSN = PRO.PROVIDERSSN

WHERE						TECH.INACTIVE = 0
AND							pro.providerid not in (select pcmexceptionid from pcm_exception)


ORDER BY PRO.PROVIDERNAME

END