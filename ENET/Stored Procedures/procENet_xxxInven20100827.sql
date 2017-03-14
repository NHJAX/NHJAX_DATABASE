
create PROCEDURE [dbo].[procENet_xxxInven20100827] 
AS
BEGIN
	Declare @pa varchar(255)
	Declare @mod int
	Declare @man int
	Declare @ser varchar(255)
	Declare @rm varchar(255)
	Declare @ecn varchar(255)
	Declare @bldg int	
	Declare @aud bigint
				
	Declare @paX varchar(255)
	Declare @modX int
	Declare @manX int
	Declare @serX varchar(255)
	Declare @rmX varchar(255)
	Declare @ecnX varchar(255)
	Declare @bldgX int
	Declare @audX bigint
			
	Declare @irow int	
	Declare @urow int
	Declare @trow int
	Declare @sirow varchar(50)
	Declare @surow varchar(50)
	Declare @strow varchar(50)
	Declare @exists int
	
	Declare @id int
	Declare @uFlag bit 
		
	EXEC dbo.upLog 'Begin Inventory Updates';

	DECLARE cur CURSOR FAST_FORWARD FOR
	SELECT
		PlantAccountNumber, 
		SerialNumber, 
		Room, 
		BuildingId,
		ECN,
		ModelId,
		AudienceId,
		ManufacturerId
	FROM xxxInven20100827
	WHERE SerialNumber IS NOT NULL
	
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

	FETCH NEXT FROM cur INTO @pa, @rm,@ser,@bldg, @ecn, @mod,@aud,@man

	if(@@FETCH_STATUS = 0)

	BEGIN

		WHILE(@@FETCH_STATUS = 0)
		BEGIN
		BEGIN TRANSACTION 
			--IF @bas = 1
			--BEGIN
			--	SET @net = 'NHJAX-3CH' + CAST(@pa AS varchar(5))
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
				@rmX = Room,
				@bldgX = BuildingId, 
				@modX = ModelId,
				@manX = ManufacturerId,
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
					SerialNumber,
					EqpMgtBarCode,
					AssetTypeId,
					AssetSubtypeId,
					AudienceId,
					LeasedPurchased,
					InventoryBy,
					UpdateSourceSystemId,
					BuildingId,
					Room,
					ManufacturerId
					)
					VALUES
					(
					@mod,
					'00232M',
					@pa,
					@ser,
					@ecn,
					8,
					50,
					@aud,
					1,
					1202,
					30,
					@bldg,
					@rm,
					@man
					)
					SELECT @id = SCOPE_IDENTITY();
					
					SET @irow = @irow + 1
					
					--INSERT INTO ASSET_ASSIGNMENT
					--(
					--	AssetId,
					--	AssignedTo,
					--	PrimaryUser
					--)
					--VALUES
					--(
					--	@id,
					--	38,
					--	1
					--)
						
				END
				ELSE
				BEGIN
				-- Perform separate updates for each 
				-- field
						--Network Name					
						--IF DataLength(@net) > 0 AND DataLength(@netX) = 0
						--BEGIN
						--	UPDATE ENet.dbo.ASSET
						--	SET NetworkName = @net
						--	WHERE SerialNumber = @ser;
						--	SET @uFlag = 1;
						--END
						
						--Plant Account Number						
						IF (DataLength(@pa) > 0 AND DataLength(@paX) = 0)
						BEGIN
							UPDATE ENet.dbo.ASSET
							SET PlantAccountNumber = @pa
							WHERE SerialNumber = @ser;
							SET @uFlag = 1;
						END
						
						--ECN						
						IF (DataLength(@ecn) > 0 AND DataLength(@ecnX) = 0) 
						BEGIN
							UPDATE ENet.dbo.ASSET
							SET EqpMgtBarCode = @ecn
							WHERE SerialNumber = @ser;
							SET @uFlag = 1;
						END
						
						--Model						
						IF @mod > 0 AND @modX = 1 
						BEGIN
							UPDATE ENet.dbo.ASSET
							SET ModelId = @mod
							WHERE SerialNumber = @ser;
							SET @uFlag = 1;
						END
						
						--Manu						
						IF @man > 0 AND @manX = 324
						BEGIN
							UPDATE ENet.dbo.ASSET
							SET ManufacturerId = @man
							WHERE SerialNumber = @ser;
							SET @uFlag = 1;
						END
						
						--Aud						
						IF @aud > 0 AND @audX = 0 
						BEGIN
							UPDATE ENet.dbo.ASSET
							SET AudienceId = @aud
							WHERE SerialNumber = @ser;
							SET @uFlag = 1;
						END
						
						--Bldg						
						IF @bldg > 0 AND @bldgX = 5 
						BEGIN
							UPDATE ENet.dbo.ASSET
							SET BuildingId = @mod
							WHERE SerialNumber = @ser;
							SET @uFlag = 1;
						END
						
						--Room						
						IF (DataLength(@rm) > 0 AND DataLength(@rmX) = 0) 
						BEGIN
							UPDATE ENet.dbo.ASSET
							SET Room = @rm
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
			FETCH NEXT FROM cur INTO @pa, @rm,@ser,@bldg, @ecn, @mod,@aud,@man
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
