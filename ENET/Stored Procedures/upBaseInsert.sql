CREATE PROCEDURE [dbo].[upBaseInsert]
(
	@desc varchar(50),
	@code varchar(5),
	@sort int,
	@createdby int,
	@base int
)
AS
INSERT INTO BASE
(
	BaseName, 
	BaseCode,
	SortOrder, 
	CreatedBy
)
VALUES(
	@desc, 
	@code,
	@sort, 
	@createdby
);
SET @base = SCOPE_IDENTITY();
