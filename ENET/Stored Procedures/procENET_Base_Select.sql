CREATE PROCEDURE [dbo].[procENET_Base_Select]
(
	@bas int
)
 AS

SELECT 
	BaseId,
	BaseName,
	SortOrder,
	CreatedDate,
	CreatedBy,
	UpdatedDate,
	UpdatedBy,
	Inactive,
	BaseCode,
	ADCompany, 
	ADAddress1, 
	ADAddress2, 
	ADCity, 
	ADState, 
	ADZip, 
	ADCountry, 
	DirectoryEntry,
	ADDisplay,
	HomeDrive,
	HomeDirectory,
	MIDBuildingId,
	MIDRoom,
	MIDDeckId
FROM BASE
WHERE BaseId = @bas

