CREATE PROCEDURE [dbo].[procENET_SWITCH_Insert]
(
	@desc varchar(50),
	@bas int,
	@cby int
)
AS
INSERT INTO SWITCH
(
	SwitchDesc, 
	BaseId, 
	CreatedBy
)
VALUES(
	@desc, 
	@bas, 
	@cby
);
SELECT SCOPE_IDENTITY();
