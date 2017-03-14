
CREATE PROCEDURE [dbo].[upCP_DM_PATIENT_FLAG_20060829]
AS

	DECLARE @pflag bigint
	DECLARE @pat bigint
	DECLARE @flag int
	DECLARE @src bigint

	DECLARE @pflagX bigint

	Declare @exists int
	Declare @trow int
	Declare @irow int
	Declare @sirow varchar(50)
	Declare @strow varchar(50)
	
DECLARE curFlag CURSOR FAST_FORWARD FOR
SELECT
	PatientFlagId,
	PatientId,
	FlagId,
	SourceSystemId	
FROM
	PATIENT_FLAG
WHERE
	UpdatedDate >= dbo.StartOfDay(DATEADD(m,-24,getdate()))

OPEN curFlag

EXEC dbo.upActivityLog 'Fetch CP Patient Flag',0
FETCH NEXT FROM curFlag INTO @pflag,@pat,@flag,@src

if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		BEGIN TRANSACTION
			SELECT 	@pflagX = PatientFlagId
			FROM vwCP_PATIENT_FLAG
			WHERE PatientFlagId = @pflag;
			SET @exists = @@RowCount
			If @exists = 0 
				BEGIN
					INSERT INTO NHJAX_ODS.dbo.vwCP_PATIENT_FLAG(
					PatientFlagId,
					PatientId,
					FlagId,
					SourceSystemId)
					VALUES(@pflag,@pat,@flag,@src);
					SET @irow = @irow + 1
				END

		SET @trow = @trow + 1

		FETCH NEXT FROM curFlag INTO @pflag,@pat,@flag,@src

		COMMIT
	END

END
CLOSE curFlag
DEALLOCATE curFlag

--DELETE DATED RECORDS
DELETE FROM vwCP_PATIENT_FLAG
WHERE PatientFlagId IN
(
	SELECT vwCP_PATIENT_FLAG.PatientFlagId
	FROM vwCP_PATIENT_FLAG
	LEFT OUTER JOIN PATIENT_FLAG
	ON vwCP_PATIENT_FLAG.PatientFlagId = PATIENT_FLAG.PatientFlagId
	WHERE PATIENT_FLAG.PatientFlagId IS NULL
)

SET @sirow = 'CP Patient Flag Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'CP Patient Flag Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End CP Patient Flag',0;


