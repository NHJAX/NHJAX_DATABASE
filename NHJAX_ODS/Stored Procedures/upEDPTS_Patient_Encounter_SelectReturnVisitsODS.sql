

CREATE PROCEDURE [dbo].[upEDPTS_Patient_Encounter_SelectReturnVisitsODS]
(
	@pat		bigint,
	@chk		smalldatetime
)
WITH RECOMPILE 
AS

select Count(p.patientkey)
from patient_encounter pa
inner join patient p
on p.patientid = pa.patientid
where p.PatientKey = @pat
and pa.appointmentdatetime >= DATEADD(hh, -72, @chk) 
and pa.appointmentdatetime < @chk
