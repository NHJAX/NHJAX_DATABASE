CREATE PROCEDURE [dbo].[upsessProblemTypeInsert]
(
	@sess varchar(50),
	@prob int,
	@cby int
) 
AS

INSERT INTO sessPROBLEM_TYPE
(
SessionId, 
ProblemTypeId, 
CreatedBy
)
VALUES
(
@sess,
@prob,
@cby
)
