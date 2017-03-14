CREATE PROCEDURE [dbo].[upAIM_AssetUpdatePrinter]
(
	@udate datetime,
	@uby int,
	@network varchar(100)
)
AS
UPDATE ASSET SET
	UpdatedDate = @udate,
	UpdatedBy = @uby
	WHERE DispositionId IN (0,1,14) 
	AND NetworkName = @network

