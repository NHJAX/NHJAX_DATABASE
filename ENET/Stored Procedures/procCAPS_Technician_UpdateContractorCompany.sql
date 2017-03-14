create PROCEDURE [dbo].[procCAPS_Technician_UpdateContractorCompany]
(
	@usr int,
	@uby int,
	@udate datetime,
	@cont varchar(50)
)
AS
UPDATE TECHNICIAN SET
	ContractorCompany = @cont,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


