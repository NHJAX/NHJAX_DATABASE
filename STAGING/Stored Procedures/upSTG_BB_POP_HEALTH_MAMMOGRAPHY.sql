CREATE Procedure [dbo].[upSTG_BB_POP_HEALTH_MAMMOGRAPHY]
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
	DECLARE @exam varchar(255)
	DECLARE @sys varchar(255)
	DECLARE @src varchar(255)
	DECLARE @st1 varchar(255)
	DECLARE @st2 varchar(255)
	DECLARE @city varchar(255)
	DECLARE @state varchar(255)
	DECLARE @zip varchar(255)
	DECLARE @ctry varchar(255)
	DECLARE @hm varchar(255)
	DECLARE @wk varchar(255)
	DECLARE @dmis varchar(255)

EXEC dbo.upActivityLog 'Begin Bit Bucket PH Mammpgraphy',0;

DECLARE curBBMammo CURSOR FAST_FORWARD FOR
SELECT
	MAM.PatientName, 
	MAM.EDIPN, 
	MAM.FMP, 
	MAM.DOB, 
	MAM.Age, 
	MAM.BenCat, 
	MAM.PCMName, 
	MAM.ProviderGroup, 
	MAM.LastExamDate,
	MAM.System,
	MAM.Source,
	MAM.Street1,
	MAM.Street2, 
	MAM.City, 
	MAM.State, 
	MAM.Zip, 
	MAM.Country, 
	MAM.HomePhone, 
	MAM.WorkPhone, 
	MAM.DMIS
FROM PATIENT AS PAT  
	RIGHT OUTER JOIN POP_HEALTH_MAMMOGRAPHY AS MAM 
	ON PAT.Patient_Identifier = MAM.EDIPN
WHERE  (PAT.KEY_PATIENT IS NULL)

OPEN curBBMammo

EXEC dbo.upActivityLog 'Fetch Bit Bucket PH Mammography',0
FETCH NEXT FROM curBBMammo INTO @pat,@edi,@fmp,@dob,@age,@ben,@pcm,
	@grp,@exam,@sys,@src,@st1,@st2,@city,@state,@zip,@ctry,@hm,@wk,@dmis

if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		BEGIN TRANSACTION

			INSERT INTO BIT_BUCKET_POP_HEALTH_MAMMOGRAPHY
			(
			
			PatientName, 
			SponsorSSN, 
			FMP, 
			DOB, 
			Age, 
			BenCat, 
			PCMName, 
			ProviderGroup, 
			LastExamDate,
			System,
			Source,
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
			(@pat,@edi,@fmp,@dob,@age,@ben,@pcm,
				@grp,@exam,@sys,@src,@st1,@st2,
				@city,@state,@zip,@ctry,@hm,@wk,@dmis);
	
		FETCH NEXT FROM curBBMammo INTO @pat,@edi,@fmp,@dob,@age,
					@ben,@pcm,@grp,@exam,@sys,@src,@st1,@st2,
					@city,@state,@zip,@ctry,@hm,@wk,@dmis

		COMMIT
	END

END
CLOSE curBBMammo
DEALLOCATE curBBMammo


EXEC dbo.upActivityLog 'End Bit Bucket PH Mammography',0;
