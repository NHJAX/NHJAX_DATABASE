
CREATE PROCEDURE [dbo].[upODS_PatientFlags]
AS
	DECLARE @dateCutoff	datetime;

	DECLARE @today datetime
	DECLARE @tempDate datetime
	DECLARE @fromDate datetime
	DECLARE @PapDate datetime
	DECLARE @PapFromDate Datetime
	DECLARE @loop int
	DECLARE @exists int

	DECLARE @pat bigint
	DECLARE @flag int
	DECLARE @src int
	DECLARE @patX bigint
	DECLARE @flagX varchar(30)
	Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0
	
SET @tempDate = DATEADD(m,-24,getdate());
SET @fromDate = dbo.StartOfDay(@tempDate);
SET @PapDate = DATEADD(m,-36,getdate());
SET @PapfromDate = dbo.StartOfDay(@papDate);

--PRINT @fromDate

EXEC dbo.upActivityLog 'Begin Patient Flags',0,@day;

BEGIN TRANSACTION
BEGIN
TRUNCATE TABLE PATIENT_FLAG;
--*********GETS ASTHMATIC PATIENTS***********************************************

EXEC dbo.upActivityLog 'Begin Asthma Flags',0,@day
EXEC procCP_PATIENT_FLAG_ASTHMATIC;

EXEC dbo.upActivityLog 'End Asthma Flags',0,@day

--*********************BEGIN DIABETIC PATIENT FLAGS--------------------
EXEC dbo.upActivityLog 'Begin Diabetic Flags',0,@day

EXEC procCP_PATIENT_FLAG_DIABETIC;

EXEC dbo.upActivityLog 'End Diabetic Flags',0,@day

-- BEGIN BREAST CANCER SCREENING FLAGS ACF---------
EXEC dbo.upActivityLog 'Begin Mammography Flags',0,@day

EXEC procCP_PATIENT_FLAG_BREAST_CANCER_SCREENING;

EXEC dbo.upActivityLog 'End Mammography Flags',0,@day

--GET AT RISK CERVICAL CANCER PATIENTS STARTS HERE-----
EXEC dbo.upActivityLog 'Begin Cervical Cancer Screening Flags',0,@day

EXEC procCP_PATIENT_FLAG_CERVICAL_CANCER_SCREENING;
			
EXEC dbo.upActivityLog 'End Cervical Cancer Screening Flags',0,@day

--GET AT RISK COLON CANCER PATIENTS STARTS HERE-----
EXEC dbo.upActivityLog 'Begin COLON Cancer Screening Flags',0,@day

EXEC procCP_PATIENT_FLAG_COLON_CANCER_SCREENING;

EXEC dbo.upActivityLog 'End Colon Cancer Screening Flags',0,@day;

--TOBACCO CESSATION

EXEC dbo.upActivityLog 'Begin Tobacco Cessation Flag',0,@day;

EXEC DBO.procCP_PATIENT_FLAG_TOBACCO_CESSATION;

EXEC dbo.upActivityLog 'End Tobacco Cessation Flag',0,@day;

----MATERNITY 
EXEC dbo.upActivityLog 'Begin Maternity Flag',0,@day;

EXEC procCP_PATIENT_FLAG_MATERNITY;

EXEC dbo.upActivityLog 'End Maternity Flag',0,@day;

--BMI Flag

EXEC dbo.upActivityLog 'Begin BMI Flag',0,@day;

EXEC procCP_PATIENT_FLAG_BODY_MASS_INDEX;

EXEC dbo.upActivityLog 'End BMI Flag',0,@day;

--CONGESTIVE HEART FAILURE Flag

EXEC dbo.upActivityLog 'Begin CHF Flag',0,@day;

EXEC procCP_PATIENT_FLAG_CONGESTIVE_HEART_FAILURE;

EXEC dbo.upActivityLog 'End CHF Flag',0,@day;

--ANTIDEPRESSANT Flag 2015-09-16 SK
EXEC dbo.upActivityLog 'Begin Antidepressant Flag',0,@day;
EXEC procCP_PATIENT_FLAG_ANTIDEPRESSANT;
EXEC dbo.upActivityLog 'End Antidepressant Flag',0,@day;

EXEC dbo.upActivityLog 'End Patient Flags',0,@day;
END
COMMIT






