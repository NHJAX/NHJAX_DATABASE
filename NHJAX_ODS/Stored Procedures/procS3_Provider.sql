

CREATE PROCEDURE [dbo].[procS3_Provider] AS

Declare @err varchar(4000)

Declare @id int
Declare @name varchar(75)
Declare @email varchar(70)
Declare @usr varchar(50)

Declare @nameX varchar(75)
Declare @emailX varchar(70)
Declare @usrX varchar(50)

Declare @enet int
Declare @pro bigint
Declare @ssn varchar(30)
Declare @dod varchar(50)
Declare @aud bigint

Declare @urow int
Declare @trow int
Declare @irow int
Declare @drow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @sdrow varchar(50)
Declare @fromDate datetime
Declare @tempDate datetime
Declare @toDate datetime

Declare @exists int
Declare @day int

EXEC dbo.upActivityLog 'Begin S3 Providers',0,@day;

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

DECLARE curS3 CURSOR FAST_FORWARD FOR
SELECT 
	staffID,
	ISNULL(staffLastName,'') + ', ' + ISNULL(staffFirstName,'') + ' ' + ISNULL(staffMiddleName,''),
	--CASE staffType
	--	WHEN 'N' THEN 5
	--	WHEN 'S' THEN 10
	--	WHEN 'A' THEN 11
	--	ELSE 0
	--END AS StaffRole,
	ISNULL(staffUserName,''),
	ISNULL(staffEMail,'')
FROM [NHJAX-DB-S3].AORS.dbo.LUHospitalStaff AS STAFF 


OPEN curS3
SET @trow = 0
SET @irow = 0
SET @urow = 0
SET @drow = 0
EXEC dbo.upActivityLog 'Fetch S3 Providers',0
FETCH NEXT FROM curS3 INTO @id,@name,@usr,@email

if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		--BEGIN TRY
		
		Select 	@nameX = ProviderName
		FROM PROVIDER
		WHERE SourceSystemKey = @id
		AND SourceSystemId IN (10)
		
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				
				SET @enet = -1
				SET @pro = -1		
				--Lookup ENET ProviderId @enet,@pro
				IF LEN(@usr) > 0
				BEGIN
				SELECT @enet = TECH.UserId,
					@pro = ISNULL(EXT.ProviderId,-1),
					@ssn = TECH.SSN,
					@dod = TECH.DoDEDI,
					@aud = TECH.AudienceId
				FROM [NHJAX-SQL-1A].ENET.dbo.[TECHNICIAN] AS TECH
				LEFT OUTER JOIN [NHJAX-SQL-1A].ENET.dbo.[TECHNICIAN_EXTENDED] AS EXT
				ON TECH.UserId = EXT.UserId
				WHERE LoginId = @usr
				END
				
				IF LEN(@enet) < 0 AND LEN(@email) > 0
				BEGIN
					SELECT @enet = TECH.UserId,
					@pro = ISNULL(EXT.ProviderId,-1),
					@ssn = TECH.SSN,
					@dod = TECH.DoDEDI,
					@aud = TECH.AudienceId
					FROM [NHJAX-SQL-1A].ENET.dbo.[TECHNICIAN] AS TECH
					LEFT OUTER JOIN [NHJAX-SQL-1A].ENET.dbo.[TECHNICIAN_EXTENDED] AS EXT
					ON TECH.UserId = EXT.UserId
					WHERE EMailAddress = @email
				END

				INSERT INTO PROVIDER(
				ProviderName,
				LocationId,
				ENetId,
				AltProviderId,
				SourceSystemKey,
				ProviderSSN,
				DoDEDI,
				SourceSystemId,
				DepartmentId,
				ENetLocationId)
				VALUES(@name,185,@enet,@pro,@id,@ssn,
				@dod,10,86,@aud);
				--SELECT @idX = SCOPE_IDENTITY();
				SET @irow = @irow + 1	

			END
		ELSE
			BEGIN

			IF	@name <> @nameX
			OR	(@name Is Not Null AND @nameX Is Null)
			BEGIN
				UPDATE PROVIDER
				SET ProviderName = @name,
					UpdatedDate = GETDATE()
				WHERE SourceSystemKey = @id
				AND SourceSystemId IN (10);
			END
						
		END
		SET @trow = @trow + 1
		SET @usr = ''
		SET @email = ''
		SET @ssn = NULL
		SET @dod = NULL
		SET @aud = NULL

		FETCH NEXT FROM curS3 INTO @id,@name,@usr,@email
			
	COMMIT
	END

END
CLOSE curS3
DEALLOCATE curS3

SET @surow = 'S3 Providers Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'S3 Providers Inserted: ' + CAST(@irow AS varchar(50))
SET @sdrow = 'S3 Providers: ' + CAST(@drow AS varchar(50))
SET @strow = 'S3 Providers Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @sdrow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End S3 Providers',0,@day;