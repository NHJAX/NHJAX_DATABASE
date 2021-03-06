﻿CREATE PROCEDURE [dbo].[GetProviderReportCard20120815]
(
	@ClinicID 	bigint,
	@StartDate 	smalldatetime,
	@EndDate 	smalldatetime
)
AS
SET NOCOUNT ON;

SELECT 	PRO.ProviderName AS Provider, COUNT(DISTINCT(APP.PATIENTENCOUNTERID)) AS [Appointment Count]

FROM 		PROVIDER PRO INNER JOIN PATIENT_ENCOUNTER APP ON APP.PROVIDERID = PRO.PROVIDERID
		INNER JOIN APPOINTMENT_STATUS STA ON STA.APPOINTMENTSTATUSID = APP.APPOINTMENTSTATUSID

WHERE 	 APP.HOSPITALLOCATIONID = @ClinicID
		AND APP.APPOINTMENTDATETIME BETWEEN @StartDate AND @EndDate
		AND STA.APPOINTMENTSTATUSID IN ('2', '5', '6')

GROUP BY	ProviderName
ORDER BY	ProviderName