
CREATE PROCEDURE [dbo].[procENet_xxxInven20100714] 
AS
BEGIN
	Declare @pa float
	Declare @mod nvarchar(255)
	Declare @ser nvarchar(255)
	Declare @ecn nvarchar(255)
	Declare @iby int
	Declare @adate datetime
	Declare @bas int
		
	Declare @paX float
	Declare @modX nvarchar(255)
	Declare @serX nvarchar(255)
	Declare @ecnX nvarchar(255)
	Declare @ibyX int
	Declare @adateX datetime
	Declare @basX int
	Declare @netX varchar(100)
		
	Declare @urow int
	Declare @trow int
	Declare @surow varchar(50)
	Declare @strow varchar(50)
	Declare @exists int
	Declare @net varchar(100)
	Declare @bldg int
	Declare @rm varchar(50)
	Declare @id int
	Declare @uFlag bit 
		
	EXEC dbo.upLog 'Begin Inventory Updates';

	DECLARE cur CURSOR FAST_FORWARD FOR
	SELECT
		[PlantAccountNumber], 
		Model, 
		[SERIAL], 
		[EqpMgtBarCode], 
		'7/27/2010' AS DT,
		1 AS BaseId
	FROM xxxInven20100727_NHJAX
	WHERE PlantAccountNumber IS NOT NULL
	
	--UNION
	--SELECT
	--	[P/A], 
	--	[MODEL], 
	--	[SERIAL NUMBER], 
	--	[ECN  NUMBER],
	--	[DATE],
	--	6 AS BaseId
	--FROM xxxInven20100714_Keywest
	--WHERE [P/A] IS NOT NULL

	OPEN cur
	SET @uFlag = 0
	SET @trow = 0
	SET @urow = 0
	EXEC dbo.upLog 'Fetch Inventory Updates'

	FETCH NEXT FROM cur INTO @pa,@mod, @ser, @ecn, @adate, @bas

	if(@@FETCH_STATUS = 0)

	BEGIN

		WHILE(@@FETCH_STATUS = 0)
		BEGIN
		BEGIN TRANSACTION 
			IF @bas = 1
			BEGIN
				SET @net = 'NHJAX-3CH' + CAST(@pa AS varchar(5))
				SET @bldg = 18
				SET @rm = '111'
			END
			IF @bas = 3
			BEGIN
				SET @net = 'NHJAX-3ALB' + CAST(@pa AS varchar(5))
				SET @bldg = 4
				SET @rm = 'I-65'
			END
			IF @bas = 6
			BEGIN
				SET @net = 'NHJAX-3KW' + CAST(@pa AS varchar(5))
				SET @bldg = 9
				SET @rm = 'MID'
			END 

			SELECT @serX = SerialNumber,
				@paX = PlantAccountNumber,
				@ecnX = EqpMgtBarCode,
				@modX = ModelId,
				@adateX = AcquisitionDate,
				@netX = NetworkName
				FROM ASSET
				WHERE SerialNumber = CAST(@ser AS varchar(50))
				
				SET @exists = @@RowCount
				If @exists = 0 
				BEGIN
					--Add 
					INSERT INTO ASSET
					(
					ModelId,
					PlantAccountPrefix,
					PlantAccountNumber,
					NetworkName,
					SerialNumber,
					AcquisitionDate,
					Remarks,
					AssetDesc,
					EqpMgtBarCode,
					ProjectId,
					AssetTypeId,
					AssetSubtypeId,
					DepartmentId,
					AudienceId,
					LeasedPurchased,
					InventoryDate,
					InventoryBy,
					WarrantyMonths,
					UnitCost,
					MissionCritical,
					RemoteAccess,
					UpdateSourceSystemId,
					BuildingId,
					DeckId,
					Room,
					DispositionId,
					ManufacturerId
					)
					VALUES
					(
					1414,
					'00232M',
					@pa,
					@net,
					@ser,
					'7/27/2010',
					'2010 Acquisition ' + @net,
					@net,
					@ecn,
					47,
					1,
					1,
					30,
					30,
					1,
					@adate,
					1856,
					48,
					1515,
					1,
					1,
					30,
					@bldg,
					1,
					@rm,
					19,
					100
					)
					SELECT @id = SCOPE_IDENTITY();
					
					INSERT INTO ASSET_ASSIGNMENT
					(
						AssetId,
						AssignedTo,
						PrimaryUser
					)
					VALUES
					(
						@id,
						38,
						1
					)
						
				END
				ELSE
				BEGIN
				-- Perform separate updates for each 
				-- field
						--Network Name					
						IF DataLength(@net) > 0 AND DataLength(@netX) = 0
						BEGIN
							UPDATE ENet.dbo.ASSET
							SET NetworkName = @net
							WHERE SerialNumber = @ser;
							SET @uFlag = 1;
						END
						
						--Plant Account Number						
						IF (DataLength(@pa) > 0 AND DataLength(@paX) = 0)
							OR @pa <> @paX
						BEGIN
							UPDATE ENet.dbo.ASSET
							SET PlantAccountNumber = @pa
							WHERE SerialNumber = @ser;
							SET @uFlag = 1;
						END
						
						--ECN						
						IF (DataLength(@ecn) > 0 AND DataLength(@ecnX) = 0) 
							OR @ecn <> @ecnX
						BEGIN
							UPDATE ENet.dbo.ASSET
							SET EqpMgtBarCode = @ecn
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
			FETCH NEXT FROM cur INTO @pa,@mod, @ser, @ecn, @adate, @bas
		COMMIT	
		END
	END

	CLOSE cur
	DEALLOCATE cur

	SET @surow = 'Inventory Updated: ' + CAST(@urow AS varchar(50))
	SET @strow = 'Inventory Total: ' + CAST(@trow AS varchar(50))

	EXEC dbo.upLog @surow;
	EXEC dbo.upLog @strow;
	EXEC dbo.upLog 'End Inventory Updates';


END
