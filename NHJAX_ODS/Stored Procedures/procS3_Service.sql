

CREATE PROCEDURE [dbo].[procS3_Service] AS

Declare @err varchar(4000)

Declare @id int
Declare @name nvarchar(50)

Declare @nameX varchar(75)

Declare @urow int
Declare @trow int
Declare @irow int
Declare @drow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @sdrow varchar(50)

Declare @exists int
Declare @day int

EXEC dbo.upActivityLog 'Begin S3 Service LU',0,@day;

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

DECLARE curS3 CURSOR FAST_FORWARD FOR
SELECT 
	LUServiceID,
	[Service]
FROM [NHJAX-DB-S3].AORS.dbo.LUService  


OPEN curS3
SET @trow = 0
SET @irow = 0
SET @urow = 0
SET @drow = 0
EXEC dbo.upActivityLog 'Fetch S3 Service LU',0
FETCH NEXT FROM curS3 INTO @id,@name

if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		--BEGIN TRY
		
		Select 	@nameX = ServiceTypeDesc
		FROM SERVICE_TYPE
		WHERE ServiceTypeId = @id
				
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				
				INSERT INTO SERVICE_TYPE(
				ServiceTypeId,
				ServiceTypeDesc)
				VALUES(@id,@name);
				
				SET @irow = @irow + 1	

			END
		ELSE
			BEGIN

			IF	@name <> @nameX
			OR	(@name Is Not Null AND @nameX Is Null)
			BEGIN
				UPDATE SERVICE_TYPE
				SET ServiceTypeDesc = @name
				WHERE ServiceTypeId = @id;
			END
						
		END
		SET @trow = @trow + 1
		
		FETCH NEXT FROM curS3 INTO @id,@name
			
	COMMIT
	END

END
CLOSE curS3
DEALLOCATE curS3

SET @surow = 'S3 Service LU Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'S3 Service LU Inserted: ' + CAST(@irow AS varchar(50))
SET @sdrow = 'S3 Service LU: ' + CAST(@drow AS varchar(50))
SET @strow = 'S3 Service LU Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @sdrow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End S3 Service LU',0,@day;