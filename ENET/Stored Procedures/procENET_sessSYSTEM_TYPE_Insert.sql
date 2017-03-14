create PROCEDURE [dbo].[procENET_sessSYSTEM_TYPE_Insert]
(
	@sess varchar(50),
	@sys int,
	@cby int
) 
AS

INSERT INTO sessSYSTEM_TYPE
(
SessionId, 
SystemTypeId, 
CreatedBy
)
VALUES
(
@sess,
@sys,
@cby
)
