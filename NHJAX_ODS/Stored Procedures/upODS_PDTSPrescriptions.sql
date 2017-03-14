




CREATE PROCEDURE [dbo].[upODS_PDTSPrescriptions] AS

Declare @rx varchar(20)
Declare @pat bigint
Declare @stat bigint
Declare @apre varchar(26)
Declare @src bigint
Declare @phar bigint
Declare @drug bigint

Declare @rxX varchar(20)
Declare @patX bigint
Declare @statX bigint
Declare @apreX varchar(26)
Declare @srcX bigint
Declare @pharX bigint
Declare @drugX bigint

Declare @trow int
Declare @irow int
Declare @urow int
Declare @sirow varchar(50)
Declare @surow varchar(50)
Declare @strow varchar(50)
Declare @fromDate datetime
Declare @tempDate datetime
Declare @today datetime
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin PDTS Prescription',0,@day;

SET @tempDate = DATEADD(d,-30,getdate());
SET @fromDate = dbo.StartOfDay(@tempDate); 
DECLARE curPrescription CURSOR FAST_FORWARD FOR
SELECT DISTINCT 
	PDTSACC.ACCEPTED_PRESCRIPTION_NUMBER
	,PAT.PatientId
	,12 AS PreStatusId
	,PDTSACC.ACCEPTED_PRESCRIBER_ID
	,5 AS SourceSystemId
    ,ISNULL(PHAR.PharmacyId, 0) AS PharmacyId
    ,D.DrugId    
FROM
	vwMDE_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL AS PDTSACC 
	INNER JOIN vwMDE_PDTS_PROFILE_COLLECTION_FILE AS PDTS 
	ON PDTSACC.KEY_PDTS_PROFILE_COLLECTION_FILE = PDTS.KEY_PDTS_PROFILE_COLLECTION_FILE 
	INNER JOIN PATIENT AS PAT 
	ON PDTS.PATIENT_IEN = PAT.PatientKey 
	LEFT OUTER JOIN PHARMACY AS PHAR 
	ON PDTSACC.ACCEPTED_PHARMACY_NAME = PHAR.PharmacyDesc
	RIGHT JOIN	DRUG AS	D ON DBO.FORMATTEDNDC(PDTSACC.ACCEPTED_NDC_NUMBER) = D.NDCNumber
WHERE 
	(PDTSACC.ACCEPTED_DATE_FILLED >= @fromDate
	OR PDTSACC.ACCEPTED_DATE_FILLED IS NULL) 
	AND PDTSACC.ACCEPTED_PRESCRIPTION_NUMBER IS NOT NULL

OPEN curPrescription
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch PDTS Prescription',0
FETCH NEXT FROM curPrescription INTO @rx,@pat,@stat,@apre,@src,@phar,@drug

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@rxX = RXNumber
				,@patX = PatientId
				,@statX = PreStatusId
				,@apreX = AcceptedPrescriber
				,@srcX = SourceSystemId
				,@pharX = PharmacyId
				,@drugX = DrugId
		FROM NHJAX_ODS.dbo.PRESCRIPTION
		WHERE RXNumber = @rx
		AND PatientId = @pat
		AND PharmacyId = @phar
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.PRESCRIPTION(
				RXNumber,
				PatientId,
				PreStatusId,
				AcceptedPrescriber,
				SourceSystemId,
				PharmacyId,
				DrugId)
				VALUES(@rx,@pat,@stat,@apre,@src,@phar,@drug);
				SET @irow = @irow + 1
			END
		IF (@drugX <> @drug
			OR @drugX IS NULL)
			BEGIN
				UPDATE NHJAX_ODS.dbo.PRESCRIPTION				
				SET DrugId = @drug
				WHERE RXNumber = @rx
				AND PatientId = @pat
				set @urow = @urow + 1
			END
		
		SET @trow = @trow + 1
		FETCH NEXT FROM curPrescription INTO @rx,@pat,@stat,@apre,@src,@phar,@drug		
	COMMIT	
	END
END

CLOSE curPrescription
DEALLOCATE curPrescription

SET @sirow = 'PDTS Prescription Inserted: ' + CAST(@irow AS varchar(50))
SET @surow = 'PDTS Prescription Updated: ' + CAST(@urow AS varchar(50))
SET @strow = 'PDTS Prescription Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End PDTS Prescription',0,@day;






