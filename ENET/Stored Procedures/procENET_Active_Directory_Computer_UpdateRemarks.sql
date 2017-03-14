create PROCEDURE [dbo].[procENET_Active_Directory_Computer_UpdateRemarks]
(
@adc bigint, 
@rem text,
@uby int
)
 AS

UPDATE ACTIVE_DIRECTORY_COMPUTER
SET Remarks = @rem,
UpdatedBy = @uby,
UpdatedDate = getdate()
WHERE ActiveDirectoryComputerId = @adc;



