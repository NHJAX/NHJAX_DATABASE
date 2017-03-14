
create PROCEDURE [dbo].[procENet_xxxInven20140915_MYPT] 
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
		
	Declare @paX nvarchar(255)
	Declare @modX nvarchar(255)
	Declare @serX nvarchar(255)
	Declare @ecnX nvarchar(255)
	Declare @ibyX int
	Declare @adateX datetime
	Declare @basX int
	Declare @netX varchar(100)
		
	Declare @irow int	
	Declare @urow int
	Declare @trow int
	Declare @sirow varchar(50)
	Declare @surow varchar(50)
	Declare @strow varchar(50)
	Declare @exists int
	Declare @bldg int
	Declare @rm varchar(50)
	Declare @id int
	Declare @uFlag bit 
		
	EXEC dbo.upLog 'Begin Inventory Updates';

	DECLARE cur CURSOR FAST_FORWARD FOR
	SELECT
		[PAN], 
		[S/N], 
		[ECN]
	FROM xxx20140915Inventory_MYPT
	WHERE [PAN] IS NOT NULL
	AND [S/N] IS NOT NULL
	
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

	FETCH NEXT FROM cur INTO @pa, @ser, @ecn

	if(@@FETCH_STATUS = 0)

	BEGIN

		WHILE(@@FETCH_STATUS = 0)
		BEGIN
		BEGIN TRANSACTION 
		
			SET @net = 'NHJAX-' + @pa
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
				@netX = NetworkName
				FROM ASSET
				WHERE SerialNumber = CAST(@ser AS varchar(50))
				
				SET @exists = @@RowCount
				If @exists = 0 
				BEGIN
					--Add 
					INSERT INTO ASSET
					(
					ModelId, --0
					PlantAccountPrefix, --1
					PlantAccountNumber, --2
					NetworkName, --3
					SerialNumber, --4
					AcquisitionDate, --5
					Remarks, --6
					AssetDesc, --7
					EqpMgtBarCode, --8
					ProjectId, --9
					AssetTypeId, --10
					AssetSubtypeId, --11
					DepartmentId, --12
					AudienceId, --13
					LeasedPurchased, --14
					InventoryDate,  --15
					InventoryBy, --16
					WarrantyMonths, --17
					UnitCost, --18
					MissionCritical, --19
					RemoteAccess, --20
					UpdateSourceSystemId, --21
					BuildingId, --22
					DeckId, --23
					Room, --24
					DispositionId, --25
					ManufacturerId --26
					)
					VALUES
					(
					1563, --0
					'00232M', --1
					@pa, --2
					@net, --3
					@ser, --4
					'09/15/2014', --5
					'2014 Acquisition - MYPT' + @net, --6
					@net, --7
					@ecn, --8
					34, --9
					1, --10
					84, --11
					30, --12
					30, --13
					1, --14
					'9/15/2014', --15
					9478, --16
					60, --17
					295.26, --18
					1, --19
					1, --20
					30, --21
					45, --22
					2, --23
					'2031', --24
					19, --25
					100 --26
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
			FETCH NEXT FROM cur INTO @pa, @ser, @ecn
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