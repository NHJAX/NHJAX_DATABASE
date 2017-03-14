
CREATE PROCEDURE [dbo].[upODS_Procedure] AS

Declare @pri decimal
Declare @cpt bigint
Declare @enc bigint
Declare @type bigint
Declare @diag decimal
Declare @date datetime
Declare @surgeon bigint
Declare @anesth bigint
Declare @desc varchar(60)
Declare @rvu money
Declare @src bigint

Declare @priX decimal
Declare @cptX bigint
Declare @encX bigint
Declare @typeX bigint
Declare @diagX decimal
Declare @dateX datetime
Declare @surgeonX bigint
Declare @anesthX bigint
Declare @descX varchar(60)
Declare @rvuX money
Declare @srcX bigint

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

EXEC dbo.upActivityLog 'Begin Procedures',0,@day;
SET @tempDate = DATEADD(d,-30,getdate());
SET @fromDate = dbo.StartOfDay(@tempDate); 

DECLARE curProcedure CURSOR FAST_FORWARD FOR
SELECT	KG_EM.KEY_KG_ADC_DATA$EVAL_MGMT_CODE AS ProcedureKey, 
	CPT.CptId, 
	ENC.PatientEncounterId, 
	2 AS ProcedureTypeId, 
	KG_EM.DIAGNOSIS_PRIORITIES, 
	NULL AS SurgeonId, 
	NULL AS AnesthetistId, 
	ENC.AppointmentDateTime AS ProcedureDateTime,
	KGCPT.DESCRIPTION,
	CPT.RVU,
	ENC.SourceSystemId
FROM   vwMDE_KG_ADC_DATA$EVAL_MGMT_CODE KG_EM 
	INNER JOIN vwMDE_KG_CPT_EVALUATION_MANAGEMENT KGCPT 
	ON KG_EM.EVAL_MGMT_CODE_IEN = KGCPT.KEY_KG_CPT_EVALUATION_MANAGEMENT 
	INNER JOIN CPT 
	ON KGCPT.POINTER_TO_CPT_HCPCS_IEN = CPT.CptHcpcsKey 
	INNER JOIN vwMDE_KG_ADC_DATA KG 
	ON KG_EM.KEY_KG_ADC_DATA = KG.KEY_KG_ADC_DATA 
	INNER JOIN PATIENT_ENCOUNTER ENC 
	ON KG.APPOINTMENT_IEN = ENC.PatientAppointmentKey
WHERE  	(CPT.CptTypeId IN (0,2))
AND	ENC.AppointmentDateTime >= @fromDate
UNION 	
SELECT 	KG_CPT.KEY_KG_ADC_DATA$CPT_CODE AS ProcedureKey, 
	CPT.CptId, 
	ENC.PatientEncounterId, 
	1 AS ProcedureTypeId, 
	KG_CPT.DIAGNOSIS_PRIORITY, 
	NULL AS SurgeonId, 
	NULL AS AnesthetistId,
	ENC.AppointmentDateTime AS ProcedureDateTime,
	CPT.CptDesc,
	CPT.RVU,
	ENC.SourceSystemId
FROM    vwMDE_KG_ADC_DATA KG 
	INNER JOIN PATIENT_ENCOUNTER ENC 
	ON KG.APPOINTMENT_IEN = ENC.PatientAppointmentKey 
	INNER JOIN vwMDE_KG_ADC_DATA$CPT_CODE KG_CPT 
	ON KG.KEY_KG_ADC_DATA = KG_CPT.KEY_KG_ADC_DATA 
	INNER JOIN CPT 
	ON KG_CPT.CPT_CODE_IEN = CPT.CptHcpcsKey
WHERE  	(CPT.CptTypeId IN (0,2))
AND	ENC.AppointmentDateTime >= @fromDate
UNION
SELECT 	ENC_ICD.KEY_ENCOUNTER$ICD_OPERATIONS_PROCEDURES AS ProcedureKey, 
	CPT.CptId, 
	ENC.PatientEncounterId, 
	3 AS ProcedureTypeId, 
	0 AS Diagnosis_Priority, 
	PRO.ProviderId AS SurgeonId, 
	PRO2.ProviderId AS AnesthetistId, 
	ENC_ICD.DATE_TIME AS ProcedureDateTime,
	CPT.CptDesc,
	CPT.RVU,
	ENC.SourceSystemId
FROM    vwMDE_ENCOUNTER$ICD_OPERATIONS_PROCEDURES ENC_ICD 
	INNER JOIN CPT 
	ON ENC_ICD.ICD_OPERATIONS_PROCEDURES_IEN = CPT.CptHcpcsKey 
	INNER JOIN PATIENT_ENCOUNTER ENC 
	ON ENC_ICD.KEY_ENCOUNTER = ENC.EncounterKey 
	LEFT OUTER JOIN PROVIDER PRO2 
	ON ENC_ICD.ANESTHESIOLOGIST_IEN = PRO2.ProviderKey 
	LEFT OUTER JOIN PROVIDER PRO 
	ON ENC_ICD.SURGEON_IEN = PRO.ProviderKey
WHERE   (CPT.CptTypeId = 1)
AND	ENC.AppointmentDateTime >= @fromDate
OPEN curProcedure
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Procedure',0
FETCH NEXT FROM curProcedure INTO @pri,@cpt,@enc,@type,@diag,@surgeon,
	@anesth,@date,@desc,@rvu,@src
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@priX = ProcedureKey,
			@cptX = CptId,
			@encX = PatientEncounterId,
			@typeX = ProcedureTypeId,
			@diagX = DiagnosisPriorities,
			@dateX = ProcedureDateTime,
			@surgeonX = SurgeonId,
			@anesthX = AnesthetistId,
			@descX = ProcedureDesc,
			@rvuX = RVU,
			@srcX = SourceSystemId
		FROM NHJAX_ODS.dbo.PATIENT_PROCEDURE
		WHERE PatientEncounterId = @enc
		AND CptId = @cpt
		AND SourceSystemId NOT IN (7)
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.PATIENT_PROCEDURE(
				ProcedureKey,
				CptId,
				PatientEncounterId,
				ProcedureTypeId,
				DiagnosisPriorities,
				ProcedureDateTime,
				SurgeonId,
				AnesthetistId,
				ProcedureDesc,
				RVU,
				SourceSystemId)
				VALUES(@pri,@cpt,@enc,@type,@diag,@date,@surgeon,
				@anesth,@desc,@rvu,@src);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@pri <> @priX
		OR	@type <> @typeX
		OR	@diag <> @diagX
		OR	@date <> @dateX
		OR	@surgeon <> @surgeonX
		OR	@anesth <> @anesthX
		OR	@desc <> @descX		
		OR	@src <> @srcX
		OR 	(@pri Is Not Null AND @priX Is Null)
		OR 	(@type Is Not Null AND @typeX Is Null)
		OR 	(@diag Is Not Null AND @diagX Is Null)
		OR 	(@date Is Not Null AND @dateX Is Null)
		OR 	(@surgeon Is Not Null AND @surgeonX Is Null)
		OR 	(@anesth Is Not Null AND @anesthX Is Null)
		OR	(@desc Is Not Null AND @descX Is Null)
		OR	(@src Is Not Null AND @srcX Is Null)
			BEGIN
			SET @today = getdate()
			UPDATE NHJAX_ODS.dbo.PATIENT_PROCEDURE
			SET 	ProcedureKey = @pri,
				ProcedureTypeId = @type,
				DiagnosisPriorities = @diag,
				ProcedureDateTime = @date,
				SurgeonId = @surgeon,
				AnesthetistId = @anesth,
				UpdatedDate = @today,
				ProcedureDesc = @desc,
				SourceSystemId = @src
			WHERE PatientEncounterId = @enc
			AND CptId = @cpt
			AND SourceSystemId NOT IN (7);
			SET @urow = @urow + 1
			END
		END
		IF (@rvu > 0 AND @rvuX = 0)
			OR (@rvu Is Not NUll AND @rvuX Is Null)
			BEGIN
				UPDATE NHJAX_ODS.dbo.PATIENT_PROCEDURE
				SET RVU = @rvu
				WHERE PatientEncounterId = @enc
				AND CptId = @cpt
				AND SourceSystemId NOT IN (7);
			END
		SET @trow = @trow + 1
		FETCH NEXT FROM curProcedure INTO @pri,@cpt,@enc,@type,@diag,
			@surgeon,@anesth,@date,@desc,@rvu,@src
	COMMIT	
	END
END
CLOSE curProcedure
DEALLOCATE curProcedure
SET @surow = 'Procedure Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Procedure Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Procedure Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Procedure',0,@day;
