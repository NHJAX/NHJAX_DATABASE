

-- =============================================
-- Author:		K. Sean Kern
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[upCHK_ActivityLog] 
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;

-- Insert statements for procedure here
Declare @Begin Int
Declare @End Int
Declare @start datetime
Declare @fin datetime
Declare @day int

SET @start = dbo.StartOfDay(GETDATE())
SET @fin = dbo.EndOfDay(GETDATE())

SELECT @day = ActivityCount FROM ACTIVITY_COUNT WHERE ActivityCountId = 0

SELECT @Begin = Count(LogId)
FROM         ACTIVITY_LOG
WHERE     ([DayofWeek] = @day)
	AND LogDescription LIKE '%Begin%' 
	AND (ErrorNumber IS NOT NULL)

SELECT @End = Count(LogId)
FROM         ACTIVITY_LOG
WHERE     ([DayofWeek] = @day)
	AND LogDescription LIKE '%End%' AND (ErrorNumber IS NOT NULL)

IF (@Begin <> @End)
BEGIN
	EXEC dbo.upActivityLog 'ERROR OCCURRED - Begin Does Not Match End', 99996
	EXEC upSendMail @Sub='SQL Server Error - ODS', @Msg = 'Begin Does Not Match End'
END
ELSE
	EXEC dbo.upActivityLog 'STOP PRE-PROCESS',0
END


