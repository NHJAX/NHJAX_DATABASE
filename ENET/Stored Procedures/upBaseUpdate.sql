CREATE PROCEDURE [dbo].[upBaseUpdate]
(
	@desc varchar(50),
	@code varchar(5),
	@sort int,
	@inactive bit,
	@uby int,
	@udate datetime,
	@base int
)
AS
UPDATE BASE SET
	BaseName = @desc, 
	BaseCode = @code,
	SortOrder = @sort,
	Inactive = @inactive,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE BaseId = @base;
