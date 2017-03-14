create PROCEDURE [dbo].[procENET_IMPORT_LOG_Insert]
(
	@desc	varchar(1000),
	@cby	int,
	@typ	int = 0
)
AS

INSERT INTO IMPORT_LOG
(
	ImportLogDesc,
	UserId,
	LogTypeId
) 
VALUES
(
	@desc,
	@cby,
	@typ
);


