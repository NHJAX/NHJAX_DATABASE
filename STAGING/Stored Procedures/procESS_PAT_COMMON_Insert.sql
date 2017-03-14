
-- =============================================
-- Author:		K. Sean Kern
-- Create date: 2015-04-01
-- Description:	Insert from Essentris
-- =============================================

create PROCEDURE [dbo].[procESS_PAT_COMMON_Insert]
(
	@pat bigint,
	@epat bigint,
	@hosp nvarchar(50),
	@pro nvarchar(50),
	@move datetime,
	@edit datetime,
	@unit nvarchar(100),
	@bed nvarchar(100),
	@adm datetime
)
AS

INSERT INTO ESS_PATCOMMON
(
	PatientKey,
	EssPatientKey,
	HospNo,
	ProviderName,
	MoveTime,
	EditTime,
	Unit,
	BedName,
	AdmTime
)
VALUES
(
	@pat,
	@epat,
	@hosp,
	@pro,
	@move,
	@edit,
	@unit,
	@bed,
	@adm
)



