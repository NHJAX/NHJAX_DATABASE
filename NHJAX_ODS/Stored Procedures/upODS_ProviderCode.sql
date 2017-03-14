

CREATE PROCEDURE [dbo].[upODS_ProviderCode] AS
Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @today datetime
Declare @loop int
Declare @exists int

Declare @pro bigint
Declare @code varchar(30)

Declare @proX decimal
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Provider Code',0,@day;
DECLARE curProvider CURSOR FAST_FORWARD FOR
SELECT
	ProviderId, 
	ProviderCode
FROM PROVIDER 
WHERE ProviderCode Is Not Null 
AND ProviderId > 0
	 
OPEN curProvider
SET @trow = 0
SET @irow = 0

EXEC dbo.upActivityLog 'Fetch Provider Code',0
FETCH NEXT FROM curProvider INTO @pro,@code

if(@@FETCH_STATUS = 0)
BEGIN


	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
	SELECT @proX = ProviderId
	from PROVIDER_CODE
	WHERE ProviderId = @pro
	AND ProviderCode = @code
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN

		PRINT @pro
		PRINT @proX
		PRINT @code

		INSERT INTO NHJAX_ODS.dbo.PROVIDER_CODE(ProviderId,
			ProviderCode) 
		VALUES(@pro, 
			@code);
			SET @irow = @irow + 1
		END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM curProvider INTO @pro,@code
	COMMIT
	END

END
CLOSE curProvider
DEALLOCATE curProvider
SET @trow = @trow - 1

SET @sirow = 'Provider Code Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Provider Code Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Provider Code',0,@day;

