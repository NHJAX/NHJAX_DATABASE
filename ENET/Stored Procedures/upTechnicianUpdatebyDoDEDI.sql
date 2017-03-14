﻿CREATE PROCEDURE [dbo].[upTechnicianUpdatebyDoDEDI]
(
	@dod nvarchar(10),
	@uby int,
	@udate datetime
)
AS
UPDATE TECHNICIAN SET
	Inactive = 1,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE DoDEDI = @dod;
