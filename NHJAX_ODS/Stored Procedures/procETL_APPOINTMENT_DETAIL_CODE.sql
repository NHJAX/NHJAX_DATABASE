
CREATE PROCEDURE [dbo].[procETL_APPOINTMENT_DETAIL_CODE] AS

--Update Indexes
BEGIN TRY
Declare @Old bigint
Declare @New bigint
Declare @Diff Numeric(15,4)
Declare @Msg Varchar(200)

EXEC [NHJAX-CACHE].STAGING.dbo.upCreateIndexes_APPOINTMENT_DETAIL_CODES

SELECT @Old = ActivityCount FROM ACTIVITY_COUNT WHERE TableName = 'APPOINTMENT_DETAIL_CODES'
SELECT @New = Count(*) FROM [NHJAX-CACHE].STAGING.dbo.APPOINTMENT_DETAIL_CODES

SET @Diff = 1 - (CAST(@New AS Numeric(15,4))/CAST(@Old AS Numeric(15,4)))

PRINT @Old
PRINT @New
PRINT @Diff

IF @New = 0
	BEGIN
	SET @Msg = 'MDE: APPOINTMENT_DETAIL_CODES was 0'
	END
	
ELSE IF @DIFF >= .15 OR @DIFF <= -.25
	BEGIN
	SET @Msg = 'MDE: APPOINTMENT_DETAIL_CODES had a ' + CAST(@Diff AS Varchar(15)) + '% variance| OLD: ' + CAST(@Old AS Varchar(15)) + '| NEW: ' + CAST(@New AS Varchar(15))
	END

IF LEN(@Msg) > 0
	BEGIN
	--PRINT @Msg
	EXEC upActivityLog @Msg, 99995
	EXEC upSendMail @Sub='MDE/SQL Server Warning - ODS', @msg=@Msg	
	END

--UPDATE ACTIVITY_COUNT
UPDATE ACTIVITY_COUNT
SET ActivityCount = @new,
UpdatedDate = getdate()
WHERE TableName = 'APPOINTMENT_DETAIL_CODES'
END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: CHK AppointmentDetailCodes'
END CATCH

--Appointment Detail codes
BEGIN TRY
Declare @key numeric(9,3)
Declare @code varchar(8)
Declare @desc varchar(75)
Declare @inac bit

Declare @keyX numeric(9,3)
Declare @codeX varchar(8)
Declare @descX varchar(75)
Declare @inacX bit

Declare @urow int
Declare @trow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @today datetime
Declare @exists int

EXEC dbo.upActivityLog 'Begin Appointment Detail',0;


DECLARE curDtl CURSOR FAST_FORWARD FOR
SELECT     
	KEY_APPOINTMENT_DETAIL_CODES, 
	CODE, 
	DESCRIPTION, 
	CASE
		WHEN STATUS = 'ACTIVE' THEN 0
		ELSE 1
	END AS Inactive
FROM    vwMDE_APPOINTMENT_DETAIL_CODES

OPEN curDtl
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Appointment Detail',0

FETCH NEXT FROM curDtl INTO @key,@code,@desc,@inac

if(@@FETCH_STATUS = 0)

BEGIN
BEGIN TRANSACTION
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		Select 	@keyX = AppointmentDetailKey,
			@codeX = AppointmentDetailCode,
			@descX = AppointmentDetailDesc,
			@inacX = Inactive
		FROM APPOINTMENT_DETAIL_CODE
		WHERE AppointmentDetailKey = @key

		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO APPOINTMENT_DETAIL_CODE(
				AppointmentDetailKey,
				AppointmentDetailCode,
				AppointmentDetailDesc,
				Inactive)
				VALUES(@key,@code,@desc,@inac);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@code <> @codeX
		OR	@desc <> @descX
		OR 	@inac <> @inacX
		OR	(@code Is Not Null AND @codeX Is Null)
		OR 	(@desc Is Not Null AND @descX Is Null)
		OR	(@inac Is Not Null AND @inacX Is Null)

			BEGIN
			UPDATE APPOINTMENT_DETAIL_CODE
			SET 	AppointmentDetailCode = @code,
				AppointmentDetailDesc = @desc,
				Inactive = @inac,
				UpdatedDate = getdate()
			WHERE AppointmentDetailKey = @key;

			SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curDtl INTO @key,@code,@desc,@inac
	END
COMMIT
END


CLOSE curDtl
DEALLOCATE curDtl

SET @surow = 'Appointment Detail Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Appointment Detail Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Appointment Detail Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Appointment Detail',0;
END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: ETL AppointmentDetail'
END CATCH