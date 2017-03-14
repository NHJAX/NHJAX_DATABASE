CREATE PROCEDURE [dbo].[procCIAO_vwCIAO_Personnel_UpdatePSQDatebyDoDEDI]
(
@dod nvarchar(10), 
@psqdate datetime,
@psqby int
)
 AS

UPDATE vwCIAO_PERSONNEL
SET PSQDate = @psqdate,
	PSQBy = @psqby,
	PSQ = 1
WHERE DoDEDI = @dod



