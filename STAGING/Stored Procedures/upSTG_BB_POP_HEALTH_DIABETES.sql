CREATE PROCEDURE [dbo].[upSTG_BB_POP_HEALTH_DIABETES]
AS
	
	DECLARE @exists int

	DECLARE @ann nvarchar(255)
	DECLARE @pat nvarchar(255)
	DECLARE @edi nvarchar(255)
	DECLARE @fmp nvarchar(255)
	DECLARE @dob nvarchar(255)
	DECLARE @age nvarchar(255)
	DECLARE @ben nvarchar(255)
	DECLARE @pcm nvarchar(255)
	DECLARE @grp nvarchar(255)
	DECLARE @out nvarchar(255)
	DECLARE @hosp nvarchar(255)
	DECLARE @er nvarchar(255)
	DECLARE @rx nvarchar(255)
	DECLARE @ins nvarchar(255)
	DECLARE @tnm nvarchar(255)
	DECLARE @a1cdt nvarchar(255)
	DECLARE @a1cr nvarchar(255)
	DECLARE @ret nvarchar(255)
	DECLARE @ldldt nvarchar(255)
	DECLARE @ldl nvarchar(255)
	DECLARE @col nvarchar(255)
	DECLARE @choldt nvarchar(255)
	DECLARE @chol nvarchar(255)
	DECLARE @hdldt nvarchar(255)
	DECLARE @hdl nvarchar(255)
	DECLARE @rat nvarchar(255)
	DECLARE @st1 varchar(255)
	DECLARE @st2 varchar(255)
	DECLARE @city varchar(255)
	DECLARE @state varchar(255)
	DECLARE @zip varchar(255)
	DECLARE @ctry varchar(255)
	DECLARE @hm varchar(255)
	DECLARE @wk varchar(255)
	DECLARE @dmis varchar(255)
	

EXEC dbo.upActivityLog 'Begin Bit Bucket PH Diabetes',0;

DECLARE curBBDiab CURSOR FAST_FORWARD FOR
SELECT
	DIAB.PatientName, 
	DIAB.EDIPN, 
	DIAB.FMP, 
	DIAB.DOB, 
	DIAB.Age, 
	DIAB.BenCat, 
	DIAB.PCMName, 
	DIAB.ProviderGroup,
	DIAB.OutpatientVisits,
	DIAB.Hospitalizations,    
	DIAB.ERVisits, 
	DIAB.RxCount, 
	DIAB.Insulin, 
	DIAB.TestName, 
	DIAB.A1CDate, 
	DIAB.A1CResult,
	DIAB.RetinalDate,
	DIAB.LDLCertDate,
	DIAB.LDL,
	DIAB.Col021,
	DIAB.CHOLCertDate,
	DIAB.CHOL,
	DIAB.HDLCertDate,
	DIAB.HDL,
	DIAB.[Chol-HDLRatio],
	DIAB.Street1, 
    DIAB.Street2, 
	DIAB.City, 
	DIAB.State, 
	DIAB.Zip, 
	DIAB.Country, 
	DIAB.HomePhone, 
	DIAB.WorkPhone, 
	DIAB.DMIS
FROM PATIENT AS PAT  
	RIGHT OUTER JOIN POP_HEALTH_DIABETES AS DIAB 
	ON PAT.Patient_Identifier = DIAB.EDIPN
WHERE   (PAT.KEY_PATIENT IS NULL)

OPEN curBBDiab

EXEC dbo.upActivityLog 'Fetch Bit Bucket PH Diabetes',0
FETCH NEXT FROM curBBDiab INTO @pat,@edi,@fmp,@dob,@age,@ben,@pcm,
	@grp,@out,@hosp,@er,@rx,@ins,@tnm,@a1cdt,@a1cr,@ret,@ldldt,@ldl,
	@col,@choldt,@chol,@hdldt,@hdl,@rat,@st1,@st2,@city,@state,@zip,
	@ctry,@hm,@wk,@dmis

if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		BEGIN TRANSACTION

			INSERT INTO BIT_BUCKET_POP_HEALTH_DIABETES
			(
			
			PatientName, 
			EDIPN, 
			FMP, 
			DOB, 
			Age, 
			BenCat, 
			PCMName, 
			ProviderGroup, 
			OutpatientVisits,
			Hospitalizations,    
			ERVisits, 
			RxCount, 
			Insulin, 
			TestName, 
			A1CDate, 
			A1CResult,
			RetinalDate,
			LDLCertDate,
			LDL,
			Col021,
			CHOLCertDate,
			CHOL,
			HDLCertDate,
			HDL,
			[Chol-HDLRatio],
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
			@grp,@out,@hosp,@er,@rx,@ins,@tnm,@a1cdt,@a1cr,@ret,@ldldt,@ldl,
			@col,@choldt,@chol,@hdldt,@hdl,@rat,@st1,@st2,@city,@state,@zip,
			@ctry,@hm,@wk,@dmis);
	
		FETCH NEXT FROM curBBDiab INTO @pat,@edi,@fmp,@dob,@age,@ben,@pcm,
		@grp,@out,@hosp,@er,@rx,@ins,@tnm,@a1cdt,@a1cr,@ret,@ldldt,@ldl,
		@col,@choldt,@chol,@hdldt,@hdl,@rat,@st1,@st2,@city,@state,@zip,
		@ctry,@hm,@wk,@dmis

		COMMIT
	END

END
CLOSE curBBDiab
DEALLOCATE curBBDiab


EXEC dbo.upActivityLog 'End Bit Bucket PH Diabetes',0;
