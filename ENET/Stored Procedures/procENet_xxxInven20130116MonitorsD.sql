
CREATE PROCEDURE [dbo].[procENet_xxxInven20130116MonitorsD] 
AS
BEGIN
	Declare @ast int
	Declare @rem varchar(1000)
	Declare @rem_new varchar(1000)
		
	Declare @mon nvarchar(255)
	Declare @nam nvarchar(255)
	Declare @wdt float
	Declare @ip	 nvarchar(255)
	Declare @ipX varchar(50)
					
	Declare @trow int
	Declare @strow varchar(50)
	Declare @exists int
			
	EXEC dbo.upLog 'Begin Monitor Updates';

	DECLARE curM CURSOR FAST_FORWARD FOR
	SELECT
		Monitor, 
		NetworkName, 
		IsNull(ScreenWidth,0),
		IsNull(IPAddress,'')
	FROM xxx20130115MonitorsD
	ORDER BY NetworkName
	
	OPEN curM

	SET @trow = 0
	EXEC dbo.upLog 'Fetch Monitor Updates'

	FETCH NEXT FROM curM INTO @mon, @nam, @wdt, @ip

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
					
				SET @rem_new = @rem + ' Monitor Info: ' + @mon + ' ' + CAST(@wdt AS varchar(5)) + '' + 'Dual Monitors' + ':'	
				
				UPDATE ASSET
				SET Remarks = @rem_new
				WHERE AssetId = @ast
				
				--IP Addresses from SMS
				SELECT @ipX FROM ASSET_IP
				WHERE IPAddress = @ip
				AND AssetId = @ast
				
				SET @exists = @@RowCount
				If @exists = 0 
					BEGIN
						INSERT INTO ASSET_IP
						(
						AssetId,IPAddress
						)
						VALUES
						(@ast,@ip)
					END
				
				END
			SET @trow = @trow + 1
			FETCH NEXT FROM curM INTO @mon, @nam, @wdt, @ip
		COMMIT	
		END
	END

	CLOSE curM
	DEALLOCATE curM

	SET @strow = 'Monitor Total: ' + CAST(@trow AS varchar(50))

	EXEC dbo.upLog @strow;
	EXEC dbo.upLog 'End Monitor Updates';


END
