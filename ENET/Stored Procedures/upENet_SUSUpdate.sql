


CREATE PROCEDURE [dbo].[upENet_SUSUpdate] 
AS
BEGIN
	Declare @net varchar(100)
	Declare @sync datetime
	Declare @stat datetime
	Declare @reb datetime
	Declare @ip varchar(50)
	Declare @os int
	Declare @sp int
	Declare @man int
	Declare @mod int
	Declare @ast int

	Declare @netX varchar(100)
	Declare @syncX datetime
	Declare @statX datetime
	Declare @rebX datetime
	Declare @ipX varchar(50)
	Declare @osX int
	Declare @spX int
	Declare @manX int
	Declare @modX int
	Declare @astX int

	Declare @urow int
	Declare @trow int
	Declare @irow int
	Declare @surow varchar(50)
	Declare @sirow varchar(50)
	Declare @strow varchar(50)
	Declare @exists int
	Declare @today datetime

	EXEC dbo.upLog 'Begin SUS';

	DECLARE curSUS CURSOR FAST_FORWARD FOR
	SELECT DISTINCT
		CASE charindex('.nmed',fulldomainname)
			WHEN 0 THEN fulldomainname
		ELSE
			left(fulldomainname,charindex('.nmed',fulldomainname)-1)
		END AS domainname,
		LastSyncTime,
		LastReportedStatusTime,
		LastReportedRebootTime,
		IPAddress,
		OSMinorVersion,
		OSServicePackMajorNumber,
		CASE 
		WHEN ComputerMake LIKE 'Acer%' THEN 5
		WHEN ComputerMake LIKE 'Compaq%' THEN 66
		WHEN ComputerMake LIKE 'Dell%' THEN 100
		WHEN ComputerMake LIKE 'IBM%' THEN 150
		WHEN ComputerMake LIKE 'Gateway%' THEN 136
		WHEN ComputerMake LIKE 'Hewlett%' THEN 144
		ELSE 324
	END AS ManufacturerId,
	CASE ComputerModel
		WHEN 'Dell DXG051' THEN 1353
		WHEN 'TravelMate C100' THEN 32
		WHEN 'TravelMate C110' THEN 1290
		WHEN 'Deskpro EN Series' THEN 1331
		WHEN 'Dimension 2400' THEN 1324
		WHEN 'Inspiron 8500' THEN 1345
		WHEN 'Latitude C600' THEN 1260
		WHEN 'Latitude D505' THEN 1262
		WHEN 'Latitude D610' THEN 414
		WHEN 'Latitude D810' THEN 1352
		WHEN 'Latitude C840' THEN 1257
		WHEN 'Latitude D600' THEN 415
		WHEN 'OptiPlex 170L' THEN 1239
		WHEN 'OptiPlex GX110' THEN 419
		WHEN 'OptiPlex GX150' THEN 420
		WHEN 'OptiPlex GX240' THEN 421
		WHEN 'OptiPlex GX260' THEN 422
		WHEN 'OptiPlex GX270' THEN 423
		WHEN 'OptiPlex GX400' THEN 424
		WHEN 'OptiPlex SX270' THEN 426
		WHEN 'OptiPlex GX280' THEN 1238
		WHEN 'OptiPlex GX520' THEN 1328
		WHEN 'OptiPlex GX620' THEN 1335
		WHEN 'OptiPlex SX280' THEN 1228
		WHEN 'PowerEdge 1550/1266' THEN 1347
		WHEN 'PowerEdge 1750' THEN 427
		WHEN 'PowerEdge 2300/600' THEN 1242
		WHEN 'PowerEdge 2500' THEN 1348
		WHEN 'PowerEdge 2550' THEN 428
		WHEN 'PowerEdge 2600' THEN 429
		WHEN 'PowerEdge 2650' THEN 430
		WHEN 'PowerEdge 2850' THEN 1325
		WHEN 'PowerEdge 4200/300' THEN 431
		WHEN 'PowerEdge 4400' THEN 432
		WHEN 'PowerEdge 6400/700' THEN 433
		WHEN 'PowerEdge 6450/700' THEN 1349
		WHEN 'PowerEdge 6650' THEN 434
		WHEN 'PowerEdge 700' THEN 1350
		WHEN 'Precision WorkStation 340' THEN 436
		WHEN 'Precision WorkStation 650' THEN 437
		WHEN 'Precision WorkStation 380' THEN 1339
		WHEN 'Precision WorkStation 670' THEN 1336
		WHEN 'XPS800' THEN 1351
		WHEN 'ALR 8200' THEN 496
		WHEN 'E-4000' THEN 1354
		WHEN 'E-4200' THEN 503
		WHEN 'MP44BX' THEN 520
		WHEN 'N0CPP058' THEN 521
		WHEN 'Profile4' THEN 524
		WHEN 'TABOR_II' THEN 1355
		WHEN 'HP Vectra' THEN 732
		WHEN 'HP Vectra PC' THEN 732
		WHEN 'HP OmniBook PC' THEN 712
		WHEN '628790U' THEN 759
		WHEN '657420U' THEN 761
		WHEN '657423U' THEN 762
		WHEN '679411U' THEN 764
		WHEN '682521U' THEN 766
		WHEN '6840GAU' THEN 1357
		WHEN '8307CCU' THEN 1358
		ELSE 1
	END AS ModelId
	 FROM ENet.dbo.tempComputerTarget
	ORDER BY LastSyncTime

	OPEN curSUS
	SET @trow = 0
	SET @irow = 0
	SET @urow = 0
	EXEC dbo.upLog 'Fetch SUS'

	FETCH NEXT FROM curSUS INTO @net,@sync,@stat,@reb,@ip,
		@os,@sp,@man,@mod

	if(@@FETCH_STATUS = 0)

	BEGIN

		WHILE(@@FETCH_STATUS = 0)
		BEGIN
		BEGIN TRANSACTION  
			--PRINT @net
			--PRINT @man
			--PRINT @mod  
			Select 
				@astX = AssetId,	
				@syncX = LastSyncTime,
				@statX = LastReportedStatusTime,
				@rebX = LastReportedRebootTime,
				@osX = OSMinorVersion,
				@spX = OSServicePackMajorNumber,
				@manX = ManufacturerId,
				@modX = ModelId
			FROM ENet.dbo.vwSUSInfo
			WHERE NetworkName = @net
			SET @exists = @@RowCount
			If @exists = 0 
				BEGIN
					SET @today = DATEADD(day,-365,getdate())
					INSERT INTO ENet.dbo.ASSET(
					NetworkName,
					AssetTypeId,
					ManufacturerId,
					ModelId,
					CreatedBy,
					UpdatedBy,
					UpdatedDate,
					DispositionId)
					VALUES(@net,1,@man,@mod,38,38,@today,1);
					SET @ast = @@IDENTITY

					INSERT INTO ENet.dbo.ASSET_IP(
					AssetId,
					IPAddress,
					CreatedBy)
					VALUES(@ast,@ip,38);
					

					INSERT INTO ENet.dbo.ASSET_COMPUTER(
					AssetId,
					OSMinorVersion,
					OSServicePackMajorNumber,
					LastSyncTime,
					LastReportedStatusTime,
					LastReportedRebootTime)
					VALUES(@ast,@os,@sp,@sync,@stat,@reb)
					
					SET @irow = @irow + 1
				END
			ELSE
				BEGIN
					IF  @man <> @manX
					OR	@mod <> @modX
					OR 	(@man <> 324 AND @manX = 324)
					OR	(@mod <> 1 AND @modX = 1)
					BEGIN
						SET @today = getdate()
						UPDATE ENet.dbo.ASSET
						SET
						ManufacturerId = @man,
						ModelId = @mod,
						DispositionId = 1,
						UpdatedBy = 38
						WHERE AssetId = @astX;
						SET @urow = @urow + 1
					END
					IF	@os <> @osX
					OR	@sp <> @spX
					OR	@sync <> @syncX
					OR	@stat <> @statX
					OR	@reb <> @rebX
					OR 	(@os Is Not Null AND @osX Is Null)
					OR 	(@sp Is Not Null AND @spX Is Null)
					OR 	(@sync Is Not Null AND @syncX Is Null)
					OR 	(@stat Is Not Null AND @statX Is Null)
					OR 	(@reb Is Not Null AND @rebX Is Null)
					BEGIN
						SET @today = getdate()
						UPDATE ENet.dbo.ASSET_COMPUTER
						SET 	
						OSMinorVersion = @os,
						OSServicePackMajorNumber = @sp,
						LastSyncTime = @sync,
						LastReportedStatusTime = @stat,
						LastReportedRebootTime = @reb,
						UpdatedDate = @today
						WHERE AssetId = @astX;
						SET @urow = @urow + 1
					END
					--Check for IP Address before Inserting
					--PRINT @ip
					--PRINT @astX
					if DataLength(@ip) > 0
					BEGIN
					Select @ipX = IPAddress 
					FROM ENet.dbo.ASSET_IP
					WHERE IPAddress = @ip
					AND AssetId = @astX
					SET @exists = @@RowCount
					If @exists = 0
					BEGIN
						INSERT INTO ENet.dbo.ASSET_IP(
						AssetId,
						IPAddress,
						CreatedBy)
						VALUES(@astX,@ip,38);
						SET @urow = @urow + 1
					END
					END
			END
			SET @trow = @trow + 1
			FETCH NEXT FROM curSUS INTO @net,@sync,@stat,@reb,@ip,
				@os,@sp,@man,@mod
		COMMIT	
		END
	END

	CLOSE curSUS
	DEALLOCATE curSUS

	SET @surow = 'SUS Updated: ' + CAST(@urow AS varchar(50))
	SET @sirow = 'SUS Inserted: ' + CAST(@irow AS varchar(50))
	SET @strow = 'SUS Total: ' + CAST(@trow AS varchar(50))

	EXEC dbo.upLog @surow;
	EXEC dbo.upLog @sirow;
	EXEC dbo.upLog @strow;
	EXEC dbo.upLog 'End SUS';

--secondary loop to deactivate computers > 30 activity.
	Declare @asst int
	Declare @netw varchar(100)
	Declare @netwX nvarchar(255)	

	EXEC dbo.upLog 'Begin SUS2';

	DECLARE curSUS CURSOR FAST_FORWARD FOR
	SELECT
		AssetId, 
		NetworkName + '%' AS NetworkName
	FROM	ASSET
	WHERE	(AssetTypeId < 2) 
		AND (DispositionId IN (0, 1)) 
		AND (DATEDIFF(d, UpdatedDate, GETDATE()) > 30)

	OPEN curSUS
	SET @trow = 0
	SET @irow = 0
	SET @urow = 0
	EXEC dbo.upLog 'Fetch SUS2'

	FETCH NEXT FROM curSUS INTO @asst,@netw

	if(@@FETCH_STATUS = 0)

	BEGIN

		WHILE(@@FETCH_STATUS = 0)
		BEGIN
		BEGIN TRANSACTION  
			 
			Select 
				@netwX = FullDomainName
			From tempComputerTarget
			Where FullDomainName Like @netw

			SET @exists = @@RowCount
			If @exists = 0 
				BEGIN
					UPDATE ASSET
					SET DispositionId = 20,
					UpdatedDate = getdate(),
					UpdatedBy = 38
					WHERE AssetId = @asst

					SET @urow = @urow + 1
				END
		SET @trow = @trow + 1
			FETCH NEXT FROM curSUS INTO @asst, @netw
		COMMIT	
		END
	END

	CLOSE curSUS
	DEALLOCATE curSUS

	SET @surow = 'SUS2 Updated: ' + CAST(@urow AS varchar(50))
	SET @strow = 'SUS2 Total: ' + CAST(@trow AS varchar(50))

	EXEC dbo.upLog @surow;
	EXEC dbo.upLog @strow;
	EXEC dbo.upLog 'End SUS2';

END




