-- =============================================
-- Author:		Robert Evans
-- Create date: 29 June 2015
-- Description:	Gets The Daily Access To Care History
-- =============================================
CREATE PROCEDURE [dbo].[procCP_GET_ACCESS_TO_CARE_DAILY_HISTORY] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

DECLARE @WorkingDate Date
DECLARE @DayNumber int
DECLARE @NumberOfWorkingDaysAhead int = 31
DECLARE @Counter int = 0
DECLARE @WorkDayCounter int = 0

DELETE FROM [dbo].[ACCESS_TO_CARE_HISTORY] WHERE [AppointmentDate] >= GETDATE()
WHILE @WorkDayCounter < @NumberOfWorkingDaysAhead
	BEGIN
		SET @WorkingDate = DATEADD(d,@Counter,getdate())
		SET @DayNumber = DATEPART(dw,@WorkingDate)
		SET @Counter = @Counter + 1
		IF (@DayNumber = 2 OR @DayNumber = 3 OR @DayNumber = 4 OR @DayNumber = 5 OR @DayNumber = 6)
			BEGIN
				IF (NOT EXISTS(SELECT * FROM [dbo].[HOLIDAY] WHERE HolidayObservedDate = @WorkingDate))
					BEGIN
						EXECUTE [procCP_GET_FUTURE_DATE_ACCESS_TO_CARE_DAILY_HISTORY] @WorkingDate
						SET @WorkDayCounter = @WorkDayCounter + 1
					END
			END
	END

END
