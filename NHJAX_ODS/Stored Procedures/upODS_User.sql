

CREATE PROCEDURE [dbo].[upODS_User] AS

Declare @usr numeric(12,4)
Declare @name varchar(30)
Declare @pro bigint
Declare @term datetime
Declare @ssn varchar(30)
Declare @last varchar(17)

Declare @usrX numeric(12,4)
Declare @nameX varchar(30)
Declare @proX bigint
Declare @termX datetime
Declare @ssnX varchar(30)
Declare @lastX varchar(17)

Declare @urow int
Declare @trow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @today datetime
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin User',0,@day;

DECLARE curUser CURSOR FAST_FORWARD FOR
SELECT     
	USR.KEY_USER, 
	USR.NAME, 
    ISNULL(PROVIDER.ProviderId,-1), 
	USR.TERMINATION_DATE,
	USR.SSN,
	USR.LAST_SIGN_ON_DATE_TIME
FROM   vwMDE_USER_ USR
	LEFT OUTER JOIN PROVIDER 
	ON USR.PROVIDER_IEN = PROVIDER.ProviderKey 

OPEN curUser
SET @trow = 0
SET @irow = 0
SET @urow = 0

EXEC dbo.upActivityLog 'Fetch User',0

FETCH NEXT FROM curUser INTO @usr,@name,@pro,@term,@ssn,@last
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@usrX = CHCSUserKey,
			@nameX = CHCSUserName,
			@proX = ProviderId,
			@termX = TerminationDate,
			@ssnX = SSN,
			@lastX = LastSignOn
		FROM NHJAX_ODS.dbo.CHCS_USER
		WHERE CHCSUserKey = @usr
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.CHCS_USER(
				CHCSUserKey,
				CHCSUserName,
				ProviderId,
				TerminationDate,
				SSN,
				LastSignOn)
				VALUES(@usr,@name,@pro,@term,@ssn,@last);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@name <> @nameX
		OR	@pro <> @proX
		OR	@term <> @termX
		OR	@ssn <> @ssnX
		OR	@last <> @lastX
		OR 	(@name Is Not Null AND @nameX Is Null)
		OR	(@pro Is Not Null AND @proX Is Null)
		OR	(@term Is Not Null AND @termX Is Null)
		OR	(@ssn Is Not Null AND @ssnX Is Null)
		OR	(@last Is Not Null AND @lastX Is Null)
			BEGIN

			SET @today = getdate()
			UPDATE NHJAX_ODS.dbo.CHCS_USER
			SET 	CHCSUserName = @name,
				ProviderId = @pro,
				TerminationDate = @term,
				SSN = @ssn,
				LastSignOn = @last,
				UpdatedDate = @today
			WHERE CHCSUserKey = @usr;
			SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curUser INTO @usr,@name,@pro,@term,@ssn,@last
	COMMIT
	END
END
CLOSE curUser
DEALLOCATE curUser
SET @surow = 'User Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'User Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'User Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End User',0,@day;

