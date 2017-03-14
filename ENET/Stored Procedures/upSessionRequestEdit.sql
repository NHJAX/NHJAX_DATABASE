CREATE PROCEDURE [dbo].[upSessionRequestEdit]
(
	@c4id int,
	@qty int,
	@just varchar(1000),
	@c4 varchar(100),
	@uby int,
	@udate datetime,
	@req int
)
AS
BEGIN TRANSACTION
UPDATE sessASSET_REQUEST
SET
CreatedFor = @c4id, 
ItemQuantity = @qty,
ItemJustification = @just,
CreatedForAlpha = @c4,
UpdatedBy = @uby,
UpdatedDate = @udate
WHERE RequestId = @req;
COMMIT TRANSACTION
