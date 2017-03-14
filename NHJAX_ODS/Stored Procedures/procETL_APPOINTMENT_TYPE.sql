
CREATE PROCEDURE [dbo].[procETL_APPOINTMENT_TYPE] AS

--Update Indexes
BEGIN TRY
Declare @Old bigint
Declare @New bigint
Declare @Diff Numeric(15,4)
Declare @Msg Varchar(200)

EXEC [NHJAX-CACHE].STAGING.dbo.upCreateIndexes_APPOINTMENT_TYPE

SELECT @Old = ActivityCount FROM ACTIVITY_COUNT WHERE TableName = 'APPOINTMENT_TYPE'
SELECT @New = Count(*) FROM [NHJAX-CACHE].STAGING.dbo.APPOINTMENT_TYPE

SET @Diff = 1 - (CAST(@New AS Numeric(15,4))/CAST(@Old AS Numeric(15,4)))

PRINT @Old
PRINT @New
PRINT @Diff

IF @New = 0
	BEGIN
	SET @Msg = 'MDE: APPOINTMENT_TYPE was 0'
	END
	
ELSE IF @DIFF >= .15 OR @DIFF <= -.25
	BEGIN
	SET @Msg = 'MDE: APPOINTMENT_TYPE had a ' + CAST(@Diff AS Varchar(15)) + '% variance| OLD: ' + CAST(@Old AS Varchar(15)) + '| NEW: ' + CAST(@New AS Varchar(15))
	END

IF DataLength(@Msg) > 0
	BEGIN
	--PRINT @Msg
	EXEC upActivityLog @Msg, 99995
	EXEC upSendMail @Sub='MDE/SQL Server Warning - ODS', @msg=@Msg	
	END

--UPDATE ACTIVITY_COUNT
UPDATE ACTIVITY_COUNT
SET ActivityCount = @new,
UpdatedDate = getdate()
WHERE TableName = 'APPOINTMENT_TYPE'
END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: CHK AppointmentType'
END CATCH

BEGIN TRY
Declare @type numeric(10,3)
Declare @code varchar(5)
Declare @desc varchar(30)
Declare @stat bit

Declare @typeX numeric(10,3)
Declare @codeX varchar(5)
Declare @descX varchar(30)
Declare @statX bit

Declare @urow int
Declare @trow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @today datetime
Declare @exists int

EXEC dbo.upActivityLog 'Begin Appt Type',0;

SET @today = getdate()

DECLARE curApptType CURSOR FAST_FORWARD FOR
SELECT	KEY_APPOINTMENT_TYPE,
	NAME,
	DESCRIPTION,
	CASE STATUS
		WHEN 'ACTIVE' THEN 0
		ELSE 1
	END AS Inactive
FROM	vwMDE_APPOINTMENT_TYPE


OPEN curApptType
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Appt Type',0

FETCH NEXT FROM curApptType INTO @type,@code,@desc,@stat

if(@@FETCH_STATUS = 0)

BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@typeX = AppointmentTypeKey,
			@codeX = AppointmentTypeCode,
			@descX = AppointmentTypeDesc,
			@statX = Inactive
		FROM APPOINTMENT_TYPE
		WHERE AppointmentTypeKey = @type

		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO APPOINTMENT_TYPE(
				AppointmentTypeKey,
				AppointmentTypeCode,
				AppointmentTypeDesc,
				Inactive)
				VALUES(@type,@code,@desc,@stat);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@desc <> @descX
		OR	@code <> @codeX
		OR  @stat <> @statX
		OR 	(@desc Is Not Null AND @descX Is Null)
		OR	(@code Is Not Null AND @codeX Is Null)
		OR	(@stat Is Not Null AND @statX Is Null)
			BEGIN
			UPDATE APPOINTMENT_TYPE
			SET	AppointmentTypeCode = @code,
				AppointmentTypeDesc = @desc,
				Inactive = @stat,
				UpdatedDate = @today
			WHERE AppointmentTypeKey = @type;

			SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curApptType INTO @type,@code,@desc,@stat
	COMMIT
	END

END


CLOSE curApptType
DEALLOCATE curApptType

SET @surow = 'Appt Type Updated' + CAST(@urow AS varchar(50))
SET @sirow = 'Appt Type Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Appt Type Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Appt Type',0;
END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: ETL ApptType'
END CATCH