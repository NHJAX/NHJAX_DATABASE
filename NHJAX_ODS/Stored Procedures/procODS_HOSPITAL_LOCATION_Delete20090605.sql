﻿
create PROCEDURE [dbo].[procODS_HOSPITAL_LOCATION_Delete20090605]

AS
	SET NOCOUNT ON;
	
DELETE FROM NHJAX_ODS.dbo.HOSPITAL_LOCATION
WHERE HospitalLocationId > 613;