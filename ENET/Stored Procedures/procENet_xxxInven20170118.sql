
create PROCEDURE [dbo].[procENet_xxxInven20170118] 
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
	DECLARE @rm nvarchar(255)
	DECLARE @dept nvarchar(255)
	DECLARE @aud bigint
	DECLARE @sub nvarchar(255)
	DECLARE @isub int
	DECLARE @imod int
	DECLARE @cost money
	--DECLARE @bldg nvarchar(255)
		
	Declare @paX nvarchar(255)
	Declare @modX nvarchar(255)
	Declare @serX nvarchar(255)
	Declare @ecnX nvarchar(255)
	Declare @ibyX int
	Declare @adateX datetime
	Declare @basX int
	Declare @netX varchar(100)
	Declare @rmX varchar(50)
	Declare @audX bigint
	DECLARE @isubX int
	DECLARE @imodX int
	DECLARE @costX money
		
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
		[PLANT NUMBER], 
		[SERIAL NUMBER], 
		[ECN], 
		'NHJAX-' + (CAST([PLANT NUMBER] as varchar(255))),
		[ROOM],
		CASE ISNULL([DEPARTMENT],0)
			WHEN 'AVI MED' THEN 158
			WHEN 'CASE MGMT' THEN 170
			WHEN 'FAMILY MEDICINE' THEN 82
			WHEN 'IMMUNIZATIONS' THEN 319
			WHEN 'MENTAL HEALTH' THEN 87
			WHEN 'OIC' THEN 254
			WHEN 'OPTOMETRY' THEN 284
			WHEN 'PREVENTATIVE MEDICINE' THEN 161
			WHEN 'REC MAN' THEN 62
			WHEN 'REC MGMT' THEN 62
			WHEN 'MID' THEN 30
			ELSE 0
		END,
		[SUB TYPE],
		MODEL,
		[UNIT COST],
		CASE BUILDING
			WHEN '2090' THEN 18
			WHEN '2091' THEN 19
		END 
	FROM xxx20170118Inventory
	WHERE [Plant Number] IS NOT NULL
	AND [SERIAL Number] IS NOT NULL
	
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

	FETCH NEXT FROM cur INTO @pa, @ser, @ecn, @net, @rm, @aud,@sub,@mod,@cost,@bldg

	if(@@FETCH_STATUS = 0)

	BEGIN

		WHILE(@@FETCH_STATUS = 0)
		BEGIN
		BEGIN TRANSACTION 

				PRINT @pa
				PRINT @ser
				PRINT @ecn
				PRINT @net
				PRINT @rm
				PRINT @aud
				PRINT @sub
				PRINT @mod
				PRINT @cost

			IF @sub = 'SERVER'
				BEGIN
					SET @isub = 2
				END
				ELSE
				BEGIN
					SET @isub = 1
				END
			IF @mod = 'OPTIPLEX 9020 (T)'
				BEGIN
					SET @imod = 1601
				END
			IF @mod = 'OPTIPLEX 9020 (S/F)'
				BEGIN
					SET @imod = 1566
				END
			IF @mod = 'POWEREDGE R730'
				BEGIN
					SET @imod = 1598
				END
			IF @mod = 'PowerVault MD3820f'
				BEGIN
					SET @imod = 1599
				END
			IF @mod = 'OptiPlex 3020'
				BEGIN
					SET @imod = 1602
				END

			IF @mod = 'OptiPlex 3020 (S/F)'
				BEGIN
					SET @imod = 1602
				END

			IF @mod = 'DELL OptiPlex 3020 (S/F)'
				BEGIN
					SET @imod = 1602
				END
			IF @mod = 'DELL Latitude E5470'
				BEGIN
					SET @imod = 1615
				END
			
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

			SELECT @serX = SerialNumber,
				@paX = PlantAccountNumber,
				@ecnX = EqpMgtBarCode,
				@netX = NetworkName,
				@rmX = Room,
				@audX = AudienceId
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
					@imod,  --Model (1563 Wyse P25, 1533 LATITUDE XT3)
					'00232M',
					@pa,
					@net,
					@ser,
					'01/18/2017',  --Acq Date
					'2017 Acquisition ' + @net,
					@net,
					@ecn,
					34,  --Project (34 Lifecycle, 68 CDP)
					1,  -- Asset Type
					@isub,  --Asset Subtype --84 CDP
					30,  --AudienceId
					0,  --Leased
					'01/18/2017',  --Inventory Date
					9478,  --Inventory By (9478 Carlos, 1612 Tony)
					48,  --Warr Months
					@cost,  --Unit Cost
					1,  --Mission Critical
					1,  --Remote Access
					30,  --Upd Source
					19,  --Bldg (19 2091, 1 964, 18 2090, @bldg) 
					1, --Deck
					@rm,  --Room
					19,   --Disposition (19 techshop, 1 active)
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
				--ELSE
				--BEGIN
				---- Perform separate updates for each 
				---- field
				--		--Network Name					
				--		IF DataLength(@net) > 0 AND DataLength(@netX) = 0
				--		BEGIN
				--			UPDATE ENet.dbo.ASSET
				--			SET NetworkName = @net
				--			WHERE SerialNumber = @ser;
				--			SET @uFlag = 1;
				--		END
						
				--		--Plant Account Number						
				--		IF (DataLength(@pa) > 0 AND DataLength(@paX) = 0)
				--			OR @pa <> @paX
				--		BEGIN
				--			UPDATE ENet.dbo.ASSET
				--			SET PlantAccountNumber = @pa
				--			WHERE SerialNumber = @ser;
				--			SET @uFlag = 1;
				--		END
						
				--		--ECN						
				--		IF (DataLength(@ecn) > 0 AND DataLength(@ecnX) = 0) 
				--			OR @ecn <> @ecnX
				--		BEGIN
				--			UPDATE ENet.dbo.ASSET
				--			SET EqpMgtBarCode = @ecn
				--			WHERE SerialNumber = @ser;
				--			SET @uFlag = 1;
				--		END

				--		IF @rm <> @rmX AND DataLength(@rm) > 0
				--		BEGIN
				--			UPDATE ENet.dbo.ASSET
				--			SET Room = @rm
				--			WHERE SerialNumber = @ser;
				--			SET @uFlag = 1;
				--		END

				--		IF @aud <> @audX AND @aud > 0
				--		BEGIN
				--			UPDATE Enet.dbo.ASSET
				--			SET AudienceId = @aud
				--			WHERE SerialNumber = @ser;
				--			SET @uFlag = 1;
				--		END
						
				--		--Add to count if anything updated
				--		If @uFlag = 1
				--		BEGIN
				--			SET @urow = @urow + 1
				--		END
					
				--END

				

			SET @trow = @trow + 1
			FETCH NEXT FROM cur INTO @pa, @ser, @ecn, @net, @rm, @aud,@sub,@mod,@cost,@bldg
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