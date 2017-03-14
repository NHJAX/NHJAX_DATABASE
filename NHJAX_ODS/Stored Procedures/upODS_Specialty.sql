

CREATE PROCEDURE [dbo].[upODS_Specialty] AS

Declare @spec bigint
Declare @pro bigint
Declare @key numeric(8,3)
Declare @specX bigint

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Specialty',0,@day

DECLARE curSpec CURSOR FAST_FORWARD FOR
	SELECT DISTINCT ProviderId,
		KEY_PROVIDER$PROVIDER_SPECIALTY_S_,
		ProviderSpecialtyId
	FROM vwMDE_PROVIDER$PROVIDER_SPECIALTY_S AS SPEC
	INNER JOIN PROVIDER AS PRO
	ON SPEC.KEY_PROVIDER = PRO.ProviderKey
	INNER JOIN PROVIDER_SPECIALTY AS PS
	ON SPEC.PROVIDER_SPECIALTY_S__IEN = PS.ProviderSpecialtyKey 

OPEN curSpec
SET @trow = 0
SET @irow = 0
FETCH NEXT FROM curSpec INTO @pro,@key,@spec
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		SELECT @specX = ProviderSpecialtyId FROM NHJAX_ODS.dbo.SPECIALTY
			WHERE ProviderId = @pro
			AND SpecialtyKey = @key

			SET @exists = @@RowCount
			If @exists = 0
				BEGIN
					INSERT INTO NHJAX_ODS.dbo.SPECIALTY
					(SpecialtyKey,
					ProviderId,
					ProviderSpecialtyId)
					VALUES(@key,@pro,@spec);
					SET @irow = @irow + 1
				END
		SET @trow = @trow + 1
		FETCH NEXT FROM curSpec INTO @pro,@key,@spec
	COMMIT	
	END
	
END
CLOSE curSpec
DEALLOCATE curSpec
SET @sirow = 'Specialty Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Specialty Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;

EXEC dbo.upActivityLog 'End Specialty',0,@day

