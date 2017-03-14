create PROCEDURE [dbo].[procCIAO_vwCIAO_Personnel_UpdatePSQDate]
(
@ssn varchar(11), 
@psqdate datetime,
@psqby int
)
 AS

UPDATE vwCIAO_PERSONNEL
SET PSQDate = @psqdate,
	PSQBy = @psqby,
	PSQ = 1
WHERE SSN = @ssn



