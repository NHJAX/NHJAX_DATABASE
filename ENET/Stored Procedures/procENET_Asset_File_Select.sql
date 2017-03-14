CREATE PROCEDURE [dbo].[procENET_Asset_File_Select]
(
	@rem	bit,
	@sft	int,
	@lic	int
)
 AS

IF @rem = 0
BEGIN
	IF @lic > 0
	BEGIN
		SELECT     
			AFL.AssetFileId, 
			AFL.AssetId, 
			AFL.AssetFileExtensionId, 
			AFL.AssetFileName, 
			AFL.AssetFilePath, 
			AFL.FileCreated, 
			AFL.FileWritten, 
			AFL.FileAccessed, 
			AFL.FileSize, 
			AFL.CreatedDate, 
			AFL.CreatedBy, 
			AFL.UpdatedDate, 
			AFL.UpdatedBy, 
			AFL.Removed, 
			AFL.SoftwareId, 
			AST.PlantAccountPrefix, 
			AST.PlantAccountNumber, 
			AST.SerialNumber, 
			AST.NetworkName, 
			SFT.SoftwareDesc, 
			TECH.UFName, 	
			TECH.ULName, 
			TECH.UMName, 
			AUD.DisplayName,
			AFL.SoftwareLicenseId,
			LIC.CDKey
		FROM   ASSET_FILE AS AFL 
			INNER JOIN ASSET AS AST 
			ON AFL.AssetId = AST.AssetId 
			INNER JOIN SOFTWARE_NAME AS SFT 
			ON AFL.SoftwareId = SFT.SoftwareId 
			INNER JOIN vwPointOfContact AS POC 
			ON AST.AssetId = POC.AssetId 
			INNER JOIN TECHNICIAN AS TECH 
			ON POC.POCid = TECH.UserId 
			INNER JOIN AUDIENCE AS AUD 
			ON AST.AudienceId = AUD.AudienceId
			LEFT JOIN SOFTWARE_LICENSE AS LIC
			ON AFL.SoftwareLicenseId = LIC.SoftwareLicenseId
		WHERE     AFL.SoftwareId = @sft
		AND AFL.Removed = 0
		AND AFL.SoftwareLicenseId = @lic
	END
	ELSE
	BEGIN
		SELECT     
			AFL.AssetFileId, 
			AFL.AssetId, 
			AFL.AssetFileExtensionId, 
			AFL.AssetFileName, 
			AFL.AssetFilePath, 
			AFL.FileCreated, 
			AFL.FileWritten, 
			AFL.FileAccessed, 
			AFL.FileSize, 
			AFL.CreatedDate, 
			AFL.CreatedBy, 
			AFL.UpdatedDate, 
			AFL.UpdatedBy, 
			AFL.Removed, 
			AFL.SoftwareId, 
			AST.PlantAccountPrefix, 
			AST.PlantAccountNumber, 
			AST.SerialNumber, 
			AST.NetworkName, 
			SFT.SoftwareDesc, 
			TECH.UFName, 	
			TECH.ULName, 
			TECH.UMName, 
			AUD.DisplayName,
			AFL.SoftwareLicenseId,
			LIC.CDKey
		FROM   ASSET_FILE AS AFL 
			INNER JOIN ASSET AS AST 
			ON AFL.AssetId = AST.AssetId 
			INNER JOIN SOFTWARE_NAME AS SFT 
			ON AFL.SoftwareId = SFT.SoftwareId 
			INNER JOIN vwPointOfContact AS POC 
			ON AST.AssetId = POC.AssetId 
			INNER JOIN TECHNICIAN AS TECH 
			ON POC.POCid = TECH.UserId 
			INNER JOIN AUDIENCE AS AUD 
			ON AST.AudienceId = AUD.AudienceId
			LEFT JOIN SOFTWARE_LICENSE AS LIC
			ON AFL.SoftwareLicenseId = LIC.SoftwareLicenseId
		WHERE     AFL.SoftwareId = @sft
		AND AFL.Removed = 0
	END
END
ELSE
BEGIN
IF @lic > 0
	BEGIN
		SELECT     
			AFL.AssetFileId, 
			AFL.AssetId, 
			AFL.AssetFileExtensionId, 
			AFL.AssetFileName, 
			AFL.AssetFilePath, 
			AFL.FileCreated, 
			AFL.FileWritten, 
			AFL.FileAccessed, 
			AFL.FileSize, 
			AFL.CreatedDate, 
			AFL.CreatedBy, 
			AFL.UpdatedDate, 
			AFL.UpdatedBy, 
			AFL.Removed, 
			AFL.SoftwareId, 
			AST.PlantAccountPrefix, 
			AST.PlantAccountNumber, 
			AST.SerialNumber, 
			AST.NetworkName, 
			SFT.SoftwareDesc, 
			TECH.UFName, 	
			TECH.ULName, 
			TECH.UMName, 
			AUD.DisplayName,
			AFL.SoftwareLicenseId,
			LIC.CDKey
		FROM   ASSET_FILE AS AFL 
			INNER JOIN ASSET AS AST 
			ON AFL.AssetId = AST.AssetId 
			INNER JOIN SOFTWARE_NAME AS SFT 
			ON AFL.SoftwareId = SFT.SoftwareId 
			INNER JOIN vwPointOfContact AS POC 
			ON AST.AssetId = POC.AssetId 
			INNER JOIN TECHNICIAN AS TECH 
			ON POC.POCid = TECH.UserId 
			INNER JOIN AUDIENCE AS AUD 
			ON AST.AudienceId = AUD.AudienceId
			LEFT JOIN SOFTWARE_LICENSE AS LIC
			ON AFL.SoftwareLicenseId = LIC.SoftwareLicenseId
		WHERE     AFL.SoftwareId = @sft
		AND	AFL.SoftwareLicenseId = @lic
	END
	ELSE
	BEGIN
		SELECT     
			AFL.AssetFileId, 
			AFL.AssetId, 
			AFL.AssetFileExtensionId, 
			AFL.AssetFileName, 
			AFL.AssetFilePath, 
			AFL.FileCreated, 
			AFL.FileWritten, 
			AFL.FileAccessed, 
			AFL.FileSize, 
			AFL.CreatedDate, 
			AFL.CreatedBy, 
			AFL.UpdatedDate, 
			AFL.UpdatedBy, 
			AFL.Removed, 
			AFL.SoftwareId, 
			AST.PlantAccountPrefix, 
			AST.PlantAccountNumber, 
			AST.SerialNumber, 
			AST.NetworkName, 
			SFT.SoftwareDesc, 
			TECH.UFName, 	
			TECH.ULName, 
			TECH.UMName, 
			AUD.DisplayName,
			AFL.SoftwareLicenseId,
			LIC.CDKey
		FROM   ASSET_FILE AS AFL 
			INNER JOIN ASSET AS AST 
			ON AFL.AssetId = AST.AssetId 
			INNER JOIN SOFTWARE_NAME AS SFT 
			ON AFL.SoftwareId = SFT.SoftwareId 
			INNER JOIN vwPointOfContact AS POC 
			ON AST.AssetId = POC.AssetId 
			INNER JOIN TECHNICIAN AS TECH 
			ON POC.POCid = TECH.UserId 
			INNER JOIN AUDIENCE AS AUD 
			ON AST.AudienceId = AUD.AudienceId
			LEFT JOIN SOFTWARE_LICENSE AS LIC
			ON AFL.SoftwareLicenseId = LIC.SoftwareLicenseId
		WHERE     AFL.SoftwareId = @sft
	END
END
