
create PROCEDURE [dbo].[procODS_ON_DEMAND_Insert]
(
	@key varchar(50),
	@cby int = 0,
	@typ int = 0
)
AS
	BEGIN TRANSACTION

	--PRINT 'INSERT INTO ACTIVITY_LOG'

DECLARE @Id as bigint

SELECT @Id = Count(OnDemandId)
FROM ON_DEMAND
WHERE DemandKey = @key
AND OnDemandTypeId = @typ

IF @Id = 0
BEGIN 

INSERT INTO ON_DEMAND 
(
DemandKey,
CreatedBy,
OnDemandTypeId
) 
VALUES
(
@key,
@cby,
@typ
);
END

	COMMIT TRANSACTION
