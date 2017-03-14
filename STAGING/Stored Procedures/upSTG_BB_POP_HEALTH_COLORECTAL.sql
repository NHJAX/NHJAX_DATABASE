CREATE Procedure [dbo].[upSTG_BB_POP_HEALTH_COLORECTAL]
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
	DECLARE @col varchar(255)
	DECLARE @sig varchar(255)
	DECLARE @fobt varchar(255)
	DECLARE @dcbe varchar(255)
	DECLARE @st1 varchar(255)
	DECLARE @st2 varchar(255)
	DECLARE @city varchar(255)
	DECLARE @state varchar(255)
	DECLARE @zip varchar(255)
	DECLARE @ctry varchar(255)
	DECLARE @hm varchar(255)
	DECLARE @wk varchar(255)
	DECLARE @dmis varchar(255)

EXEC dbo.upActivityLog 'Begin Bit Bucket PH Colorectal',0;

DECLARE curBB CURSOR FAST_FORWARD FOR
SELECT	
	COLON.PatientName, 
	COLON.EDIPN, 
	COLON.FMP, 
	COLON.DOB, 
	COLON.Age, 
	COLON.BenCat, 
	COLON.PCMName, 
	COLON.ProviderGroup, 
	COLON.ColonoscopyDate,
	COLON.FlexSigmoidDate,
	COLON.FOBTDate,
	COLON.DCBEDate,
	COLON.Street1,
	COLON.Street2, 
	COLON.City, 
	COLON.State, 
	COLON.Zip, 
	COLON.Country, 
	COLON.HomePhone, 
	COLON.WorkPhone, 
	COLON.DMIS
FROM PATIENT AS PAT  
	RIGHT OUTER JOIN POP_HEALTH_COLON AS COLON
	ON PAT.Patient_Identifier = COLON.EDIPN
WHERE  (PAT.KEY_PATIENT IS NULL)

OPEN curBB

EXEC dbo.upActivityLog 'Fetch Bit Bucket PH Colorectal',0
FETCH NEXT FROM curBB INTO @pat,@edi,@fmp,@dob,@age,@ben,@pcm,
	@grp,@col,@sig,@fobt,@dcbe,@st1,@st2,@city,@state,@zip,@ctry,
	@hm,@wk,@dmis

if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		BEGIN TRANSACTION

			INSERT INTO BIT_BUCKET_POP_HEALTH_COLON
			(			
			PatientName, 
			EDIPN, 
			FMP, 
			DOB, 
			Age, 
			BenCat, 
			PCMName, 
			ProviderGroup, 
			ColonoscopyDate,
			FlexSigmoidDate,
			FOBTDate,
			DCBEDate,
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
				@grp,@col,@sig,@fobt,@dcbe,@st1,@st2,
				@city,@state,@zip,@ctry,@hm,@wk,@dmis);
	
		FETCH NEXT FROM curBB INTO @pat,@edi,@fmp,@dob,@age,
					@ben,@pcm,@grp,@col,@sig,@fobt,@dcbe,@st1,@st2,
					@city,@state,@zip,@ctry,@hm,@wk,@dmis

		COMMIT
	END

END
CLOSE curBB
DEALLOCATE curBB


EXEC dbo.upActivityLog 'End Bit Bucket PH Colorectal',0;
