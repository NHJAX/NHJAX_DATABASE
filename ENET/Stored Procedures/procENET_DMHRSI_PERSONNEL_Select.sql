create PROCEDURE [dbo].[procENET_DMHRSI_PERSONNEL_Select]
(
	@usr int
)
AS

SELECT 
	[Command Name], 
	Directorate, 
	[Department Work Space], 
	Title, [Last Name], 
	[First Name], 
	[Middle Names], 
	[Emp No], 
	DOD_Area, 
	UIC, 
	Type_Personnel, 
	Mil_CIV, 
    [Status], 
    Officia_Position_Name, 
    [Email Address], 
    IMPORT_ACTION, 
    ENET_UserId, 
    DepartmentId, 
    DirectorateId, 
    ProcessedDateTime
FROM  vwDMHRSI_DMHRSI_PERSONNEL
WHERE ENET_UserId = @usr







