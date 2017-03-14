
CREATE PROCEDURE procODS_UPDATE_PATIENT_CONTACTINFO_FROM_PHN

AS

DECLARE @pat varchar(32)
DECLARE @dob DATETIME
DECLARE @ssn VARCHAR(15)
DECLARE @str1 VARCHAR(38)
DECLARE @str2 VARCHAR(38)
DECLARE @city VARCHAR(20)
DECLARE @state VARCHAR(25)
DECLARE @zip VARCHAR(10)
DECLARE @phn VARCHAR(15)
DECLARE @stateid bigint

DECLARE @patX varchar(32)
DECLARE @dobX DATETIME
DECLARE @ssnX VARCHAR(15)
DECLARE @str1X VARCHAR(38)
DECLARE @str2X VARCHAR(38)
DECLARE @cityX VARCHAR(20)
DECLARE @stateX VARCHAR(25)
DECLARE @zipX VARCHAR(10)
DECLARE @phnX VARCHAR(15)
DECLARE @stateidX bigint

DECLARE @exists int
DECLARE @urow bigint
DECLARE @strurow VARCHAR(100)
set @urow = 0
exec dbo.upActivityLog 'BEGIN PHN PATIENT CONTACT INFO',0;
BEGIN
DECLARE curPHNINFO CURSOR FAST_FORWARD FOR
SELECT LTRIM(RTRIM(REPLACE(A.PatientName, ' ', ', '))) AS PATIENTNAME
		,A.DOB
		,A.SponsorSSN
		,A.Street1
		,A.Street2
		,A.City
		,A.State
		,A.Zip
		,A.Homephone
FROM	[NHJAX-CACHE].STAGING.DBO.POP_HEALTH_ASTHMA A
WHERE City IS NOT null

UNION

SELECT LTRIM(RTRIM(REPLACE(CER.PatientName, ' ', ', '))) AS PATIENTNAME
		,CER.DOB
		,CER.SponsorSSN
		,CER.Street1
		,CER.Street2		
		,CER.City
		,CER.State
		,CER.Zip
		,CER.Homephone
FROM [NHJAX-CACHE].STAGING.DBO.POP_HEALTH_CERVICAL CER
WHERE City IS NOT null
AND		Zip IS NOT NULL

UNION

SELECT LTRIM(RTRIM(REPLACE(COL.PatientName, ' ', ', '))) AS PATIENTNAME
		,COL.DOB
		,COL.SponsorSSN
		,COL.Street1
		,COL.Street2		
		,COL.City
		,COL.State
		,COL.Zip
		,COL.Homephone
FROM	[NHJAX-CACHE].STAGING.DBO.POP_HEALTH_COLON COL
WHERE City IS NOT null
AND		Zip IS NOT NULL

UNION

SELECT LTRIM(RTRIM(REPLACE(D.PatientName, ' ', ', '))) AS PATIENTNAME
		,D.DOB
		,D.SponsorSSN
		,D.Street1
		,D.Street2
		,D.City
		,D.State
		,D.Zip
		,D.Homephone
FROM	[NHJAX-CACHE].STAGING.DBO.POP_HEALTH_DIABETES D
WHERE	City IS NOT null
AND		Zip IS NOT NULL

UNION

SELECT LTRIM(RTRIM(REPLACE(M.PatientName, ' ', ', '))) AS PATIENTNAME
		,M.DOB
		,M.SponsorSSN
		,M.Street1
		,M.Street2
		,M.City
		,M.State
		,M.Zip
		,M.Homephone
FROM	[NHJAX-CACHE].STAGING.DBO.POP_HEALTH_MAMMOGRAPHY M
WHERE	City IS NOT NULL
AND		Zip IS NOT NULL

OPEN curPHNINFO
PRINT 'CURSOR WORKING'
FETCH NEXT from curPHNINFO INTO @pat,@dob,@ssn,@str1,@str2,@city,@state,@zip,@phn
PRINT 'FETCH WORKING'
		SELECT		@stateid = GL.GeographicLocationId
		FROM		GEOGRAPHIC_LOCATION GL
		WHERE		GL.GeographicLocationAbbrev = @state;

		SELECT		@patX = P.FullName
					,@dobX = P.DOB
					,@ssnX = P.SponsorSSN
					,@str1X = P.StreetAddress1
					,@str2X = P.StreetAddress2
					,@cityX = P.City					
					,@stateidX = P.StateId
					,@zipX = P.ZipCode
					,@phnX = P.Phone	
		FROM		PATIENT P 
		WHERE		p.FullName = @pat
		AND			p.DOB = @dob			
SET @exists = @@ROWCOUNT
PRINT 'EXISTS WORKING' + CAST(@EXISTS AS VARCHAR(4))
		IF @exists > 0		
		PRINT 'EXISTS GREATER THAN 0'
		BEGIN
			IF @@FETCH_STATUS = 0
			BEGIN
				WHILE @@FETCH_STATUS = 0
				BEGIN
				BEGIN TRANSACTION
				IF (@str1 <> @str1X
					OR @str2 <> @str2X					
					OR @city <> @cityX
					OR @stateid <> @stateidX
					OR @zip <> @zipX
					OR @phn <> @phnX
					OR @str1X IS NULL
					OR @str2X IS NULL
					OR @cityX IS NULL
					OR @stateidX IS NULL
					OR @zipX IS NULL
					OR @phnX IS NULL)
					BEGIN
					IF (@ssn IS NOT NULL)
						BEGIN						
						UPDATE	PATIENT 
						SET		StreetAddress1 = @str1
								,StreetAddress2 = @str2
								,City = @city
								,StateId = @stateid
								,ZipCode = @zip
								,Phone = @phn							
								,SourceSystemId = 6
								,UpdatedDate = GETDATE()
						WHERE	FullName = @pat
						AND		DOB = @dob
						SET @urow = @urow + 1;
						END
					ELSE
						BEGIN
						UPDATE	PATIENT						
						SET		SponsorSSN = @ssn
								,StreetAddress1 = @str1
								,StreetAddress2 = @str2
								,City = @city
								,StateId = @stateid
								,ZipCode = @zip
								,Phone = @phn		
								,SourceSystemId = 6
								,UpdatedDate = GETDATE()
						WHERE	FullName = @pat
						AND		DOB = @dob
						SET @urow = @urow + 1 
						END
					COMMIT TRANSACTION
					END
						FETCH NEXT from curPHNINFO INTO @pat,@dob,@ssn,@str1,@str2,@city,@state,@zip,@phn
				END
			END
		END
SET @strurow = 'UPDATED ROWS: ' + CAST(@urow as varchar(10))
EXEC dbo.upActivityLog @strurow,0;
EXEC dbo.upActivityLog 'END PHN PATIENT CONTACT INFO',0;	
CLOSE curPHNINFO
DEALLOCATE curPHNINFO
END
