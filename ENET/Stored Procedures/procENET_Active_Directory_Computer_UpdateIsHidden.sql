create PROCEDURE [dbo].[procENET_Active_Directory_Computer_UpdateIsHidden]
(
@adc bigint, 
@hid bit,
@uby int
)
 AS

UPDATE ACTIVE_DIRECTORY_COMPUTER
SET IsHidden = @hid,
UpdatedBy = @uby,
UpdatedDate = getdate()
WHERE ActiveDirectoryComputerId = @adc;



