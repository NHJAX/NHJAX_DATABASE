

CREATE PROCEDURE [dbo].[upEDPTS_Patient] AS

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @today datetime
Declare @loop int
Declare @exists int

Declare @pat bigint
Declare @key_pat decimal
Declare @name varchar(32)
Declare @age varchar(15)
Declare @spssn varchar(15)

Declare @patX bigint
Declare @key_patX decimal
Declare @nameX varchar(32)
Declare @ageX varchar(15)
Declare @spssnX varchar(15)

EXEC dbo.upActivityLog 'Begin EDPTS Patient',5;
DECLARE curPatient CURSOR FAST_FORWARD FOR
SELECT	P.KEY_PATIENT, 
	P.NAME, 
	P.DISPLAY_AGE, 
	P.SPONSOR_SSN
FROM   vwEDPTS_PATIENT P
WHERE DATEDIFF(d,P.CreatedDate,getdate()) < 3
	
OPEN curPatient
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch EDPTS Patient',5
FETCH NEXT FROM curPatient INTO @key_pat,@name,@age,@spssn
if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
	Select @key_patX = PatientKey,
	@nameX = FullName, 
	@ageX = DisplayAge,
	@spssnX = SponsorSSN
	from NHJAX_ODS.dbo.PATIENT 
	Where PatientKey = @key_pat
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.PATIENT(PatientKey,
			FullName, 
			DisplayAge,
			SponsorSSN,
			SourceSystemKey) 
		VALUES(@key_pat,
			@name, 
			@age,
			@spssn,
			@key_pat);
			SET @irow = @irow + 1
		END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM curPatient INTO @key_pat,@name,@age,@spssn
	COMMIT
	END

END
CLOSE curPatient
DEALLOCATE curPatient
SET @trow = @trow - 1
SET @sirow = 'Patient EDPTS Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Patient EDPTS Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,5;
EXEC dbo.upActivityLog @strow,5;
EXEC dbo.upActivityLog 'End EDPTS Patient',5;

