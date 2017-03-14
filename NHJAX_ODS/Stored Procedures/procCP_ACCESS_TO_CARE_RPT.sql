-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[procCP_ACCESS_TO_CARE_RPT] 
	@SelectedDate date=null

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


DECLARE @FromDate date=GETDATE()

IF @SelectedDate IS NOT NULL
	BEGIN
	SET @FromDate = @SelectedDate
	END

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
  FROM [dbo].[ACCESS_TO_CARE_HISTORY]
WHERE AppointmentDate = @FromDate

END
