-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[procCP_ACCESS_TO_CARE__MONTHLY_RPT] 
	@SelectedDate date=null

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


DECLARE @FromDate date=GETDATE()
DECLARE @ToDate date


DECLARE @WorkingDate Date
DECLARE @DayNumber int
DECLARE @NumberOfWorkingDaysAhead int = 30
DECLARE @Counter int = 0
DECLARE @WorkDayCounter int = 0

IF @SelectedDate IS NOT NULL
	BEGIN
		SET @FromDate = @SelectedDate
	END

WHILE @WorkDayCounter < @NumberOfWorkingDaysAhead
	BEGIN
		SET @WorkingDate = DATEADD(d,@Counter,@FromDate)
		SET @DayNumber = DATEPART(dw,@WorkingDate)
		SET @Counter = @Counter + 1
		IF (@DayNumber = 2 OR @DayNumber = 3 OR @DayNumber = 4 OR @DayNumber = 5 OR @DayNumber = 6)
			BEGIN
				IF (NOT EXISTS(SELECT * FROM [dbo].[HOLIDAY] WHERE HolidayObservedDate = @WorkingDate))
					BEGIN
						SET @WorkDayCounter = @WorkDayCounter + 1
					END
			END
	END
SET @ToDate = @WorkingDate



SELECT [AccessToCareHistoryId]
      ,[LocationName] AS HospitalOrClinic
      ,[ClinicName] AS HospitalLocationName
      ,[LocationId]
      ,[ProviderId]
      ,[ProviderName]
      ,[AppointmentDateTime]
      ,[AppointmentDescription]
      ,[AppointmentDate]
      ,[AppointmentDateString] AS ApptDayString
      ,[AppointmentTimeString] AS ApptTime
      ,[AppointmentType]
      ,[TotalOpen]
      ,[TotalFrozen]
      ,[TotalCancelled]
      ,[TotalBooked]
      ,[TotalWait]
      ,[TotalLocked]
      ,[ThirdNextAvailAcute] AS ThirdNextAvailAcut
      ,[HoursDiffAcute] AS HrsDifAcute
      ,[ThirdNextAvailRoutine] AS ThirdNextAvailRout
      ,[HoursDiffRoutine] AS HrsDifRoutine
      ,[ThirdNextAvailSpecial] AS ThirdNextAvailSpec
      ,[HoursDiffSpecial] AS HrsDifSpecial
      ,[ThirdNextAvailWellness] AS ThirdNextAvailWell
      ,[HoursDiffWellness] AS HrsDifWell
      ,[LastAppointment]
      ,[DaysScheduledForward]
      ,[HoursDivvAcuteDecimal] AS DaysDifDecimalAcute
      ,[HoursDiffRoutineDecimal] AS DaysDifDecimalRoutine
      ,[HoursDiffSpecialDecimal] AS DaysDifDecimalSpecial
      ,[HoursDiffWellnessDecimal] AS DaysDifDecimalWellness
      ,[CreatedDate]
	  ,@FromDate as FromDate
	  ,@ToDate AS ToDate
  FROM [dbo].[ACCESS_TO_CARE_HISTORY]
WHERE AppointmentDate >= @FromDate
AND AppointmentDate <= @ToDate

END
