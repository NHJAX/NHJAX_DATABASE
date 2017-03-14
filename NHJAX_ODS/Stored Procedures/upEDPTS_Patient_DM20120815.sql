

create PROCEDURE [dbo].[upEDPTS_Patient_DM20120815]
AS
Declare @trow int
Declare @urow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @today datetime
Declare @loop int
Declare @exists int

Declare @key_pat decimal
Declare @name varchar(32)
Declare @age varchar(15)
Declare @ssn varchar(30)
Declare @spssn varchar(15)

Declare @key_patX decimal
Declare @nameX varchar(32)
Declare @ageX varchar(15)
Declare @ssnX varchar(30)
Declare @spssnX varchar(15)

EXEC dbo.upActivityLog 'Begin EDPTS Patient',0;
DECLARE curPatient CURSOR FAST_FORWARD FOR
SELECT DISTINCT
	PAT.KEY_PATIENT, 
	PAT.NAME, 
	PAT.DISPLAY_AGE, 
	PAT.SSN, 
	PAT.SPONSOR_SSN
FROM   vwEDPTS_PATIENT PAT 
	INNER JOIN vwEDPTS_PATIENT_APPOINTMENT_ACTIVE APT 
	ON PAT.KEY_PATIENT = APT.NAME_IEN 
	
	
OPEN curPatient
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Patient',0
FETCH NEXT FROM curPatient INTO @key_pat,@name,@age,@ssn,@spssn

if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
	Select @key_patX = PatientKey,
	@nameX = FullName, 
	@ageX = DisplayAge,
	@ssnX = SSN, 
	@spssnX = SponsorSSN
	from NHJAX_ODS.dbo.PATIENT 
	Where PatientKey = @key_pat
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.PATIENT(
			PatientKey,
			FullName, 
			DisplayAge,
			SSN, 
			SponsorSSN
			) 
		VALUES(@key_pat,
			@name, 
			@age,
			@ssn,
			@spssn
			);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @name <> @nameX
		OR @age <> @ageX
		OR @ssn <> @ssnX
		OR @spssn <> @spssnX
		OR (@namex Is Not Null AND @name Is Null)
		OR (@agex Is Not Null AND @age Is Null)
		OR (@ssnx Is Not Null AND @ssn Is Null)
		OR (@spssnx Is Not Null AND @spssn Is Null)
		
			BEGIN
			SET @today = getdate()
			UPDATE [nhjax-sql2].EDPTS.dbo.PATIENT
			SET NAME = @namex,
			Display_Age = @agex,
			SSN = @ssnx,
			Sponsor_SSN = @spssnx,
			UpdatedDate = @today
			WHERE Key_patient = @key_pat;
			SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curPatient INTO @key_pat,@name,@age,@ssn,@spssn
	COMMIT
	END

END
CLOSE curPatient
DEALLOCATE curPatient
SET @trow = @trow - 1
SET @surow = 'EDPTS Patient Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'EDPTS Patient Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'EDPTS Patient Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End EDPTS Patient',0;

