CREATE PROCEDURE [dbo].[procENET_ACTIVITY_LOG_Insert]
(
	@logDescription	varchar(8000),
	@err bigint = 0
)
AS
	BEGIN TRANSACTION

	--PRINT 'INSERT INTO ACTIVITY_LOG'

INSERT INTO ACTIVITY_LOG 
(
LogDescription,
ErrorNumber
) 
VALUES
(
@logDescription,
@err
);

	COMMIT TRANSACTION
