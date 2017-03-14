
CREATE procedure [dbo].[procODS_DM_DIABETES_LAB_RESULTS] 
AS 
BEGIN

DECLARE @pat bigint
DECLARE @desc int
DECLARE @date datetime
DECLARE @rslt nvarchar (10)
DECLARE @a1c as nvarchar(4)
DECLARE @a1cdate as nvarchar(20)
DECLARE @ldldate as nvarchar(20)
DECLARE @ldl as nvarchar(4)
DECLARE @src as int

Declare @irow int
Declare @sirow varchar(50)

Declare @start datetime

SET @start = dbo.StartOfDay(DATEADD(m, - 24, GETDATE()))

EXEC dbo.upActivityLog 'Begin Diabetes Lab Results', 0

TRUNCATE TABLE DM_DIABETES_LAB_RESULTS

DECLARE curDBLabs CURSOR FAST_FORWARD FOR
SELECT DISTINCT LAB.PatientId
				,3 as LabTestDesc
				,dbo.formatdatewithouttime(LAB.TakenDate, 2) as DateTaken
				,LAB.Result
FROM        LAB_TEST AS TST INNER JOIN
            LAB_RESULT AS LAB
			ON TST.LabTestid = LAB.LabTestId
						
WHERE     (LAB.TakenDate >= @start) 
AND			LAB.Patientid in (select patientid from PATIENT_FLAG WHERE FLAGID = 2 AND TRACKED = 1)
AND (TST.LabTestDesc NOT LIKE 'XX%')
and Tst.labtestdesc like '%ldl%'
and Tst.labtestdesc not like '%vldl%'

UNION

SELECT distinct LAB.PatientId
				,4 as LabTestDesc
				,dbo.formatdatewithouttime(LAB.TakenDate, 2) as DateTaken
				,LAB.Result
FROM        LAB_TEST AS TST INNER JOIN
            LAB_RESULT AS LAB
			ON TST.LabTestid = LAB.LabTestId
						
WHERE		(LAB.TakenDate >= @start) 
AND			LAB.Patientid in (select patientid from PATIENT_FLAG WHERE FLAGID = 2 AND TRACKED = 1)
AND			(TST.LabTestDesc NOT LIKE 'XX%')
and			(Tst.labtestdesc like '%MICROALB%')
--and isnumeric(lab.result) <> 0

UNION

SELECT distinct LAB.PatientId
				,2 as LabTestDesc
				,dbo.formatdatewithouttime(LAB.TakenDate, 2) as DateTaken
				,LAB.Result
FROM        LAB_TEST AS TST INNER JOIN
            LAB_RESULT AS LAB
			ON TST.LabTestid = LAB.LabTestId
						
WHERE     (LAB.TakenDate >= @start) 
AND			LAB.Patientid in (select patientid from PATIENT_FLAG WHERE FLAGID = 2 AND TRACKED = 1)
AND (TST.LabTestDesc NOT LIKE 'XX%')
and Tst.labtestdesc like '%filtr%'
--and isnumeric(lab.result) <> 0

UNION

SELECT distinct LAB.PatientId
				,1 as LabTestDesc
				,dbo.formatdatewithouttime(LAB.TakenDate, 2) as DateTaken
				,LAB.Result
FROM        LAB_TEST AS TST INNER JOIN
            LAB_RESULT AS LAB
			ON TST.LabTestid = LAB.LabTestId
						
WHERE     (LAB.TakenDate >= @start) 
AND			LAB.Patientid in (select patientid from PATIENT_FLAG WHERE FLAGID = 2  AND TRACKED = 1)
AND (TST.LabTestDesc NOT LIKE 'XX%')
and Tst.labtestdesc like '%a1c%'
--and isnumeric(lab.result) <> 0


open curDBLabs

SET @irow = 0

EXEC dbo.UpActivityLog 'Fetch Diabetes Lab Results1',0

FETCH NEXT FROM curDBLabs INTO @pat,@desc,@date,@rslt

IF @@FETCH_STATUS = 0
BEGIN
	WHILE @@FETCH_STATUS = 0
		BEGIN
			BEGIN TRANSACTION
			INSERT INTO DM_DIABETES_LAB_RESULTS
				(
					 PatientId
					,LabResultTypeId
					,DateTaken
					,Result
					,SourceSystemId
				)
				Values
				(
					@pat
					,@desc
					,@date
					,@rslt
					,2
				 );
				SET @irow = @irow + 1
		
			FETCH NEXT FROM curDBLabs INTO @pat,@desc,@date,@rslt	
		COMMIT
	END
END
CLOSE      curDBLabs
DEALLOCATE curDBLabs

set @sirow = 'Diabetes Lab Results1 Inserted: ' + cast(@irow as nvarchar(50))

EXEC dbo.upActivityLog @sirow,0
EXEC dbo.upActivityLog 'End Diabetes Lab Results1', 0

DECLARE curPHDiabLabs CURSOR FAST_FORWARD FOR


-- GETS ph a1c RESULTS
SELECT     
	PAT.PatientId
	,1 AS LabTestDesc
	,dia.A1CDate as DateTaken
	,dia.A1CResult as Result
	,6 AS SourceSystemId

FROM 	PATIENT AS PAT 
	INNER JOIN vwSTG_POP_HEALTH_DIABETES AS DIA 
	ON PAT.PatientIdentifier = DIA.EDIPN

where dia.a1cresult is not null

UNION

-- GETS ph LDL RESULTS

SELECT     
	PAT.PatientId
	,3 as LabTestDesc
	,dia.ldlCertDate as DateTaken
	,dia.ldl as Result
	,6 AS SourceSystemId
		
FROM
	PATIENT AS PAT 
	INNER JOIN vwSTG_POP_HEALTH_DIABETES AS DIA 
	ON PAT.PatientIdentifier = DIA.EDIPN

where dia.ldl is not null

OPEN curPHDiabLabs

SET @irow = 0

EXEC dbo.UpActivityLog 'Fetch Diabetes Lab Results2',0

FETCH NEXT FROM curPHDiabLabs INTO @pat,@desc,@date,@rslt,@src

IF @@FETCH_STATUS = 0
BEGIN
	WHILE @@FETCH_STATUS = 0
		BEGIN
			BEGIN TRANSACTION
				INSERT INTO DM_DIABETES_LAB_RESULTS
				(
					PatientId
					,LabResultTypeId
					,DateTaken
					,Result
					,SourceSystemId
				)
				
				Values
				(
					@pat
					,@desc
					,@date
					,left(@rslt,5)
					,@src
				 );
				SET @irow = @irow + 1
		
			FETCH NEXT FROM curPHDiabLabs INTO @pat,@desc,@date,@rslt,@src
		COMMIT
	END
END
CLOSE      curPHDiabLabs
DEALLOCATE curPHDiabLabs



set @sirow = 'Diabetes Lab Results2 Inserted: ' + cast(@irow as nvarchar(50))

EXEC dbo.upActivityLog @sirow,0
EXEC dbo.upActivityLog 'End Diabetes Lab Results2', 0

END