CREATE PROCEDURE [dbo].[procENET_vwODS_PCM_EXCEPTION_AddRemove]
(
	@pro bigint,
	@exc bit
)
 AS

--prevent errors in the event of a duplicate regardless
--of @exc parameter
DELETE FROM dbo.vwODS_PCM_EXCEPTION
WHERE PCMExceptionId = @pro;

IF @exc = 1
BEGIN
INSERT INTO dbo.vwODS_PCM_EXCEPTION
(
PCMExceptionId
)
VALUES
(
@pro
)
END

