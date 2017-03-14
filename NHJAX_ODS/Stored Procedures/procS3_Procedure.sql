

CREATE PROCEDURE [dbo].[procS3_Procedure] AS

Declare @id int
Declare @name varchar(100)

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

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin S3 Procedures',0,@day;

DECLARE curS3 CURSOR FAST_FORWARD FOR
SELECT LUProcedureID, ProcedureName
FROM [NHJAX-DB-S3].AORS.dbo.LUProcedure
WHERE     (DefCPT IS NULL)

OPEN curS3
SET @trow = 0
SET @irow = 0
SET @urow = 0
SET @drow = 0
EXEC dbo.upActivityLog 'Fetch S3 Procedures',0
FETCH NEXT FROM curS3 INTO @id,@name

if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
				
		Select 	@nameX = CptDesc
		FROM CPT
		WHERE CptHcpcsKey = @id
		AND SourceSystemId IN (10)
		
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN

				INSERT INTO CPT(
				CptHcpcsKey,
				CptCode,
				CptDesc,
				SourceSystemId,
				CptTypeId)
				VALUES(@id,CAST(@id AS varchar(30)),@name,10,4);
				
				SET @irow = @irow + 1	

			END
		ELSE
			BEGIN

			IF	@name <> @nameX
			OR	(@name Is Not Null AND @nameX Is Null)
			BEGIN
				UPDATE PROVIDER
				SET ProviderName = @name,
					UpdatedDate = GETDATE()
				WHERE SourceSystemKey = @id
				AND SourceSystemId IN (10);
			END
						
		END
		SET @trow = @trow + 1

		FETCH NEXT FROM curS3 INTO @id,@name
			
	COMMIT
	END

END
CLOSE curS3
DEALLOCATE curS3

SET @surow = 'S3 Procedures Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'S3 Procedures Inserted: ' + CAST(@irow AS varchar(50))
SET @sdrow = 'S3 Procedures: ' + CAST(@drow AS varchar(50))
SET @strow = 'S3 Procedures Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @sdrow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End S3 Procedures',0,@day;