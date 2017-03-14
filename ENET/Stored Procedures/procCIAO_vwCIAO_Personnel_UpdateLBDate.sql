create PROCEDURE [dbo].[procCIAO_vwCIAO_Personnel_UpdateLBDate]
(
@ssn varchar(11), 
@lbdate datetime,
@lbby int
)
 AS

UPDATE vwCIAO_PERSONNEL
SET LBDate = @lbdate,
	LBBy = @lbby,
	LB = 1
WHERE SSN = @ssn



