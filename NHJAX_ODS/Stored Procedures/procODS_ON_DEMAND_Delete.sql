
create PROCEDURE [dbo].[procODS_ON_DEMAND_Delete]
(
	@key varchar(50),
	@typ int
)
AS
	

DELETE FROM ON_DEMAND
WHERE DemandKey = @key
AND OnDemandTypeId = @typ;

