

CREATE PROCEDURE [dbo].[upODS_UIC] AS

Declare @key numeric(12,3)
Declare @desc varchar(30)
Declare @code varchar(30)
Declare @brn bigint
Declare @geo bigint

Declare @descX varchar(30)
Declare @codeX varchar(30)
Declare @brnX bigint
Declare @geoX bigint

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin UIC',0,@day

DECLARE cur CURSOR FAST_FORWARD FOR
	SELECT DISTINCT 
		UIC.KEY_UNIT_SHIP_ID,
		UIC.NAME,
		UIC.CODE,
		BRN.BranchOfServiceId,
		GEO.GeographicLocationId
	FROM vwMDE_UNIT_SHIP_ID AS UIC
	INNER JOIN BRANCH_OF_SERVICE AS BRN
	ON UIC.BRANCH_OF_SERVICE_IEN = BRN.BranchOfServiceKey
	INNER JOIN GEOGRAPHIC_LOCATION AS GEO
	ON UIC.UNIT_LOCATION_IEN = GeographicLocationKey
	WHERE (UIC.CODE IS NOT NULL)
	ORDER BY UIC.NAME
	
OPEN cur
SET @trow = 0
SET @irow = 0
FETCH NEXT FROM cur INTO @key,@desc,@code,@brn,@geo
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		SELECT @descX = UICDesc,
			@codeX = UICCode,
			@brnX = BranchofServiceId,
			@geoX = GeographicLocationId
		FROM NHJAX_ODS.dbo.UIC
		WHERE UICKey = @key

			SET @exists = @@RowCount
			If @exists = 0
				BEGIN
					INSERT INTO NHJAX_ODS.dbo.UIC
					(
						UICKey,
						UICDesc,
						UICCode,
						BranchofServiceId,
						GeographicLocationId
					)
					VALUES(@key,@desc,@code,@brn,@geo);
					SET @irow = @irow + 1
				END
			ELSE
				BEGIN
				If @desc <> @descX
				OR (@desc IS NOT NULL AND @descX IS NULL)
					BEGIN
						UPDATE NHJAX_ODS.dbo.UIC
						SET UICDesc = @desc,
						UpdatedDate = getdate()
						WHERE UICKey = @key
					END
				If @code <> @codeX
				OR (@code IS NOT NULL AND @codeX IS NULL)
					BEGIN
						UPDATE NHJAX_ODS.dbo.UIC
						SET UICCode = @code,
						UpdatedDate = getdate()
						WHERE UICKey = @key
					END
				If @brn <> @brnX
				OR (@brn IS NOT NULL AND @brnX IS NULL)
					BEGIN
						UPDATE NHJAX_ODS.dbo.UIC
						SET BranchofServiceId = @brn,
						UpdatedDate = getdate()
						WHERE UICKey = @key
					END
				If @geo <> @geoX
				OR (@geo IS NOT NULL AND @geoX IS NULL)
					BEGIN
						UPDATE NHJAX_ODS.dbo.UIC
						SET GeographicLocationId = @geo,
						UpdatedDate = getdate()
						WHERE UICKey = @key
					END
			END
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @key,@desc,@code,@brn,@geo
	COMMIT	
	END
	
END
CLOSE cur
DEALLOCATE cur
SET @sirow = 'UIC Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'UIC Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;

--20111222: Added inactive flag
UPDATE    UIC
SET Inactive = 0
WHERE UICKey IN
	(SELECT KEY_UNIT_SHIP_ID
	 FROM [NHJAX-CACHE].STAGING.dbo.UNIT_SHIP_ID)
AND Inactive = 1;

EXEC dbo.upActivityLog 'End UIC',0,@day

--AWARDS2 FEEDER
EXEC [NHJAX-SQL-1A].AWARDS2.dbo.procODS_UIC_Insert