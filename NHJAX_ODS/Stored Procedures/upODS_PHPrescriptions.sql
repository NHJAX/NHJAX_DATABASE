



CREATE PROCEDURE [dbo].[upODS_PHPrescriptions] AS

Declare @pat bigint
Declare @drug bigint
Declare @src bigint
Declare @phar bigint

Declare @patX bigint
Declare @drugX bigint
Declare @srcX bigint
Declare @pharX bigint

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin PH Prescription',0,@day;


DECLARE	curPrescription CURSOR FAST_FORWARD FOR 
SELECT
	PAT.PatientId, 
	DRUG.DrugId, 
	6 AS SourceSystemId, 
	0 AS PharmacyId
FROM
	vwSTG_POP_HEALTH_ASTHMA AS PHA 
	INNER JOIN PATIENT AS PAT 
	ON PHA.EDIPN = PAT.PatientIdentifier 
	INNER JOIN DRUG 
	ON PHA.CtrlDrugName = DRUG.DrugDesc
UNION
SELECT     
	PAT.PatientId, 
	DRUG_1.DrugId, 
	6 AS SourceSystemId, 
	0 AS PharmacyId
FROM
	vwSTG_POP_HEALTH_ASTHMA AS PHA 
	INNER JOIN PATIENT AS PAT 
	ON PHA.EDIPN = PAT.PatientIdentifier 
	INNER JOIN DRUG AS DRUG_1 
	ON PHA.Steroid = DRUG_1.DrugDesc  
UNION
SELECT 
	PAT.PatientId,
	DRUG.DrugId,
	6 AS SourceSystemId,
	0 AS PharmacyId
FROM vwSTG_POP_HEALTH_ANTIDEPRESSANT AS PHA
	INNER JOIN PATIENT AS PAT
	ON PHA.EDIPN = PAT.PatientIdentifier
	INNER JOIN DRUG
	ON PHA.[Last Prescription Name] = DRUG.DrugDesc

OPEN curPrescription
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH Prescription',0
FETCH NEXT FROM curPrescription INTO @pat,@drug,@src,@phar

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@patX = PatientId,
			@drugX = DrugId,
			@srcX = SourceSystemId,
			@pharX = PharmacyId
		FROM NHJAX_ODS.dbo.PRESCRIPTION
		WHERE PatientId = @pat
		AND DrugId = @drug
		AND SourceSystemId = @src
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.PRESCRIPTION(
				PatientId,
				DrugId,
				SourceSystemId,
				PharmacyId)
				VALUES(@pat,@drug,@src,@phar);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM curPrescription INTO @pat,@drug,@src,@phar
		
	COMMIT	
	END
END

CLOSE curPrescription
DEALLOCATE curPrescription

SET @sirow = 'PH Prescription Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH Prescription Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End PH Prescription',0,@day;





