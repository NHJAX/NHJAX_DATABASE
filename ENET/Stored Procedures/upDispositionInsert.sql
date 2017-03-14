CREATE PROCEDURE [dbo].[upDispositionInsert]
(
	@desc varchar(50),
	@createdby int,
	@vw int,
	@disp int 
)
AS
INSERT INTO DISPOSITION
(
	DispositionDesc, 
	ViewLevelId,
	CreatedBy
)
VALUES(
	@desc, 
	@vw, 
	@createdby
);
SET @disp = SCOPE_IDENTITY();
