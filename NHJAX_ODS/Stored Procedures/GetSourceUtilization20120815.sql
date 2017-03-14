CREATE PROCEDURE [dbo].[GetSourceUtilization20120815] 
(
	@StartDate	smalldatetime,
	@EndDate	smalldatetime
)
WITH RECOMPILE
AS
BEGIN
select pe.appointmentdatetime as Appointment, p.providername as Provider, 
l.hospitallocationname as Clinic, ss.displayname as Source
from patient_encounter pe
left outer join provider p on pe.providerid=p.providerid
left outer join hospital_location l on pe.hospitallocationid=l.hospitallocationid
left outer join source_system ss on pe.sourcesystemid=ss.sourcesystemid
where pe.appointmentdatetime between @StartDate and @EndDate
END