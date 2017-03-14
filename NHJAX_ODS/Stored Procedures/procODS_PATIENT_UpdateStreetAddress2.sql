﻿

create PROCEDURE [dbo].[procODS_PATIENT_UpdateStreetAddress2]
	@pat decimal,
	@add2 varchar(36)

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		StreetAddress2 = @add2,
		UpdatedDate = GetDate()
	WHERE PatientKey = @pat
END

