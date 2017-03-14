
CREATE PROCEDURE [dbo].[upODS_DM_EDPTS_Purge_3Days]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;
DECLARE @start datetime

SET @start = dbo.startofday(DATEADD(d,-3,getdate()))
   -- Purge Session Information from EDPTS DataMart
delete from DM_EDPTS.dbo.DM_PEAK_MONTHLY
where createddate < @start

end


