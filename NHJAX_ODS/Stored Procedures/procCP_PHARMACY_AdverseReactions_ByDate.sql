
CREATE procedure [dbo].[procCP_PHARMACY_AdverseReactions_ByDate]
(
@start datetime,
@end datetime

)
as
begin

SELECT		DIAG.DiagnosisDesc, 
			DIAG.DiagnosisCode, 
			dbo.FormatDateWithoutTime(patenc.appointmentdatetime,1)as ApptDate,
			PRO.ProviderName,
			PAT.FullName AS 'PatientName', 
			convert(varchar(2),PAT.FamilyMemberPrefixId) +'/'+ right(PAT.SponsorSSN,4) as 'FMP/SSN'
			
FROM        DIAGNOSIS DIAG
			INNER JOIN
            ENCOUNTER_DIAGNOSIS ENC ON DIAG.DiagnosisId = ENC.DiagnosisId 
			INNER JOIN
            PATIENT_ENCOUNTER PATENC ON ENC.PatientEncounterId = PATENC.PatientEncounterId
			INNER JOIN
            PATIENT PAT ON PATENC.PatientId = PAT.PatientId
			INNER JOIN
            PROVIDER PRO ON PATENC.ProviderId = PRO.ProviderId

WHERE		DIAG.DIAGNOSISCODE LIKE ('E%')
AND		DIAG.DIAGNOSISDESC LIKE ('%ADVERSE%')
--and patenc.appointmentdatetime between(@start) and (@end)
AND		patenc.AppointmentDateTime >= @start
AND		patenc.AppointmentDateTime <= @end

			--('E946.4','E949.9','E943.0','E946.8','E933.0','E935.2','E935.8',
			--'E940.8','E932.9','E936.3','E938.6','E938.9','E946.9','E935.9','E932.0','E932.1','E930.6')

ORDER BY	DIAG.DIAGNOSISCODE,
			DIAG.DIAGNOSISDESC,
			PRO.PROVIDERNAME,
			PAT.FULLNAME
end
