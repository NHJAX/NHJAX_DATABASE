create PROCEDURE [dbo].[procCAPS_Technician_UpdateContractNumber]
(
	@usr int,
	@uby int,
	@udate datetime,
	@cnum varchar(50)
)
AS
UPDATE TECHNICIAN SET
	ContractNumber = @cnum,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


