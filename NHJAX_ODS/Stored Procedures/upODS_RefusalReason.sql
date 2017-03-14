
CREATE PROCEDURE [dbo].[upODS_RefusalReason] AS

Declare @key numeric(8,3)
Declare @code numeric(13,5)
Declare @desc varchar(65)
Declare @ref bigint

Declare @keyX numeric(8,3)
Declare @codeX numeric(13,5)
Declare @descX varchar(65)
Declare @refX bigint

Declare @urow int
Declare @trow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @today datetime
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Refusal Reason',0,@day;

SET @today = getdate()
DECLARE curRef CURSOR FAST_FORWARD FOR
SELECT	MCP_REF.KEY_MCP_APPOINTMENT_REFUSAL_REASON, 
	MCP_REF.CODE, 
	MCP_REF.DESCRIPTION, 
	ISNULL(REF.RefusalStatusId, 0) AS RefusalStatusId
FROM    REFUSAL_STATUS REF 
	RIGHT OUTER JOIN vwMDE_MCP_APPOINTMENT_REFUSAL_REASON MCP_REF 
	ON REF.RefusalStatusDesc = MCP_REF.TYPE_

OPEN curRef
SET @trow = 0
SET @irow = 0
SET @urow = 0

EXEC dbo.upActivityLog 'Fetch Refusal Reason',0

FETCH NEXT FROM curRef INTO @key,@code,@desc,@ref
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@keyX = RefusalReasonKey,
			@codeX = RefusalReasonCode,
			@descX = RefusalReasonDesc,
			@refX = RefusalStatusId
		FROM NHJAX_ODS.dbo.REFUSAL_REASON
		WHERE RefusalReasonKey = @key
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.REFUSAL_REASON(
				RefusalReasonKey,
				RefusalReasonCode,
				RefusalReasonDesc,
				RefusalStatusId)
				VALUES(@key,@code,@desc,@ref);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@desc <> @descX
		OR	@code <> @codeX
		OR	@ref <> @refX
		OR 	(@desc Is Not Null AND @descX Is Null)
		OR	(@code Is Not Null AND @codeX Is Null)
		OR	(@ref Is Not Null AND @refX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.REFUSAL_REASON
			SET 	RefusalReasonDesc = @desc,
				RefusalReasonCode = @code,
				RefusalStatusId = @ref,
				UpdatedDate = @today
			WHERE RefusalReasonKey = @key;
			SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curRef INTO @key,@code,@desc,@ref
	COMMIT
	END
END
CLOSE curRef
DEALLOCATE curRef
SET @surow = 'Refusal Reason Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Refusal Reason Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Refusal Reason Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Refusal Reason',0,@day;
