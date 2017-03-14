CREATE PROCEDURE [dbo].[upENet_SoftwareLicenseSelectSumofUsers] 
(
	@sft int
)
AS
SELECT ISNULL(SUM(NumberofUsers),0)
FROM SOFTWARE_LICENSE
WHERE SoftwareId = @sft
AND Inactive = 0

