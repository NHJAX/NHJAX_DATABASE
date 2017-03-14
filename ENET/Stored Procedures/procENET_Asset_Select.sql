CREATE PROCEDURE [dbo].[procENET_Asset_Select]
(
	@ast 		int = 0,
	@tech		int = 0,
	@all		int = 0,
	@sort		varchar(50) ='PlantNumber',
	@order		int = 0,
	@debug	bit = 0
)
 AS
DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000),
	@lk		int,
	@val		varchar(50)
	
SELECT @sql = 'SELECT     
	AST.AssetId, 
	MOD.ModelId, 
	MOD.ModelDesc, 
	MAN.ManufacturerId, 
	MAN.ManufacturerDesc, 
	AST.PlantAccountPrefix, 
	AST.PlantAccountNumber, 
	AST.NetworkName, 
	UPPER(AST.SerialNumber) AS SerialNumber, 
	AST.AcquisitionDate, 
	AST.MacAddress, 
	AST.Remarks, 
    AST.AssetDesc, 
	AST.WarrantyMonths, 
	AST.UnitCost, 
	AST.EqpMgtBarCode, 
	AST.ReqDocNumber, 
	PROJ.ProjectId, 
	PROJ.ProjectDesc, 
	TYPE.AssetTypeId, 
    TYPE.AssetTypeDesc, 
	STYPE.AssetSubTypeId, 
	STYPE.AssetSubTypeDesc, 
	AUD.AudienceId, 
	AUD.AudienceDesc, 
	AUD.OrgChartCode, 
    ISNULL(BASE.BaseId, 0) AS BaseId, 
	ISNULL(BASE.BaseName, ''UNKNOWN'') AS BaseName, 
	BLDG.BuildingId, 
	BLDG.BuildingDesc, 
	DECK.DeckId, 
	DECK.DeckDesc, 
	AST.Room, 
	AST.MissionCritical, 
	AST.RemoteAccess, 
	AST.OnLoan, 
	AST.LeasedPurchased, 
	DISP.DispositionId, 
	DISP.DispositionDesc, 
   	DOM.DomainId, 
	DOM.DomainName, 
	TECH.UserId AS POCId, 
	TECH.UFName AS POCFName, 
	TECH.ULName AS POCLName, 
	ISNULL(TECH.UMName, '''') AS POCMName, 
	TECH1.UserId AS CById, 
	TECH1.UFName AS CByFName, 
	TECH1.ULName AS CByLName, 
	ISNULL(TECH1.UMName, '''') AS CByMName, 
     	AST.CreatedDate, 
	TECH2.UserId AS UById, 
	TECH2.UFName AS UByFName, 
	TECH2.ULName AS UByLName, 
	ISNULL(TECH2.UMName, '''') AS UByMName, 
	AST.UpdatedDate, 
	AST.InventoryDate, 
	AST.PrinterConfig, 
	AST.SharePC, 
	ASSET_1.NetworkName AS SharePCDesc,
	AUD.DisplayName,
	TECH.UPhone AS POCPhone
FROM   MANUFACTURER MAN WITH (NOLOCK)
	INNER JOIN MODEL MOD WITH (NOLOCK)
	ON MAN.ManufacturerId = MOD.ManufacturerId 
	INNER JOIN DISPOSITION DISP WITH (NOLOCK)
	INNER JOIN DOMAIN DOM WITH (NOLOCK)
	INNER JOIN ASSET_TYPE TYPE WITH (NOLOCK)
	INNER JOIN ASSET AST WITH (NOLOCK)
	ON TYPE.AssetTypeId = AST.AssetTypeId 
	INNER JOIN ASSET_SUBTYPE STYPE WITH (NOLOCK)
	ON STYPE.AssetSubTypeId = AST.AssetSubtypeId 
	INNER JOIN TECHNICIAN TECH1 WITH (NOLOCK)
	ON AST.CreatedBy = TECH1.UserId 
	INNER JOIN TECHNICIAN TECH2 WITH (NOLOCK)
	ON AST.UpdatedBy = TECH2.UserId 
	INNER JOIN vwPointOfContact POC 
	ON AST.AssetId = POC.AssetId 
	INNER JOIN TECHNICIAN TECH WITH (NOLOCK)
	ON POC.POCid = TECH.UserId 
	LEFT OUTER JOIN ASSET ASSET_1 WITH (NOLOCK)
	ON AST.SharePC = ASSET_1.AssetId 
	ON DOM.DomainId = AST.DomainId 
	ON DISP.DispositionId = AST.DispositionId 
	INNER JOIN DECK WITH (NOLOCK)
	ON AST.DeckId = DECK.DeckId 
	INNER JOIN PROJECT PROJ WITH (NOLOCK)
	ON AST.ProjectId = PROJ.ProjectId 
	ON MOD.ModelId = AST.ModelId 
	INNER JOIN BASE WITH (NOLOCK)
	INNER JOIN BUILDING BLDG WITH (NOLOCK)
	ON BASE.BaseId = BLDG.BaseId 
	ON AST.BuildingId = BLDG.BuildingId 
	INNER JOIN AUDIENCE AUD WITH (NOLOCK)
	ON AST.AudienceId = AUD.AudienceId 
WHERE AST.AssetId > 0 
	AND DISP.ViewLevelId < 4 '

IF (SELECT COUNT(ManufacturerId) FROM sessINV_MANUFACTURER WITH (NOLOCK) WHERE CreatedBy = @tech) > 0
	SELECT @sql=@sql + 'AND MAN.ManufacturerId IN(SELECT ManufacturerId FROM sessINV_MANUFACTURER WHERE CreatedBy = @tech) '
IF (SELECT COUNT(ModelId) FROM sessINV_MODEL WITH (NOLOCK) WHERE CreatedBy = @tech) > 0
	SELECT @sql=@sql + 'AND MOD.ModelId IN(SELECT ModelId FROM sessINV_MODEL WHERE CreatedBy = @tech) '
IF (SELECT COUNT(ProjectId) FROM sessINV_PROJECT WITH (NOLOCK) WHERE CreatedBy = @tech) > 0
	SELECT @sql=@sql + 'AND PROJ.ProjectId IN(SELECT ProjectId FROM sessINV_PROJECT WHERE CreatedBy = @tech) '
IF (SELECT COUNT(AssetTypeId) FROM sessINV_ASSET_TYPE WITH (NOLOCK) WHERE CreatedBy = @tech) > 0
	SELECT @sql=@sql + 'AND TYPE.AssetTypeId IN(SELECT AssetTypeId FROM sessINV_ASSET_TYPE WHERE CreatedBy = @tech) '
IF (SELECT COUNT(AssetSubTypeId) FROM sessINV_ASSET_SUBTYPE WITH(NOLOCK) WHERE CreatedBy = @tech) > 0
	SELECT @sql=@sql + 'AND STYPE.AssetSubTypeId IN(SELECT AssetSubTypeId FROM sessINV_ASSET_SUBTYPE WHERE CreatedBy = @tech) '
IF (SELECT COUNT(DispositionId) FROM sessINV_DISPOSITION WITH (NOLOCK) WHERE CreatedBy = @tech) > 0
	SELECT @sql=@sql + 'AND DISP.DispositionId IN(SELECT DispositionId FROM sessINV_DISPOSITION WHERE CreatedBy = @tech) '
IF (SELECT COUNT(BaseId) FROM sessINV_BASE WITH (NOLOCK) WHERE CreatedBy = @tech) > 0
	SELECT @sql=@sql + 'AND BASE.BaseId IN(SELECT BaseId FROM sessINV_BASE WHERE CreatedBy = @tech) '
IF (SELECT COUNT(AudienceId) FROM sessINV_AUDIENCE WITH (NOLOCK) WHERE CreatedBy = @tech) > 0
	SELECT @sql=@sql + 'AND AUD.AudienceId IN(SELECT AudienceId FROM sessINV_AUDIENCE WHERE CreatedBy = @tech) '
IF (SELECT COUNT(POCId) FROM sessINV_POC WITH (NOLOCK) WHERE CreatedBy = @tech) > 0
	SELECT @sql=@sql + 'AND POC.POCId IN(SELECT POCId FROM sessINV_POC WHERE CreatedBy = @tech) '
IF @ast > 0
	SELECT @sql = @sql + 'AND AST.AssetId = @ast '

DECLARE curLk CURSOR FAST_FORWARD FOR
SELECT LookupId,LookupValue FROM sessINV_LOOKUP WHERE CreatedBy = @tech

OPEN curLk
FETCH NEXT FROM curLk INTO @lk,@val


IF(@@FETCH_STATUS = 0)
	BEGIN

		WHILE(@@FETCH_STATUS = 0)
		BEGIN
		SELECT @sql = 
			CASE @lk
				WHEN 1 THEN @sql + 'AND AST.PlantAccountPrefix LIKE ''%' + @val + '%'' '
				WHEN 2 THEN @sql + 'AND AST.PlantAccountNumber LIKE ''%' + @val + '%'' '
				WHEN 3 THEN @sql + 'AND AST.SerialNumber LIKE ''%' + @val + '%'' '
				WHEN 4 THEN @sql + 'AND AST.EqpMgtBarCode LIKE ''%' + @val + '%'' '
				WHEN 5 THEN @sql + 'AND AST.NetworkName LIKE ''%' + @val + '%'' '
				WHEN 6 THEN @sql + 'AND AST.MacAddress LIKE ''%' + @val + '%'' '
				WHEN 7 THEN @sql + 'AND AST.AcquisitionDate >= '' ' + @val + ' '' '
				WHEN 8 THEN	
					CASE @val 
						WHEN '0' THEN @sql + 'AND (((AST.NetworkName <> '''') 
							AND (AST.PlantAccountNumber <> '''') AND (AST.AssetTypeId = 8) )
							OR ((AST.NetworkName NOT LIKE ''\\%'') OR AST.NetworkName IS NULL)) '
						WHEN '1' THEN @sql + 'AND ((AST.AssetTypeId <> 8) 
							OR (AST.NetworkName LIKE ''\\%'')) '
						ELSE @sql + ' '
					END
				WHEN 9 THEN @sql + 'AND AST.AcquisitionDate <= '' ' + @val + ' '' '
				WHEN 10 THEN @sql + 'AND AST.UpdatedDate >= '' ' + @val + ' '' '
				WHEN 11 THEN @sql + 'AND AST.UpdatedDate <= '' ' + @val + ' '' '		
			END

		FETCH NEXT FROM curLk INTO @lk,@val
		END			
	END

CLOSE curLk
DEALLOCATE curLk

IF @all = 0
	SELECT @sql = @sql + 'AND DISP.ViewLevelId = 1 '
	
--Sorting
	SELECT @sql = @sql + 'ORDER BY '

IF @sort = 'PlantPrefix'
	SELECT @sql = @sql + 'AST.PlantAccountPrefix '

IF @sort = 'PlantNumber'
	SELECT @sql = @sql + 'AST.PlantAccountNumber '

IF @sort = 'NetworkName'
	SELECT @sql = @sql + 'AST.NetworkName '

IF @sort = 'ManufacturerDesc'
	SELECT @sql = @sql + 'MAN.ManufacturerDesc '

IF @sort = 'ModelDesc'
	SELECT @sql = @sql + 'MOD.ModelDesc '

IF @sort = 'SerialNumber'
	SELECT @sql = @sql + 'AST.SerialNumber '

IF @sort = 'AcquisitionDate'
	SELECT @sql = @sql + 'AST.AcquisitionDate '

IF @sort = 'AssetTypeDesc'
	SELECT @sql = @sql + 'TYPE.AssetTypeDesc '

IF @sort = 'AssetSubTypeDesc'
	SELECT @sql = @sql + 'STYPE.AssetSubTypeDesc '

IF @sort = 'DispositionDesc'
	SELECT @sql = @sql + 'DISP.DispositionDesc '

IF @sort = 'UpdatedDate'
	SELECT @sql = @sql + 'AST.UpdatedDate '

IF @order = 1 
	SELECT @sql = @sql + 'DESC '

/* second level sort order for plant prefix */
IF @sort = 'PlantPrefix' AND @order = 0
	SELECT @sql = @sql + ', AST.PlantAccountNumber '

IF @sort = 'PlantPrefix' AND @order = 1
	SELECT @sql = @sql + ', AST.PlantAccountNumber DESC '

IF @sort <> 'UpdatedDate'
	SELECT @sql = @sql + ', AST.UpdatedDate '

IF @debug = 1
	PRINT @sql
	PRINT @ast
	PRINT @all
	PRINT @tech
	PRINT @sort
	PRINT @order
	PRINT 'lk:'
	PRINT @lk

SELECT @paramlist = 	'@ast int,
			@tech int,
			@all int,
			@sort varchar(50),
			@order int '

EXEC sp_executesql	@sql, @paramlist, @ast, @tech, @all, @sort, @order


