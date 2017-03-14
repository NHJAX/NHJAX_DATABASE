


CREATE PROCEDURE [dbo].[upActivityLog]
(
	@logDescription	varchar(4000),
	@iErr int,
	@day int = 0
)
AS

SELECT @day = ActivityCount		
	FROM ACTIVITY_COUNT 
	WHERE ActivityCountId = 0
	
	BEGIN TRANSACTION
	PRINT 'INSERT INTO ACTIVITY_LOG'
INSERT INTO ACTIVITY_LOG 
(
	LogDescription,
	ErrorNumber,
	[DayofWeek]
) 
VALUES(@logDescription,@iErr,@day);
	COMMIT TRANSACTION


