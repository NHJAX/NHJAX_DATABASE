CREATE PROCEDURE [dbo].[upActivityLog]
(
	@logDescription	varchar(4000),
	@iErr int
)
AS
	BEGIN TRANSACTION
	PRINT 'INSERT INTO ACTIVITY_LOG'
INSERT INTO ACTIVITY_LOG (
LogDescription,ErrorNumber) 
VALUES(@logDescription,@iErr);
	COMMIT TRANSACTION
