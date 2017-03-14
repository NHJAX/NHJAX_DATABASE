CREATE PROCEDURE [dbo].[upSTG_BB_POP_HEALTH_ASTHMA]
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
	DECLARE @disp varchar(255)
	DECLARE @ctrl varchar(255)
	DECLARE @drug varchar(255)
	DECLARE @ster varchar(255)
	DECLARE @rxdt varchar(255)
	DECLARE @st1 varchar(255)
	DECLARE @st2 varchar(255)
	DECLARE @city varchar(255)
	DECLARE @state varchar(255)
	DECLARE @zip varchar(255)
	DECLARE @ctry varchar(255)
	DECLARE @hm varchar(255)
	DECLARE @wk varchar(255)
	DECLARE @dmis varchar(255)

EXEC dbo.upActivityLog 'Begin Bit Bucket PH Asthma',0;

DECLARE curBBAsthma CURSOR FAST_FORWARD FOR
SELECT
	ASTH.PatientName, 
	ASTH.EDIPN, 
	ASTH.FMP, 
	ASTH.DOB, 
	ASTH.Age, 
	ASTH.BenCat, 
	ASTH.PCMName, 
	ASTH.ProviderGroup, 
	ASTH.Hospitalization, 
    ASTH.Outpatient, 
	ASTH.ERVisits, 
	ASTH.Dispensing, 
	ASTH.CtrlRxDate, 
	ASTH.CtrlDrugName, 
	ASTH.Steroid, 
	ASTH.SteroidRxDate, 
	ASTH.Street1, 
    ASTH.Street2, 
	ASTH.City, 
	ASTH.State, 
	ASTH.Zip, 
	ASTH.Country, 
	ASTH.HomePhone, 
	ASTH.WorkPhone, 
	ASTH.DMIS
FROM
	PATIENT AS PAT 
	RIGHT OUTER JOIN POP_HEALTH_ASTHMA AS ASTH 
	ON PAT.Patient_Identifier = ASTH.EDIPN
WHERE   (PAT.KEY_PATIENT IS NULL)

OPEN curBBAsthma

EXEC dbo.upActivityLog 'Fetch Bit Bucket PH Asthma',0
FETCH NEXT FROM curBBAsthma INTO @pat,@edi,@fmp,@dob,@age,@ben,@pcm,
	@grp,@hosp,@out,@er,@disp,@ctrl,@drug,@ster,@rxdt,@st1,@st2,
	@city,@state,@zip,@ctry,@hm,@wk,@dmis

if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		BEGIN TRANSACTION

			INSERT INTO BIT_BUCKET_POP_HEALTH_ASTHMA
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
			Dispensing, 
			CtrlRxDate, 
			CtrlDrugName, 
			Steroid, 
			SteroidRxDate, 
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
				@grp,@hosp,@out,@er,@disp,@ctrl,@drug,@ster,
				@rxdt,@st1,@st2,
				@city,@state,@zip,@ctry,@hm,@wk,@dmis);
	
		FETCH NEXT FROM curBBAsthma INTO @pat,@edi,@fmp,@dob,@age,
		@ben,@pcm,
		@grp,@hosp,@out,@er,@disp,@ctrl,@drug,@ster,@rxdt,@st1,@st2,
		@city,@state,@zip,@ctry,@hm,@wk,@dmis

		COMMIT
	END

END
CLOSE curBBAsthma
DEALLOCATE curBBAsthma


EXEC dbo.upActivityLog 'End Bit Bucket PH Asthma',0;
