
CREATE PROCEDURE [dbo].[procENet_xxxInven20130116Monitors] 
AS
BEGIN
	Declare @ast int
	Declare @rem varchar(1000)
	Declare @rem_new varchar(1000)
		
	Declare @mon nvarchar(255)
	Declare @nam nvarchar(255)
	Declare @wdt float
	Declare @f4	 float
					
	Declare @trow int
	Declare @strow varchar(50)
	Declare @exists int
			
	EXEC dbo.upLog 'Begin Monitor Updates';

	DECLARE curM CURSOR FAST_FORWARD FOR
	SELECT
		Monitor, 
		NetworkName, 
		IsNull(ScreenWidth,0), 
		IsNull(F4,0)
	FROM xxx20130115MonitorsA
	ORDER BY NetworkName
	
	OPEN curM

	SET @trow = 0
	EXEC dbo.upLog 'Fetch Monitor Updates'

	FETCH NEXT FROM curM INTO @mon, @nam, @wdt, @f4

	if(@@FETCH_STATUS = 0)

	BEGIN
		
		
		WHILE(@@FETCH_STATUS = 0)
		BEGIN
		--PRINT @nam
		--PRINT @mon
		--PRINT @wdt
		--PRINT @f4
		
		BEGIN TRANSACTION 
			SET @ast = -1
			SET @rem = ''
			SELECT @ast = AssetId,
					@rem = Remarks
				FROM ASSET
				WHERE NetworkName = @nam
				
				SET @exists = @@RowCount
				If @exists = 0 
				BEGIN
					--log missing network names
					EXEC dbo.upLog @nam;
				END
				ELSE
				BEGIN
				-- Run Updates for monitors
				UPDATE ASSET_COMPUTER
				SET DualMonitor = 1
				WHERE AssetId = @ast
					
				SET @rem_new = @rem + ' Monitor Info: ' + @mon + ' ' + CAST(@wdt AS varchar(5)) + ' ' + CAST(@f4 AS varchar(5)) + ':'	
				
				UPDATE ASSET
				SET Remarks = @rem_new
				WHERE AssetId = @ast
				
				END
			SET @trow = @trow + 1
			FETCH NEXT FROM curM INTO @mon, @nam, @wdt, @f4
		COMMIT	
		END
	END

	CLOSE curM
	DEALLOCATE curM

	SET @strow = 'Monitor Total: ' + CAST(@trow AS varchar(50))

	EXEC dbo.upLog @strow;
	EXEC dbo.upLog 'End Monitor Updates';


END
