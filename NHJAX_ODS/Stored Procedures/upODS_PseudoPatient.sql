
CREATE PROCEDURE [dbo].[upODS_PseudoPatient] AS

Declare @desc varchar(30)

Declare @descX varchar(30)

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Pseudo Patient',0,@day;

DECLARE curPseudo CURSOR FAST_FORWARD FOR
SELECT	DISTINCT PSEUDO_PATIENT
FROM	vwMDE_PATIENT
WHERE PSEUDO_PATIENT IS NOT NULL

OPEN curPseudo
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch Pseudo Patient',0

FETCH NEXT FROM curPseudo INTO @desc

if(@@FETCH_STATUS = 0)

BEGIN
BEGIN TRANSACTION
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		Select 	@descX = PseudoPatientDesc
		FROM NHJAX_ODS.dbo.PSEUDO_PATIENT
		WHERE PseudoPatientDesc = @desc

		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.PSEUDO_PATIENT(
				PseudoPatientDesc)
				VALUES(@desc);
				SET @irow = @irow + 1
			END
		SET @trow = @trow + 1
		FETCH NEXT FROM curPseudo INTO @desc
	END
COMMIT
END


CLOSE curPseudo
DEALLOCATE curPseudo

SET @sirow = 'Pseudo Patient Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Pseudo Patient Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Pseudo Patient',0,@day;
