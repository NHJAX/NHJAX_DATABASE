create PROCEDURE [dbo].[procENET_Asset_UpdateDisposition]

(
	@disp		int,
	@remark		varchar(1000),
	@uby		int,
	@ast		int
)
 AS

UPDATE ASSET SET
	DispositionId = @disp,
	Remarks = @remark,
	UpdatedDate = getdate(),
	UpdatedBy = @uby
WHERE AssetId = @ast


