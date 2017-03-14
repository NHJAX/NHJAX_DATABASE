
CREATE PROCEDURE [dbo].[procENet_xxxInven20141211_MYPT] 
AS
BEGIN
	Declare @pa nvarchar(255)
	Declare @mod nvarchar(255)
	Declare @ser nvarchar(255)
	Declare @ecn nvarchar(255)
	Declare @iby int
	Declare @adate datetime
	Declare @bas int
	DECLARE @net nvarchar(255)
	Declare @rm nvarchar(255)
		
	Declare @paX varchar(50)
	Declare @modX nvarchar(255)
	Declare @serX nvarchar(255)
	Declare @ecnX nvarchar(255)
	Declare @ibyX int
	Declare @adateX datetime
	Declare @basX int
	Declare @netX varchar(100)
	Declare @rmX varchar(50)
	Declare @astX int
		
	Declare @irow int	
	Declare @urow int
	Declare @trow int
	Declare @sirow varchar(50)
	Declare @surow varchar(50)
	Declare @strow varchar(50)
	Declare @exists int
	Declare @bldg int
	--Declare @rm varchar(50)
	Declare @id int
	Declare @uFlag bit 
		
	EXEC dbo.upLog 'Begin Inventory Updates';

	DECLARE cur CURSOR FAST_FORWARD FOR
	SELECT
		[PA Number], 
		[Room], 
		'NHJAX-' + [PA Number]
	FROM xxx20141211Inventory_MYPT
	WHERE [PA Number] IS NOT NULL
	
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
	SET @irow = 0
	EXEC dbo.upLog 'Fetch Inventory Updates'

	FETCH NEXT FROM cur INTO @pa, @net, @rm

	if(@@FETCH_STATUS = 0)

	BEGIN

		WHILE(@@FETCH_STATUS = 0)
		BEGIN
		BEGIN TRANSACTION 
			--IF @bas = 1
			--BEGIN
			--	SET @net = 'NHJAX-' + CAST(@pa AS varchar(5))
			--	SET @bldg = 18
			--	SET @rm = '111'
			--END
			--IF @bas = 3
			--BEGIN
			--	SET @net = 'NHJAX-3ALB' + CAST(@pa AS varchar(5))
			--	SET @bldg = 4
			--	SET @rm = 'I-65'
			--END
			--IF @bas = 6
			--BEGIN
			--	SET @net = 'NHJAX-KW' + CAST(@pa AS varchar(5))
			--	SET @bldg = 9
			--	SET @rm = 'MID'
			--END 

			SELECT @rmX = Room,
				@paX = PlantAccountNumber,
				@ecnX = EqpMgtBarCode,
				@netX = NetworkName,
				@serX = SerialNumber,
				@astX = AssetId
				FROM ASSET
				WHERE PlantAccountNumber = @pa
				and DispositionId in (0,1,14,15,20,21,25)
				
				SET @exists = @@RowCount
				If @exists = 0 
				BEGIN
					--Add 
					INSERT INTO ASSET
					(
					--ModelId,
					PlantAccountPrefix,
					PlantAccountNumber,
					NetworkName,
					
					--AcquisitionDate,
					Remarks,
					AssetDesc,
					EqpMgtBarCode,
					ProjectId,
					AssetTypeId,
					--AssetSubtypeId,
					AudienceId,
					LeasedPurchased,
					InventoryDate,
					InventoryBy,
					--WarrantyMonths,
					--UnitCost,
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
					--1563,  --Model (1563 Wyse P25, 1533 LATITUDE XT3)
					'00232M',
					@pa,
					@net,
					
					--'10/10/2014',  --Acq Date
					'2014 Acquisition ' + @net,
					@net,
					@ecn,
					34,  --Project (34 Lifecycle, 68 CDP)
					1,  -- Asset Type
					--84,  --Asset Subtype
					30,  --AudienceId
					1,  --Leased
					'12/11/2014',  --Inventory Date
					1343,  --Inventory By (9478 Carlos, 1612 Tony, 1343 Mark)
					--60,  --Warr Months
					--295.26,  --Unit Cost
					1,  --Mission Critical
					1,  --Remote Access
					30,  --Upd Source
					45,  --Bldg (19 MID, 45 MYPT Clinic)
					2, --Deck
					@rm, --@rm,  --Room 'MID Cage'
					19,   --Disposition (19 tech shop)
					100  --Manufacturer
					)
					SELECT @id = SCOPE_IDENTITY();
					
					SET @irow = @irow + 1
					
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
						----Network Name					
						--IF DataLength(@net) > 0 AND DataLength(@netX) = 0
						--BEGIN
						--	UPDATE ENet.dbo.ASSET
						--	SET NetworkName = @net
						--	WHERE PlantAccountNumber = @pa;
						--	SET @uFlag = 1;
						--END
						
						----Plant Account Number						
						--IF (DataLength(@pa) > 0 AND DataLength(@paX) = 0)
						--	--OR @pa <> @paX
						--BEGIN
						--	UPDATE ENet.dbo.ASSET
						--	SET PlantAccountNumber = @pa
						--	WHERE PlantAccountNumber = @pa;
						--	SET @uFlag = 1;
						--END
						
						----ECN						
						--IF (DataLength(@ecn) > 0 AND DataLength(@ecnX) = 0) 
						--	OR @ecn <> @ecnX
						--BEGIN
						--	UPDATE ENet.dbo.ASSET
						--	SET EqpMgtBarCode = @ecn
						--	WHERE PlantAccountNumber = @pa;
						--	SET @uFlag = 1;
						--END

						----Serial
						--IF (@ser <> @serX)
						--BEGIN
						--	UPDATE ENet.dbo.ASSET
						--	SET SerialNumber = @ser
						--	WHERE PlantAccountNumber = @pa
						--	SET @uFlag  = 1
						--END

						--Room
						IF (@rm <> @rmX)
						BEGIN
							UPDATE Enet.dbo.ASSET
							SET Room = @rm
							WHERE PlantAccountNumber = @pa
							
						END
						
						UPDATE ASSET
						SET DispositionId = 19,
						BuildingId = 45,
						DeckId = 2
						WHERE PlantAccountNumber = @pa

						UPDATE ASSET_ASSIGNMENT
						SET PrimaryUser = 38
						WHERE AssetId = @astX

						SET @uFlag = 1

						--Add to count if anything updated
						If @uFlag = 1
						BEGIN
							SET @urow = @urow + 1
						END
					
				END
			SET @trow = @trow + 1
			FETCH NEXT FROM cur INTO @pa, @net, @rm
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