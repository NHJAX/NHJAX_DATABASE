﻿
CREATE PROCEDURE [dbo].[procODS_DMIS_SelectNHJAX]

AS
	SET NOCOUNT ON;
SELECT     
	DMISId,
	DMISKey,
	DMISCode,
	REPLACE(FacilityName,'NBHC ','') AS FacilityName,
	CreatedDate,
	UpdatedDate
FROM DMIS
WHERE (DMISId IN (1664,1740,1527,1698,1665,1659,1811))
ORDER BY FacilityName
