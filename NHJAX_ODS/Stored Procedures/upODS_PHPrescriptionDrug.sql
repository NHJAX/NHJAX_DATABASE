



CREATE PROCEDURE [dbo].[upODS_PHPrescriptionDrug] AS

Declare @pre bigint
Declare @drug bigint

Declare @preX bigint
Declare @drugX bigint

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin PH Prescription Drug',0,@day;


DECLARE	curPrescription CURSOR FAST_FORWARD FOR 
SELECT     
	PRE.PrescriptionId, 
	DRUG.DrugId
FROM 
	vwSTG_POP_HEALTH_ASTHMA AS PHA 
	INNER JOIN PATIENT AS PAT 
	ON PHA.EDIPN = PAT.PatientIdentifier  
	INNER JOIN DRUG 
	ON PHA.CtrlDrugName = DRUG.DrugDesc 
	INNER JOIN PRESCRIPTION AS PRE 
	ON PAT.PatientId = PRE.PatientId 
	AND DRUG.DrugId = PRE.DrugId
UNION
SELECT     
	PRE.PrescriptionId, 
	DRUG_1.DrugId
FROM         
	vwSTG_POP_HEALTH_ASTHMA AS PHA 
	INNER JOIN PATIENT AS PAT 
	ON PHA.EDIPN = PAT.PatientIdentifier
	INNER JOIN DRUG AS DRUG_1 
	ON PHA.Steroid = DRUG_1.DrugDesc 
	INNER JOIN PRESCRIPTION AS PRE 
	ON PAT.PatientId = PRE.PatientId 
	AND DRUG_1.DrugId = PRE.DrugId 
UNION
SELECT
	PRE.PrescriptionId,
	DRUG.DrugId
FROM
	vwSTG_POP_HEALTH_ANTIDEPRESSANT AS PHA
	INNER JOIN PATIENT AS PAT
	ON PHA.EDIPN = PAT.PatientIdentifier
	INNER JOIN DRUG
	ON PHA.[Last Prescription Name] = DRUG.DrugDesc
	INNER JOIN PRESCRIPTION AS PRE
	ON PAT.PatientId = PRE.PatientId
	AND DRUG.DrugId = PRE.DrugId

OPEN curPrescription
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH Prescription Drug',0
FETCH NEXT FROM curPrescription INTO @pre,@drug

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@preX = PrescriptionId,
			@drugX = DrugId
		FROM NHJAX_ODS.dbo.PRESCRIPTION_DRUG
		WHERE PrescriptionId = @pre
		AND DrugId = @drug

		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.PRESCRIPTION_DRUG(
				PrescriptionId,
				DrugId)
				VALUES(@pre,@drug);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM curPrescription INTO @pre,@drug
		
	COMMIT	
	END
END

CLOSE curPrescription
DEALLOCATE curPrescription

SET @sirow = 'PH Prescription Drug Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH Prescription Drug Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End PH Drug Prescription',0,@day;





