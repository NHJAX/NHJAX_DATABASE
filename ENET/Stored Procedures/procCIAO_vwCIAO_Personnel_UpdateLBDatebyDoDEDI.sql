CREATE PROCEDURE [dbo].[procCIAO_vwCIAO_Personnel_UpdateLBDatebyDoDEDI]
(
@dod nvarchar(10), 
@lbdate datetime,
@lbby int
)
 AS

UPDATE vwCIAO_PERSONNEL
SET LBDate = @lbdate,
	LBBy = @lbby,
	LB = 1
WHERE DoDEDI = @dod



