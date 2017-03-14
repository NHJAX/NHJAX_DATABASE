
CREATE PROCEDURE [dbo].[upODS_PatientAdmission] AS

Declare @key numeric(13,3)
Declare @pat bigint
Declare @adm bigint
Declare @dis bigint
Declare @phy1 bigint
Declare @phy2 bigint
Declare @dtadm datetime
Declare @dtdis datetime
Declare @sur varchar(3)
Declare @loc bigint
Declare @diag bigint
Declare @asvc bigint
Declare @ord numeric(21,3)
Declare @enc numeric(13,3)
Declare @aord numeric(21,3)

Declare @keyX numeric(13,3)
Declare @patX bigint
Declare @admX bigint
Declare @disX bigint
Declare @phy1X bigint
Declare @phy2X bigint
Declare @dtadmX datetime
Declare @dtdisX datetime
Declare @surX varchar(3)
Declare @locX bigint
Declare @diagX bigint
Declare @asvcX bigint
Declare @ordX numeric(21,3)
Declare @encX numeric(13,3)
Declare @aordX numeric(21,3)

Declare @urow int
Declare @trow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @fromDate datetime
Declare @tempDate datetime
Declare @today datetime
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Admissions',0,@day;

SET @tempDate = DATEADD(d,-365,getdate());
SET @fromDate = dbo.StartOfDay(@tempDate); 

/*SET @today = getdate()*/

DECLARE curAdm CURSOR FAST_FORWARD FOR
SELECT	vwMDE_PATIENT$ADMISSION_DATE.KEY_PATIENT$ADMISSION_DATE, 
	PAT.PatientId, 
	ISNULL(ADM.AdmissionTypeId, 0) AS AdmissionTypeId, 
	ISNULL(DIS.DischargeTypeId, 0) AS DischargeTypeId, 
	ISNULL(PRO1.ProviderId, 0) AS AdmittingPhysicianId, 
	ISNULL(PRO2.ProviderId, 0) AS AttendingPhysicianId, 
    dbo.AdmissionDateTime(vwMDE_PATIENT$ADMISSION_DATE.ADMISSION_DATE) AS AdmissionDate, 
	dbo.AdmissionDateTime(vwMDE_PATIENT$ADMISSION_DATE.DISPOSITION_DATE) AS DispositionDate, 
    ISNULL(vwMDE_PATIENT$ADMISSION_DATE.SAME_DAY_SURGERY, 'N/A') AS SameDaySurgery,
    ISNULL(LOC.HospitalLocationId, 0) AS WardLocationId,
    ISNULL(DIAG.DiagnosisId, 0) AS DiagnosisId,
    ISNULL(DPT.DepartmentId,0) AS DepartmentandServiceId,
    vwMDE_PATIENT$ADMISSION_DATE.DISPOSITION_ORDER_IEN,
    REPLACE(vwMDE_PATIENT$ADMISSION_DATE.ADMISSION_ENCOUNTER,'`',''),
    ISNULL(vwMDE_PATIENT$ADMISSION_DATE.ADMISSION_ORDER_IEN,0)
FROM    ADMISSION_TYPE ADM 
	RIGHT OUTER JOIN vwMDE_PATIENT$ADMISSION_DATE 
	INNER JOIN PATIENT PAT 
	ON vwMDE_PATIENT$ADMISSION_DATE.KEY_PATIENT = PAT.PatientKey 
	LEFT OUTER JOIN PROVIDER PRO1 
	ON vwMDE_PATIENT$ADMISSION_DATE.ADMITTING_PHYSICIAN_IEN = PRO1.ProviderKey 
	LEFT OUTER JOIN PROVIDER PRO2 
	ON vwMDE_PATIENT$ADMISSION_DATE.ATTENDING_PHYSICIAN_IEN = PRO2.ProviderKey 
	LEFT OUTER JOIN DISCHARGE_TYPE DIS 
	ON vwMDE_PATIENT$ADMISSION_DATE.TYPE_OF_DISPOSITION_IEN = DIS.DischargeTypeKey 
	ON ADM.AdmissionTypeKey = vwMDE_PATIENT$ADMISSION_DATE.TYPE_OF_ADMISSION_IEN
	LEFT OUTER JOIN HOSPITAL_LOCATION AS LOC
	ON vwMDE_PATIENT$ADMISSION_DATE.WARD_LOCATION_IEN = LOC.HospitalLocationKey
	LEFT OUTER JOIN DIAGNOSIS AS DIAG
	ON vwMDE_PATIENT$ADMISSION_DATE.DIAGNOSIS_AT_ADMISSION_IEN = DIAG.DiagnosisKey
	LEFT OUTER JOIN DEPARTMENT AS DPT
	ON vwMDE_PATIENT$ADMISSION_DATE.ADMITTING_SERVICE_IEN = DPT.DepartmentKey
WHERE dbo.AdmissionDateTime(vwMDE_PATIENT$ADMISSION_DATE.ADMISSION_DATE) >= @fromDate

OPEN curAdm
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Admissions',0
FETCH NEXT FROM curAdm INTO @key,@pat,@adm,@dis,@phy1,@phy2,@dtadm,@dtdis,
	@sur,@loc,@diag,@asvc,@ord,@enc,@aord
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@admX = AdmissionTypeId,
			@disX = DischargeTypeId,
			@phy1X = AdmittingPhysicianId,
			@phy2X = AttendingPhysicianId,
			@dtadmX = AdmissionDate,
			@dtdisX = DischargeDate,
			@surX = SameDaySurgery,
			@locX = HospitalLocationId,
			@diagX = DiagnosisAtAdmissionId,
			@asvcX = AdmittingServiceId,
			@ordX = DispositionOrder,
			@encX = EncounterKey,
			@aordX = AdmissionOrderKey
		FROM NHJAX_ODS.dbo.PATIENT_ADMISSION
		WHERE PatientAdmissionKey = @key
		AND PatientId = @pat;
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.PATIENT_ADMISSION(
				PatientAdmissionKey,
				PatientId,
				AdmissionTypeId,
				DischargeTypeId,
				AdmittingPhysicianId,
				AttendingPhysicianId,
				AdmissionDate,
				DischargeDate,
				SameDaySurgery,
				HospitalLocationId,
				DiagnosisAtAdmissionId,
				AdmittingServiceId,
				DispositionOrder,
				EncounterKey,
				AdmissionOrderKey)
				VALUES(@key,@pat,@adm,@dis,@phy1,@phy2,@dtadm,@dtdis,
				@sur,@loc,@diag,@asvc,@ord,@enc,@aord);
				SET @irow = @irow + 1
			END
		ELSE
		BEGIN
		IF	@adm <> @admX
		OR	@dis <> @disX
		OR	@phy1 <> @phy1X
		OR	@phy2 <> @phy2X
		OR	@dtadm <> @dtadmX
		OR	@dtdis <> @dtdisX
		OR	@sur <> @surX
		OR 	(@adm Is Not Null AND @admX Is Null)
		OR 	(@dis Is Not Null AND @disX Is Null)
		OR 	(@phy1 Is Not Null AND @phy1X Is Null)
		OR 	(@phy2 Is Not Null AND @phy2X Is Null)
		OR	(@dtadm Is Not Null AND @dtadmX Is Null)
		OR	(@dtdis Is Not Null AND @dtdisX Is Null)
		OR	(@sur Is Not Null AND @surX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.PATIENT_ADMISSION
			SET 	AdmissionTypeId = @adm,
				DischargeTypeId = @dis,
				AdmittingPhysicianId = @phy1,
				AttendingPhysicianId = @phy2,
				AdmissionDate = @dtadm,
				DischargeDate = @dtdis,
				SameDaySurgery = @sur,
				UpdatedDate = getdate()
			WHERE PatientAdmissionKey = @key
			AND PatientId = @pat;
			SET @urow = @urow + 1
			END
			
		IF @loc <> @locX
			OR (@loc IS NOT NULL AND @locX IS NULL)
			BEGIN
				UPDATE PATIENT_ADMISSION
				SET HospitalLocationId = @loc
				WHERE PatientAdmissionKey = @key
				AND PatientId = @pat;
			END	
			
		IF @diag <> @diagX
			OR (@diag IS NOT NULL AND @diagX IS NULL)
			BEGIN
				UPDATE PATIENT_ADMISSION
				SET DiagnosisAtAdmissionId = @diag
				WHERE PatientAdmissionKey = @key
				AND PatientId = @pat;
			END	
			
		IF @asvc <> @asvcX
			OR (@asvc IS NOT NULL AND @asvcX IS NULL)
			BEGIN
				UPDATE PATIENT_ADMISSION
				SET AdmittingServiceId = @asvc
				WHERE PatientAdmissionKey = @key
				AND PatientId = @pat;
			END	
			
		IF @ord <> @ordX
			OR (@ord IS NOT NULL AND @ordX IS NULL)
			BEGIN
				UPDATE PATIENT_ADMISSION
				SET DispositionOrder = @ord
				WHERE PatientAdmissionKey = @key
				AND PatientId = @pat;
			END
			
		IF @enc <> @encX
			OR (@enc IS NOT NULL AND @encX IS NULL)
			BEGIN
				UPDATE PATIENT_ADMISSION
				SET EncounterKey = @enc
				WHERE PatientAdmissionKey = @key
				AND PatientId = @pat;
			END
			
		IF @aord <> @aordX
			OR (@aord IS NOT NULL AND @aordX IS NULL)
			BEGIN
				UPDATE PATIENT_ADMISSION
				SET AdmissionOrderKey = @aord
				WHERE PatientAdmissionKey = @key
				AND PatientId = @pat;
			END	
			
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curAdm INTO @key,@pat,@adm,@dis,@phy1,@phy2,@dtadm,
			@dtdis,@sur,@loc,@diag,@asvc,@ord,@enc,@aord
	COMMIT	
	END
END
CLOSE curAdm
DEALLOCATE curAdm
SET @surow = 'Admission Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Admission Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Admission Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Admission',0,@day;
