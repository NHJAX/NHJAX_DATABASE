CREATE PROCEDURE [dbo].[upENet_SoftwareLicenseSelect](
	@inactive	bit = 0,
	@lic		int = 0,
	@sft		int = 0,
	@loc		int = 0,
	@vnd		int = 0,
	@debug	bit = 0
)
 AS
DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)
SELECT @sql = 'SELECT
			LIC.SoftwareLicenseId,
			LIC.SoftwareId,
			LIC.SoftwareLicenseDesc,
			LIC.Upgrade,
			LIC.PurchaseDate,
			LIC.Cost,
			LIC.NumberofDisks,
			LIC.SoftwareRegistration,
			LIC.CDKey,
			LIC.CreatedDate,
			LIC.CreatedBy,
			LIC.UpdatedDate,
			LIC.UpdatedBy,
			LIC.Inactive,
			LIC.SoftwareLocationId,
			LIC.OtherLocation,
			LIC.SoftwareVendorId,
			LIC.RequisitionNumber,
			LIC.PurchaseOrder,
			LIC.SoftwareVersion,
			LOC.SoftwareLocationDesc,
			VND.SoftwareVendorDesc,
			SFT.SoftwareDesc,
			LIC.NumberofUsers,
			LIC.ExpirationDate,
			ISNULL(SLD.Loaded,0) AS SoftwareLoaded
		FROM         
			SOFTWARE_LICENSE LIC
			INNER JOIN SOFTWARE_LOCATION LOC
			ON LOC.SoftwareLocationId = LIC.SoftwareLocationId
			INNER JOIN SOFTWARE_VENDOR VND
			ON VND.SoftwareVendorId = LIC.SoftwareVendorId
			INNER JOIN SOFTWARE_NAME SFT
			ON SFT.SoftwareId = LIC.SoftwareId
			LEFT OUTER JOIN vwAssetFile_SoftwareLoaded AS SLD
			ON SLD.SoftwareLicenseId = LIC.SoftwareLicenseId
		WHERE 
			1 = 1 '
IF @inactive = 0
	SELECT @sql = @sql + 'AND LIC.Inactive = 0 '
IF @sft > 0
	SELECT @sql = @sql + 'AND LIC.SoftwareId = @sft '
IF @lic > 0
	SELECT @sql = @sql + 'AND LIC.SoftwareLicenseId = @lic '
IF @loc > 0
	SELECT @sql = @sql + 'AND LIC.SoftwareLocationId = @loc '
IF @vnd > 0
	SELECT @sql = @sql + 'AND LIC.SoftwareVendorId = @vnd '
IF @debug = 1
	PRINT @sql
	PRINT @inactive
	PRINT @sft
SELECT @paramlist = 	'@inactive bit,
			@lic int,
			@sft int,
			@loc int,
			@vnd int '
			
EXEC sp_executesql	@sql, @paramlist, @inactive, @lic,@sft, @loc,@vnd

