CREATE PROCEDURE [dbo].[procENET_Asset_Assignment_SelectPrimary]
(
	@ast int	
)
 AS

SELECT 
    TECH.UserId, 
    TECH.UFName, 
    TECH.ULName, 
    TECH.UMName, 
    AUD.DisplayName, 
    AUD.OrgChartCode, 
    TECH.UPhone, 
    TECH.Extension 
    FROM TECHNICIAN TECH 
    INNER JOIN ASSET_ASSIGNMENT ASG 
    ON TECH.UserId = ASG.AssignedTo 
    INNER JOIN vwAssignedAssets VW 
    ON ASG.AssetId = VW.AssetId 
    INNER JOIN AUDIENCE AUD 
    ON TECH.AudienceId = AUD.AudienceId 
    WHERE ASG.AssetId = @ast 
    AND ASG.PrimaryUser = 1
