create PROCEDURE [dbo].[procENET_Asset_UpdateDispositionbyNetworkName]

(
	@disp		int,
	@remark		varchar(1000),
	@uby		int,
	@net		varchar(100)
)
 AS

UPDATE ASSET SET
	DispositionId = @disp,
	Remarks = @remark,
	UpdatedDate = getdate(),
	UpdatedBy = @uby
WHERE NetworkName = @net


