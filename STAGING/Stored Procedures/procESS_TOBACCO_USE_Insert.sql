
-- =============================================
-- Author:		K. Sean Kern
-- Create date: 2015-04-01
-- Description:	Insert from Essentris
-- =============================================

CREATE PROCEDURE [dbo].[procESS_TOBACCO_USE_Insert]
(
	@key datetime,
	@pat bigint,
	@epat bigint,
	@tob nvarchar(50)
)
AS

INSERT INTO ESS_TOBACCO_USE
(
	KeyDate,
	PatientKey,
	EssPatientKey,
	Tobacco
)
VALUES
(
	@key,
	@pat,
	@epat,
	@tob
)



