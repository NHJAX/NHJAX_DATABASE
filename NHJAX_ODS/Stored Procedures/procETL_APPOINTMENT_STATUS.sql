
CREATE PROCEDURE [dbo].[procETL_APPOINTMENT_STATUS] AS

--Update Indexes
BEGIN TRY
Declare @Old bigint
Declare @New bigint
Declare @Diff Numeric(15,4)
Declare @Msg Varchar(200)

EXEC [NHJAX-CACHE].STAGING.dbo.upCreateIndexes_APPOINTMENT_STATUS

SELECT @Old = ActivityCount FROM ACTIVITY_COUNT WHERE TableName = 'APPOINTMENT_STATUS'
SELECT @New = Count(*) FROM [NHJAX-CACHE].STAGING.dbo.APPOINTMENT_STATUS

SET @Diff = 1 - (CAST(@New AS Numeric(15,4))/CAST(@Old AS Numeric(15,4)))

PRINT @Old
PRINT @New
PRINT @Diff

IF @New = 0
	BEGIN
	SET @Msg = 'MDE: APPOINTMENT_STATUS was 0'
	END
	
ELSE IF @DIFF >= .15 OR @DIFF <= -.25
	BEGIN
	SET @Msg = 'MDE: APPOINTMENT_STATUS had a ' + CAST(@Diff AS Varchar(15)) + '% variance| OLD: ' + CAST(@Old AS Varchar(15)) + '| NEW: ' + CAST(@New AS Varchar(15))
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
WHERE TableName = 'APPOINTMENT_STATUS'

if exists(SELECT * FROM dbo.sysobjects WHERE name = '#Temp')
BEGIN
DROP TABLE #Temp;
END
END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: CHK AppointmentStatus'
END CATCH

BEGIN TRY
Declare @trow int
Declare @urow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @today datetime
Declare @loop int
Declare @exists int

Declare @statkey decimal
Declare @statdesc varchar(30)

Declare @statkeyX decimal
Declare @statdescX varchar(30)

EXEC dbo.upActivityLog 'Begin Appointment Status',0;

Select Identity(int,1,1) ID,
	KEY_APPOINTMENT_STATUS, 
	APPOINTMENT_STATUS
	into #Temp 
	FROM vwMDE_APPOINTMENT_STATUS
	ORDER BY KEY_APPOINTMENT_STATUS

SET @loop = @@rowcount
SET @today = getdate()

SET @urow = 0
SET @irow = 0
SET @trow = 1

While @trow <= @loop
BEGIN
BEGIN TRANSACTION	
	Select @statkey = KEY_APPOINTMENT_STATUS, 
	@statdesc = APPOINTMENT_STATUS
	from #Temp 
	Where ID = @trow
		
	Select @statkeyX = AppointmentStatusKey, 
	@statdescX = AppointmentStatusDesc
	from APPOINTMENT_STATUS
	Where AppointmentStatusKey = @statkey
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO APPOINTMENT_STATUS(AppointmentStatusKey, 
			AppointmentStatusDesc) 
		VALUES(@statkey, 
			@statdesc);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @statdesc <> @statdescX
		OR (@statdesc Is Not Null AND @statdescX Is Null)
			BEGIN
			UPDATE APPOINTMENT_STATUS
			SET AppointmentStatusDesc = @statdesc,
			UpdatedDate = @today
			WHERE AppointmentStatusKey = @statkey;

			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
COMMIT
END
SET @trow = @trow - 1
SET @surow = 'Appointment Status Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Appointment Status Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Appointment Status Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Appointment Status',0;
Drop table #Temp
END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: ETL AppointmentStatus'
END CATCH