

create PROCEDURE [dbo].[upODS_PatientEncounterUpdateNonCount20070920] AS

Declare @encID bigint
Declare @appt decimal
Declare @pat bigint
Declare @date datetime
Declare @loc bigint
Declare @pro bigint
Declare @duration decimal
Declare @stat bigint
Declare @reason varchar(80)
Declare @disp bigint
Declare @enc decimal
Declare @type bigint
Declare @ref bigint
Declare @dis datetime
Declare @adm datetime
Declare @made datetime
Declare @atc bigint
Declare	@datc datetime
Declare @pri bigint
Declare @ss bigint
Declare @ac bigint
Declare @rel bigint
Declare @drel datetime
Declare @mep bigint
Declare @non bit

Declare @idX bigint
Declare @apptX decimal
Declare @patX decimal
Declare @dateX datetime
Declare @locX bigint
Declare @proX bigint
Declare @durationX decimal
Declare @statX bigint
Declare @reasonX varchar(80)
Declare @dispX bigint
Declare @encX decimal
Declare @typeX bigint
Declare @refX bigint
Declare @disX datetime
Declare @admX datetime
Declare @madeX datetime
Declare @atcX bigint
Declare	@datcX datetime
Declare @priX bigint
Declare @ssX bigint
Declare @acX bigint
Declare @relX bigint
Declare @drelX datetime
Declare @mepX bigint
Declare @nonX bit

Declare @urow int
Declare @trow int
Declare @irow int
Declare @drow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @sdrow varchar(50)
Declare @fromDate datetime
Declare @tempDate datetime
Declare @today datetime
Declare @exists int

EXEC dbo.upActivityLog 'Begin Patient Encounters',0;
SET @tempDate = DATEADD(d,-400,getdate());
SET @fromDate = dbo.StartOfDay(@tempDate); 

DECLARE curAppt CURSOR FAST_FORWARD FOR
SELECT DISTINCT 
	PA.KEY_PATIENT_APPOINTMENT, 
	CASE PA.WORKLOAD_TYPE
		WHEN 'NON-COUNT' THEN 1
		ELSE 0 END AS IsNonCount
FROM	MEPRS_CODE AS MEPRS 
	INNER JOIN HOSPITAL_LOCATION AS LOC 
	ON MEPRS.MeprsCodeId = LOC.MeprsCodeId 
	RIGHT OUTER JOIN ACCESS_TO_CARE AS ATC 
	RIGHT OUTER JOIN vwMDE_PATIENT_APPOINTMENT AS PA 
	INNER JOIN PATIENT AS PAT 
	ON PA.NAME_IEN = PAT.PatientKey 
	INNER JOIN PROVIDER AS PRO 
	ON PA.PROVIDER_IEN = PRO.ProviderKey 
	LEFT OUTER JOIN vwMDE_KG_ADC_DATA AS KG 
	ON PA.KEY_PATIENT_APPOINTMENT = KG.APPOINTMENT_IEN 
	LEFT OUTER JOIN SOURCE_SYSTEM AS SS 
	ON KG.SOURCE_SYSTEM = SS.SourceSystemDesc 
	LEFT OUTER JOIN PRIORITY AS PRI 
	ON PA.PRIORITY = PRI.PriorityDesc 
	LEFT OUTER JOIN vwMDE_ENCOUNTER AS ENC 
	ON PA.ENCOUNTER_PTR_IEN = ENC.KEY_ENCOUNTER 
	ON  ATC.AccessToCareKey = PA.ATC_CATEGORY_IEN 
	LEFT OUTER JOIN APPOINTMENT_TYPE AS TYPE 
	ON PA.APPOINTMENT_TYPE_IEN = TYPE.AppointmentTypeKey 
	LEFT OUTER JOIN vwPatientEncounterReferrals AS PE_REF 
	INNER JOIN REFERRAL AS REF 
	ON PE_REF.ReferralKey = REF.ReferralKey 
	ON PA.KEY_PATIENT_APPOINTMENT = PE_REF.PatientEncounterKey 
	LEFT OUTER JOIN PATIENT_DISPOSITION AS DISP 
	ON PA.OUTPATIENT_DISPOSITION_IEN = DISP.PatientDispositionKey 
	LEFT OUTER JOIN APPOINTMENT_STATUS AS STAT 
	ON PA.APPOINTMENT_STATUS_IEN = STAT.AppointmentStatusKey 
	ON LOC.HospitalLocationKey = PA.CLINIC_IEN
WHERE     (PA.APPOINTMENT_DATE_TIME >= @fromDate) 


OPEN curAppt
SET @trow = 0
SET @irow = 0
SET @urow = 0
SET @drow = 0
EXEC dbo.upActivityLog 'Fetch Patient Encounters',0
FETCH NEXT FROM curAppt INTO @appt,@non
if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		
		Select 	
			@apptX = PatientAppointmentKey,
			@nonX = IsNonCount
		FROM NHJAX_ODS.dbo.PATIENT_ENCOUNTER
		WHERE PatientAppointmentKey = @appt
		AND SourceSystemId NOT IN (7)
		
		SET @exists = @@RowCount
		If @exists <> 0 
			BEGIN

		IF	@non <> @nonX
		OR	(@non Is Not Null AND @nonX Is Null)
			BEGIN
			SET @today = getdate()
			UPDATE NHJAX_ODS.dbo.PATIENT_ENCOUNTER
			SET 	
				IsNonCount = @non
			WHERE PatientAppointmentKey = @appt
			AND SourceSystemId NOT IN (7);
			SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1

		

		FETCH NEXT FROM curAppt INTO @appt,@non
	COMMIT
	END

END
CLOSE curAppt
DEALLOCATE curAppt
SET @surow = 'Patient Encounters Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Patient Encounters Inserted: ' + CAST(@irow AS varchar(50))
SET @sdrow = 'Patient Encounters Deleted: ' + CAST(@drow AS varchar(50))
SET @strow = 'Patient Encounters Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @sdrow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Patient Encounters',0;







