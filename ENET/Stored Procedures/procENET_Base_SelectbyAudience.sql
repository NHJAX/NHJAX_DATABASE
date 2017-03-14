CREATE PROCEDURE [dbo].[procENET_Base_SelectbyAudience]
(
	@aud bigint
)
 AS

SELECT 
	BASE.BaseId,
	BASE.BaseName,
	BASE.SortOrder,
	BASE.CreatedDate,
	BASE.CreatedBy,
	BASE.UpdatedDate,
	BASE.UpdatedBy,
	BASE.Inactive,
	BASE.BaseCode,
	BASE.ADCompany, 
	BASE.ADAddress1, 
	BASE.ADAddress2, 
	BASE.ADCity, 
	BASE.ADState, 
	BASE.ADZip, 
	BASE.ADCountry, 
	BASE.DirectoryEntry,
	BASE.ADDisplay,
	BASE.HomeDrive,
	BASE.HomeDirectory,
	BASE.MIDBuildingId,
	BASE.MIDRoom,
	BASE.MIDDeckId
FROM BASE
	INNER JOIN AUDIENCE AS AUD
	ON BASE.BaseId = AUD.BaseId
WHERE AUD.AudienceId = @aud

