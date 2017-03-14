CREATE PROCEDURE [dbo].[upSTG_BB_POP_HEALTH_CHF]
AS
	
	DECLARE @exists int

	DECLARE @pat varchar(255)
	DECLARE @edi varchar(255)
	DECLARE @fmp varchar(255)
	DECLARE @dob varchar(255)
	DECLARE @age varchar(255)
	DECLARE @ben varchar(255)
	DECLARE @pcm varchar(255)
	DECLARE @grp varchar(255)
	DECLARE @hosp varchar(255)
	DECLARE @out varchar(255)
	DECLARE @er varchar(255)
	DECLARE @st1 varchar(255)
	DECLARE @st2 varchar(255)
	DECLARE @city varchar(255)
	DECLARE @state varchar(255)
	DECLARE @zip varchar(255)
	DECLARE @ctry varchar(255)
	DECLARE @hm varchar(255)
	DECLARE @wk varchar(255)
	DECLARE @dmis varchar(255)

EXEC dbo.upActivityLog 'Begin Bit Bucket PH CHF',0;

DECLARE curBBCHF CURSOR FAST_FORWARD FOR
SELECT
	CHF.PatientName, 
	CHF.EDIPN, 
	CHF.FMP, 
	CHF.DOB, 
	CHF.Age, 
	CHF.BenCat, 
	CHF.PCMName, 
	CHF.ProviderGroup, 
	CHF.Hospitalization, 
    CHF.Outpatient, 
	CHF.ERVisits, 
	CHF.Street1, 
    CHF.Street2, 
	CHF.City, 
	CHF.State, 
	CHF.Zip, 
	CHF.Country, 
	CHF.HomePhone, 
	CHF.WorkPhone, 
	CHF.DMIS
FROM PATIENT AS PAT  
	RIGHT OUTER JOIN POP_HEALTH_CHF AS CHF
	ON PAT.Patient_Identifier = CHF.EDIPN
WHERE   (PAT.KEY_PATIENT IS NULL)

OPEN curBBCHF

EXEC dbo.upActivityLog 'Fetch Bit Bucket PH CHF',0
FETCH NEXT FROM curBBCHF INTO @pat,@edi,@fmp,@dob,@age,@ben,@pcm,@grp,@hosp,@out,@er,@st1,@st2,@city,@state,@zip,@ctry,@hm,@wk,@dmis

if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		BEGIN TRANSACTION

			INSERT INTO BIT_BUCKET_POP_HEALTH_CHF
			(
			PatientName, 
			EDIPN, 
			FMP, 
			DOB, 
			Age, 
			BenCat, 
			PCMName, 
			ProviderGroup, 
			Hospitalization, 
			Outpatient,
			ERVisits,
			Street1, 
			Street2, 
			City, 
			State, 
			Zip, 
			Country, 
			HomePhone, 
			WorkPhone, 
			DMIS
			)
			VALUES
			(@pat,@edi,@fmp,@dob,@age,@ben,@pcm,@grp,@hosp,@out,@er,@st1,@st2,@city,@state,@zip,@ctry,@hm,@wk,@dmis);
	
		FETCH NEXT FROM curBBCHF INTO @pat,@edi,@fmp,@dob,@age,@ben,@pcm,@grp,@hosp,@out,@er,@st1,@st2,@city,@state,@zip,@ctry,@hm,@wk,@dmis

		COMMIT
	END

END
CLOSE curBBCHF
DEALLOCATE curBBCHF


EXEC dbo.upActivityLog 'End Bit Bucket PH CHF',0;
