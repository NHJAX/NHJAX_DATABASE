

CREATE PROCEDURE [dbo].[upEDPTS_RVU]
(
@pro decimal, 
@date datetime,
@rvu money output
)
AS  
BEGIN

DECLARE @start datetime
DECLARE @end datetime

SET @start = dbo.StartofDay(@date)
SET @end = dbo.EndofDay(@date)

	SELECT @rvu =    
		ISNULL(SUM(CPT.RVU),0) 
		FROM dbo.CPT AS CPT
		INNER JOIN dbo.PATIENT_PROCEDURE AS PP 
		ON CPT.CptId = PP.CptId 
		INNER JOIN dbo.PATIENT_ENCOUNTER AS PE 
		ON PP.PatientEncounterId = PE.PatientEncounterId 
		INNER JOIN dbo.PROVIDER AS PRO 
		ON PE.ProviderId = PRO.ProviderId
		WHERE (PE.HospitalLocationId = 174) 
		AND (PRO.ProviderKey = @pro) 
		AND (PE.AppointmentDateTime 
		BETWEEN @start 
		AND @end) 
	--DECLARE @endOfDay	datetime;
	--SET @endOfDay = CONVERT(varchar(20), @date, 101) + ' 23:59:59';
	--RETURN @rvu;
END


