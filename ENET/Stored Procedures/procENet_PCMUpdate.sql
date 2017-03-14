


CREATE PROCEDURE [dbo].[procENet_PCMUpdate] 
AS
BEGIN
	Declare @usr int
	Declare @pro bigint
	Declare @exc bit
	Declare @npi numeric(16,3)

	Declare @proX bigint
	Declare @excX bit
	Declare @npiX numeric(16,3)

	Declare @urow int
	Declare @trow int
	Declare @irow int
	Declare @surow varchar(50)
	Declare @sirow varchar(50)
	Declare @strow varchar(50)
	Declare @exists int

	EXEC dbo.upLog 'Begin PCM';

	DECLARE curPCM CURSOR FAST_FORWARD FOR
	SELECT DISTINCT 
		CASE IsNull(EXC.PCMExceptionId,0)	
			WHEN 0 THEN 0
			ELSE 1
		END AS IsException, 
		TECH.UserId,PCM.ProviderId,
		PRO.NPIKey
	FROM dbo.vwODS_PRIMARY_CARE_MANAGER AS PCM
		INNER JOIN dbo.vwODS_PROVIDER AS PRO
		ON PCM.ProviderId = PRO.ProviderId
		INNER JOIN TECHNICIAN AS TECH
		ON PRO.ProviderSSN = TECH.SSN
		LEFT JOIN dbo.vwODS_PCM_EXCEPTION AS EXC
		ON PRO.ProviderId = EXC.PCMExceptionId
	WHERE TECH.Inactive = 0

	OPEN curPCM
	SET @trow = 0
	SET @irow = 0
	SET @urow = 0
	EXEC dbo.upLog 'Fetch PCM'

	FETCH NEXT FROM curPCM INTO @exc,@usr,@pro,@npi

	if(@@FETCH_STATUS = 0)

	BEGIN

		WHILE(@@FETCH_STATUS = 0)
		BEGIN
		BEGIN TRANSACTION  
			--PRINT @usr
			--PRINT @pro
			--PRINT @exc  
			Select 
				@proX = ProviderId,	
				@excX = IsException,
				@npiX = NPIKey
			FROM TECHNICIAN_EXTENDED
			WHERE UserId = @usr
			SET @exists = @@RowCount
			If @exists = 0 
				BEGIN
					
					INSERT INTO TECHNICIAN_EXTENDED
					(
					UserId,
					ProviderId,
					IsException,
					NPIKey
					)
					VALUES(@usr,@pro,@exc,@npi);
										
					SET @irow = @irow + 1
				END
			ELSE
				BEGIN
					IF  @pro <> @proX
					BEGIN
						UPDATE TECHNICIAN_EXTENDED
						SET
						ProviderId = @pro,
						UpdatedDate = getdate()
						WHERE UserId = @usr;
						SET @urow = @urow + 1
					END
					IF	@exc <> @excX
					BEGIN
						UPDATE TECHNICIAN_EXTENDED
						SET
						IsException = @exc,
						UpdatedDate = getdate()
						WHERE UserId = @usr;
						SET @urow = @urow + 1
					END
					IF	@npi <> @npiX
						OR (@npi IS NOT NULL AND @npiX IS NULL)
					BEGIN
						UPDATE TECHNICIAN_EXTENDED
						SET
						NPIKey = @npi,
						UpdatedDate = getdate()
						WHERE UserId = @usr;
						SET @urow = @urow + 1
					END
				END
			SET @trow = @trow + 1
			FETCH NEXT FROM curPCM INTO @exc,@usr,@pro,@npi
		COMMIT	
		END
	END

	CLOSE curPCM
	DEALLOCATE curPCM

	SET @surow = 'PCM Updated: ' + CAST(@urow AS varchar(50))
	SET @sirow = 'PCM Inserted: ' + CAST(@irow AS varchar(50))
	SET @strow = 'PCM Total: ' + CAST(@trow AS varchar(50))

	EXEC dbo.upLog @surow;
	EXEC dbo.upLog @sirow;
	EXEC dbo.upLog @strow;
	EXEC dbo.upLog 'End PCM';

END




