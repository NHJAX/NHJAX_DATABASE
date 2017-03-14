
create PROCEDURE [dbo].[procENet_xxxInven20110121_KeyWest] 
AS
BEGIN
	
	Declare @pa nvarchar(255)
	Declare @sstyp nvarchar(255)
	Declare @ser nvarchar(255)
	Declare @net nvarchar(255)
	Declare @spoc nvarchar(255)
	Declare @saud nvarchar(255)
	Declare @rm nvarchar(255)	
	Declare @sman nvarchar(255)
	Declare @smod nvarchar(255)
	Declare @sdisp nvarchar(255)
	Declare @adate datetime
	Declare @cost float
	Declare @ecn nvarchar(255)
	Declare @sdeck nvarchar(255)
	
	Declare @iby int
	Declare @bas int
	Declare @styp int 
	Declare @poc int 
	Declare @aud bigint 
	Declare @man int 
	Declare @mod int 
	Declare @disp int 
	Declare @deck int 
	
	Declare @paX varchar(50)
	Declare @stypX int
	Declare @serX varchar(50)
	Declare @netX varchar(100)
	Declare @pocX int
	Declare @audX bigint
	Declare @rmX varchar(50)	
	Declare @manX int
	Declare @modX int
	Declare @dispX int
	Declare @adateX datetime
	Declare @costX float
	Declare @ecnX varchar(15)
	Declare @deckX int
	Declare @basX int
	Declare @astX int
	
	Declare @irow int
	Declare @urow int
	Declare @trow int
	Declare @sirow varchar(50)
	Declare @surow varchar(50)
	Declare @strow varchar(50)
	Declare @exists int
	Declare @bldg int
	
	Declare @id int
	Declare @uFlag bit 
		
	EXEC dbo.upLog 'Begin Inventory Updates';
	
	SET @bldg = 9
	SET @styp = 0
	SET @poc = 7232
	SET @aud = 0
	SET @man = 324
	SET @mod = 1
	SET @disp = 0
	SET @deck = 0
	SET @iby = 7232
	
	DECLARE cur CURSOR FAST_FORWARD FOR
	SELECT
		[Plant Number], 
		ISNULL([Sub Type],'N/A'),
		ISNULL([SERIAL Number],''),
		[Network Name],
		[Point of Contact],
		Department,
		Deck,
		Room,
		Manufacturer,
		Model, 
		Disposition,
		[Acq Date],
		[Unit Cost],
		ISNULL([Equip Bar Code],''), 
		6 AS BaseId
	FROM xxxInventory20110121_KeyWest
	WHERE [Plant Number] IS NOT NULL
	
	OPEN cur
	SET @uFlag = 0
	SET @irow = 0
	SET @trow = 0
	SET @urow = 0
	EXEC dbo.upLog 'Fetch Inventory Updates'

	FETCH NEXT FROM cur INTO @pa,@sstyp,@ser,@net,@spoc,@saud,@sdeck,@rm,@sman,@smod,
		@sdisp,@adate,@cost,@ecn,@bas

	if(@@FETCH_STATUS = 0)

	BEGIN

		WHILE(@@FETCH_STATUS = 0)
		BEGIN
		BEGIN TRANSACTION 
						
			--Lookup variables
			SELECT @styp = AssetSubTypeId
				FROM ASSET_SUBTYPE
				WHERE AssetSubTypeDesc = @sstyp
				
			SELECT @aud = AudienceId
				FROM AUDIENCE
				WHERE DisplayName = LEFT(@saud,(CHARINDEX('(',@saud))-1)
			
			SELECT @deck = DeckId
				FROM DECK
				WHERE DeckDesc = @sdeck
			
			SELECT @man = ManufacturerId
				FROM MANUFACTURER
				WHERE ManufacturerDesc = @sman
				AND Inactive = 0
				
			SELECT @mod = ModelId
				FROM MODEL
				WHERE ModelDesc = @smod
				AND Inactive = 0		
			
			SELECT @poc = UserId 
				FROM TECHNICIAN
				WHERE ULName + ', ' + UFName + ' ' + UMName = LEFT(@spoc, LEN(@spoc) - 12)
				AND LEN(@spoc) > 12

			SELECT 
				@astX = AssetId,
				@paX = PlantAccountNumber,
				@stypX = AssetSubTypeId,
				@serX = SerialNumber,
				@netX = NetworkName,
				@audX = AudienceId,
				@deckX = DeckId,
				@rmX = Room,
				@manX = ManufacturerId,
				@modX = ModelId,
				@dispX = DispositionId,
				@adateX = AcquisitionDate,
				@costX = UnitCost,
				@ecnX = EqpMgtBarCode
				FROM ASSET
				WHERE PlantAccountNumber = CAST(@pa AS varchar(50))
				
			SELECT
				@pocX = AssignedTo
				FROM ASSET_ASSIGNMENT
				WHERE AssetId = @astX
				AND AssignedTo = @poc
				
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
					@mod,
					'00232M',
					@pa,
					@net,
					@ser,
					@adate,
					'2011 Acquisition ' + @net,
					@net,
					@ecn,
					47,
					1,
					@styp,
					30,
					@aud,
					1,
					@adate,
					@iby,
					48,
					@cost,
					1,
					1,
					30,
					@bldg,
					@deck,
					@rm,
					@disp,
					@man
					)
					SELECT @id = SCOPE_IDENTITY();
					
					SET @irow = @irow + 1;
					
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
				
						--Asset Subtype					
						IF @styp <> 0 AND @stypX = 0 OR
							(@stypX <> 0 AND @stypX <> @styp)
						BEGIN
							UPDATE ENet.dbo.ASSET
							SET AssetSubTypeId = @styp
							WHERE PlantAccountNumber = @pa;
							SET @uFlag = 1;
						END
				
						--Network Name					
						IF DataLength(@net) > 0 AND DataLength(@netX) = 0
							OR (DataLength(@netX) > 0 AND @netX <> @net)
						BEGIN
							UPDATE ENet.dbo.ASSET
							SET NetworkName = @net
							WHERE PlantAccountNumber = @pa;
							SET @uFlag = 1;
						END
						
						--Serial Number
						IF (DataLength(@ser) > 0 AND DataLength(@serX) = 0)
							OR (DataLength(@serX) > 0 AND @serX <> @ser)
						BEGIN
							UPDATE ENet.dbo.ASSET
							SET SerialNumber = @ser
							WHERE PlantAccountNumber = @pa;
							SET @uFlag = 1;
						END	
						
						--Audience				
						IF @aud <> 0 AND @audX = 0 OR
							(@audX <> 0 AND @audX <> @aud)
						BEGIN
							UPDATE ENet.dbo.ASSET
							SET AudienceId = @aud
							WHERE PlantAccountNumber = @pa;
							SET @uFlag = 1;
						END
						
						--Deck				
						IF @deck <> 0 AND @deckX = 0 OR
							(@deckX <> 0 AND @deckX <> @deck)
						BEGIN
							UPDATE ENet.dbo.ASSET
							SET DeckId = @deck
							WHERE PlantAccountNumber = @pa;
							SET @uFlag = 1;
						END
						
						--ROOM
						IF (DataLength(@rm) > 0 AND DataLength(@rmX) = 0)
							OR (DataLength(@rmX) > 0 AND @rmX <> @rm)
						BEGIN
							UPDATE ENet.dbo.ASSET
							SET Room = @rm,
							UpdatedBy = 7232,
							UpdatedDate = getdate()
							WHERE SerialNumber = @ser;
							SET @uFlag = 1;
						END
						
						--Manufacturer				
						IF @man <> 324 AND @manX = 324 OR
							(@manX <> 324 AND @manX <> @man)
						BEGIN
							UPDATE ENet.dbo.ASSET
							SET ManufacturerId = @man
							WHERE PlantAccountNumber = @pa;
							SET @uFlag = 1;
						END
						
						--Model					
						IF @mod <> 1 AND @modX = 1 OR
							(@modX <> 1 AND @modX <> @mod)
						BEGIN
							UPDATE ENet.dbo.ASSET
							SET ModelId = @mod
							WHERE PlantAccountNumber = @pa;
							SET @uFlag = 1;
						END
						
						--Disposition				
						IF @disp <> 0 AND @dispX = 0 OR
							(@dispX <> 0 AND @dispX <> @disp)
						BEGIN
							UPDATE ENet.dbo.ASSET
							SET DispositionId = @disp
							WHERE PlantAccountNumber = @pa;
							SET @uFlag = 1;
						END
						
						--Acq Date				
						IF @adate > '1/1/1900' AND @adateX < '1/1/1901' OR
							(@adateX > '1/1/1900' AND @adateX <> @adate)
						BEGIN
							UPDATE ENet.dbo.ASSET
							SET AcquisitionDate = @adate
							WHERE PlantAccountNumber = @pa;
							SET @uFlag = 1;
						END
						
						--cost					
						IF @cost <> 0 AND @costX = 0 OR
							(@costX <> 0 AND @costX <> @cost)
						BEGIN
							UPDATE ENet.dbo.ASSET
							SET UnitCost = @cost
							WHERE PlantAccountNumber = @pa;
							SET @uFlag = 1;
						END
											
						--ECN			
						IF DataLength(@ecn) > 0 AND DataLength(@ecnX) = 0
							OR (DataLength(@ecnX) > 0 AND @ecnX <> @ecn)
						BEGIN
							UPDATE ENet.dbo.ASSET
							SET EqpMgtBarCode = @ecn
							WHERE SerialNumber = @ser;
							SET @uFlag = 1;
						END
						
						--Bldg				
						IF @bldg <> 9 
						BEGIN
							UPDATE ENet.dbo.ASSET
							SET BuildingId = @bldg
							WHERE PlantAccountNumber = @pa;
							SET @uFlag = 1;
						END
						
						--Add to count if anything updated
						If @uFlag = 1
						BEGIN
							SET @urow = @urow + 1
						END
						
						--POC set above.
						IF @poc <> @pocX
						BEGIN
						UPDATE ENET.dbo.ASSET_ASSIGNMENT
						SET AssignedTo = @poc,
						PrimaryUser = 1
						WHERE AssetId = @astX
						END
					
				END
			SET @trow = @trow + 1
			FETCH NEXT FROM cur INTO @pa,@sstyp,@ser,@net,@spoc,@saud,
				@sdeck,@rm,@sman,@smod,
				@sdisp,@adate,@cost,@ecn,@bas
		COMMIT	
		END
	END

	CLOSE cur
	DEALLOCATE cur

	SET @sirow = 'Inventory Inserted: ' + CAST(@irow AS varchar(50))
	SET @surow = 'Inventory Updated: ' + CAST(@urow AS varchar(50))
	SET @strow = 'Inventory Total: ' + CAST(@trow AS varchar(50))

	EXEC dbo.upLog @sirow;
	EXEC dbo.upLog @surow;
	EXEC dbo.upLog @strow;
	EXEC dbo.upLog 'End Inventory Updates';


END
