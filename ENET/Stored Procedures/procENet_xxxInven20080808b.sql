
CREATE PROCEDURE [dbo].[procENet_xxxInven20080808b] 
AS
BEGIN
	Declare @ser nvarchar(255)
	Declare @typ nvarchar(255)
	Declare @net nvarchar(255)
	Declare @exp nvarchar(255)
	Declare @start datetime
	Declare @end datetime
	Declare @supt varchar(255)
	Declare @s1 varchar(255)
	Declare @s2 varchar(255)
	Declare @s3 varchar(255)
	Declare @s4 varchar(255)
	Declare @s5 varchar(255)
	Declare @s6 varchar(255)
	Declare @src varchar(50)
	Declare @rem varchar(1000)
		
	Declare @serX nvarchar(255)
	Declare @typX int
	Declare @netX nvarchar(255)
	Declare @expX nvarchar(255)
	Declare @startX datetime
	Declare @remX varchar(1000)
		
	Declare @urow int
	Declare @trow int
	Declare @surow varchar(50)
	Declare @strow varchar(50)
	Declare @exists int
	Declare @uFlag int 
	Declare @modN int
	Declare @manN int
	Declare @typN int
	Declare @stypN int
	
	EXEC dbo.upLog 'Begin Server Updates';

	DECLARE cur CURSOR FAST_FORWARD FOR
	SELECT DISTINCT
		[Service Tag],
		[System Type],
		[System Description],
		Expiration,
		[Start Date],
		[End Date],
		[Support Type],
		ISNULL(S1,''),
		ISNULL(S2,''),
		ISNULL(S3,''),
		ISNULL(S4,''),
		ISNULL(S5,''),
		ISNULL(S6,''),
		'Inv20080808b' As SoureTable
			
	FROM [xxxInven20080808b]
	WHERE [Service Tag] IS NOT NULL

	OPEN cur
	SET @trow = 0
	SET @urow = 0
	EXEC dbo.upLog 'Fetch Server Updates'

	FETCH NEXT FROM cur INTO @ser,@typ, @net, @exp, @start, @end, @supt, 
	@s1, @s2, @s3, @s4, @s5, @s6, @src

	if(@@FETCH_STATUS = 0)

	BEGIN

		WHILE(@@FETCH_STATUS = 0)
		BEGIN
		BEGIN TRANSACTION 
			SET @uFlag = 0; 

			SET @rem = 'Exp: ' + @exp 
				+ ' Start: ' + CAST(@start AS varchar(16))
				+ ' End: ' + CAST(@end AS varchar(16))
				+ ' Support Type: ' + @supt
				+ ' ' + @s1
				+ ' ' + @s2
				+ ' ' + @s3
				+ ' ' + @s4
				+ ' ' + @s5
				+ ' ' + @s6

			SELECT @serX = SerialNumber,
				@netX = NetworkName,
				@startX = AcquisitionDate,
				@remX = Remarks
				FROM ASSET
				WHERE SerialNumber = CAST(@ser AS varchar(50))
				
				SET @exists = @@RowCount
				If @exists = 0 
				BEGIN
					--Add to Bit Bucket
					INSERT INTO BB_INVENTORY
					(
					[Serial Number],
					[Network Name],
					[Asset Type],
					NOTES,
					SourceTable
					)
					VALUES
					(
					@ser,
					@net,
					@typ,
					@rem,
					@src
					)
				END
				ELSE
				BEGIN
				-- Perform separate updates for each 
				-- field
						PRINT @net
						PRINT @netX
						PRINT @start
						PRINT @startX
						PRINT @rem
						PRINT @remX
						PRINT @typ
						PRINT @typX
					
						IF DataLength(@net) > 0 AND @net <> @netX
						BEGIN
							UPDATE ENet.dbo.Asset
							SET NetworkName = @net,
							DispositionId = 1,
							InventoryDate = getdate(),
							InventoryBy = 431,
							UpdateSourceSystemId = 30,
							AudienceId = 30,
							AssetTypeId = 1,
							AssetSubTypeId = 2,
							PlantAccountPrefix = '00232M',
							Room = 'COMPUTER ROOM'
							WHERE SerialNumber = @ser;
							SET @uFlag = 1;
						END
						--AcquisitionDate
						IF @start <> @startX
						BEGIN
							UPDATE ENet.dbo.Asset
							SET AcquisitionDate = @start,
							DispositionId = 1,
							InventoryDate = getdate(),
							InventoryBy = 38,
							UpdateSourceSystemId = 30,
							AudienceId = 30,
							AssetTypeId = 1,
							AssetSubTypeId = 2,
							PlantAccountPrefix = '00232M',
							Room = 'COMPUTER ROOM'
							WHERE SerialNumber = @ser;
							SET @uFlag = 1;
						END
						--Remarks
						IF @rem <> @remX
						BEGIN
							UPDATE ENet.dbo.Asset
							SET Remarks = @remX + ' ' + @rem,
							DispositionId = 1,
							InventoryDate = getdate(),
							InventoryBy = 38,
							UpdateSourceSystemId = 30,
							AudienceId = 30,
							AssetTypeId = 1,
							AssetSubTypeId = 2,
							PlantAccountPrefix = '00232M',
							Room = 'COMPUTER ROOM'
							WHERE SerialNumber = @ser;
							SET @uFlag = 1;
						END
						
						--MOD, has to be determined from file
						IF @typ = 'PowerEdge 1750'
							BEGIN
								SET @modN = 427
								SET @manN = 100
							END
						ELSE IF @typ = 'PowerEdge 1800'
							BEGIN
								SET @modN = 1399
								SET @manN = 100
							END
						ELSE IF @typ = 'PowerEdge 1950'
							BEGIN
								SET @modN = 1400
								SET @manN = 100
							END
						ELSE IF @typ = 'PowerEdge 2600'
							BEGIN
								SET @modN = 429
								SET @manN = 100
							END
						ELSE IF @typ = 'PowerEdge 2650'
							BEGIN
								SET @modN = 430
								SET @manN = 100
							END
						ELSE IF @typ = 'PowerEdge 2850'
							BEGIN
								SET @modN = 1325
								SET @manN = 100
							END
						ELSE IF @typ = 'PowerEdge 2950'
							BEGIN
								SET @modN = 1395
								SET @manN = 100
							END
						ELSE IF @typ = 'PowerEdge 600SC'
							BEGIN
								SET @modN = 1244
								SET @manN = 100
							END
						ELSE IF @typ = 'PowerVault DP500/NF500'
							BEGIN
								SET @modN = 1401
								SET @manN = 100
							END
						ELSE IF @typ = 'PowerEdge 700'
							BEGIN
								SET @modN = 1350
								SET @manN = 100
							END
						ELSE IF @typ = 'PowerEdge 1850'
							BEGIN
								SET @modN = 1402
								SET @manN = 100
							END
						ELSE IF @typ = 'EMC CX200 (Storage)'
							BEGIN
								SET @modN = 1403
								SET @manN = 356
							END
						ELSE IF @typ = 'EMC CX300'
							BEGIN
								SET @modN = 1404
								SET @manN = 356
							END
						ELSE IF @typ = 'EMC CX3-20'
							BEGIN
								SET @modN = 1405
								SET @manN = 356
							END
						ELSE IF @typ = 'EMC DAE2-ATA'
							BEGIN
								SET @modN = 1406
								SET @manN = 356
							END
						ELSE IF @typ = 'EMC DAE4P'
							BEGIN
								SET @modN = 1407
								SET @manN = 356
							END
						ELSE IF @typ = 'EMC SW3800/DS16B2 (Switch)'
							BEGIN
								SET @modN = 1408
								SET @manN = 356
								SET @typN = 12
								SET @stypN = 17
							END
						ELSE
							BEGIN
								SET @modN = 1
								SET @manN = 324
							END
						IF @modN > 1 AND @modN <> @typX
						BEGIN
							UPDATE ENet.dbo.Asset
							SET ModelId = @modN,
							ManufacturerId = @manN,
							DispositionId = 1,
							InventoryDate = getdate(),
							InventoryBy = 38,
							UpdateSourceSystemId = 30,
							AudienceId = 30,
							AssetTypeId = 1,
							AssetSubTypeId = 2,
							PlantAccountPrefix = '00232M',
							Room = 'COMPUTER ROOM'
							WHERE SerialNumber = @ser;
							SET @uFlag = 1;
						END
						--asset type - switch only
						IF @typN = 12
						BEGIN
							UPDATE ENet.dbo.Asset
							SET AssetTypeId = @typN,
								AssetSubTypeId = @stypN
							WHERE SerialNumber = @ser;
							SET @uFlag = 1;
						END
						
						--Add to count if anything updated
						If @uFlag = 1
						BEGIN
							SET @urow = @urow + 1
						END
					
				END
			SET @trow = @trow + 1
			FETCH NEXT FROM cur INTO @ser,@typ, @net, @exp, 
			@start, @end, @supt, 
			@s1, @s2, @s3, @s4, @s5, @s6, @src
		COMMIT	
		END
	END

	CLOSE cur
	DEALLOCATE cur

	SET @surow = 'Servers Updated: ' + CAST(@urow AS varchar(50))
	SET @strow = 'Servers Total: ' + CAST(@trow AS varchar(50))

	EXEC dbo.upLog @surow;
	EXEC dbo.upLog @strow;
	EXEC dbo.upLog 'End Servers Updates';


END
