



CREATE PROCEDURE [dbo].[upODS_PHPrescriptionFillDate] AS

Declare @pred bigint
Declare @fill datetime

Declare @predX bigint
Declare @fillX datetime

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin PH Prescription Fill Date',0,@day;


DECLARE	curPrescription CURSOR FAST_FORWARD FOR 
SELECT     
	PDRUG.PrescriptionDrugId, 
	CAST(PHA.CtrlRxDate AS DateTime) AS RxDate
FROM         
	vwSTG_POP_HEALTH_ASTHMA AS PHA 
	INNER JOIN PATIENT AS PAT 
	ON PHA.EDIPN = PAT.PatientIdentifier 
	INNER JOIN DRUG 
	ON PHA.CtrlDrugName = DRUG.DrugDesc 
	INNER JOIN PRESCRIPTION AS PRE 
	ON PAT.PatientId = PRE.PatientId 
	AND DRUG.DrugId = PRE.DrugId 
	INNER JOIN PRESCRIPTION_DRUG AS PDRUG 
	ON PRE.PrescriptionId = PDRUG.PrescriptionId
UNION
SELECT     
	PDRUG.PrescriptionDrugId, 
	CAST(PHA.SteroidRxDate AS DateTime) AS RxDate
FROM         
	vwSTG_POP_HEALTH_ASTHMA AS PHA 
	INNER JOIN PATIENT AS PAT 
	ON PHA.EDIPN = PAT.PatientIdentifier 
	INNER JOIN DRUG AS DRUG_1 
	ON PHA.Steroid = DRUG_1.DrugDesc 
	INNER JOIN PRESCRIPTION AS PRE 
	ON PAT.PatientId = PRE.PatientId 
	AND DRUG_1.DrugId = PRE.DrugId 
	INNER JOIN PRESCRIPTION_DRUG AS PDRUG 
	ON PRE.PrescriptionId = PDRUG.PrescriptionId 
SELECT PDRUG.PrescriptionDrugId,
	CAST(PHA.[Last Prescription Date] AS DateTime) AS RxDate
FROM
	vwSTG_POP_HEALTH_ANTIDEPRESSANT AS PHA
	INNER JOIN PATIENT AS PAT
	ON PHA.EDIPN = PAT.PatientIdentifier
	INNER JOIN DRUG
	ON PHA.[Last Prescription Name] = DRUG.DrugDesc
	INNER JOIN PRESCRIPTION AS PRE
	ON PAT.PatientId = PRE.PatientId
	AND DRUG.DrugId = PRE.DrugId
	INNER JOIN PRESCRIPTION_DRUG AS PDRUG
	ON PRE.PrescriptionId = PDRUG.PrescriptionDrugId



OPEN curPrescription
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH Prescription Fill Date',0
FETCH NEXT FROM curPrescription INTO @pred,@fill

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@predX = PrescriptionDrugId,
				@fillX = FillDate
		FROM NHJAX_ODS.dbo.PRESCRIPTION_FILL_DATE
		WHERE PrescriptionDrugId = @pred
		AND FillDate = @fill

		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.PRESCRIPTION_FILL_DATE(
				PrescriptionDrugId,
				FillDate)
				VALUES(@pred,@fill);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM curPrescription INTO @pred,@fill
		
	COMMIT	
	END
END

CLOSE curPrescription
DEALLOCATE curPrescription

SET @sirow = 'PH Prescription Fill Date Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH Prescription Fill Date Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End PH Fill Date Prescription',0,@day;





