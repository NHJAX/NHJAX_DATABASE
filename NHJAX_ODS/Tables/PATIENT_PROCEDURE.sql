CREATE TABLE [dbo].[PATIENT_PROCEDURE] (
    [ProcedureId]         BIGINT          IDENTITY (1, 1) NOT NULL,
    [ProcedureKey]        NUMERIC (8, 3)  NULL,
    [CptId]               BIGINT          NULL,
    [PatientEncounterId]  BIGINT          NULL,
    [ProcedureTypeId]     BIGINT          NULL,
    [DiagnosisPriorities] NUMERIC (10, 3) NULL,
    [ProcedureDateTime]   DATETIME        NULL,
    [SurgeonId]           BIGINT          NULL,
    [AnesthetistId]       BIGINT          NULL,
    [ProcedureDesc]       VARCHAR (100)   NULL,
    [CreatedDate]         DATETIME        CONSTRAINT [DF_PROCEDURE_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]         DATETIME        CONSTRAINT [DF_PATIENT_PROCEDURE_UpdatedDate] DEFAULT (getdate()) NULL,
    [RVU]                 MONEY           NULL,
    [SourceSystemId]      BIGINT          CONSTRAINT [DF_PATIENT_PROCEDURE_SourceSystemId] DEFAULT ((0)) NULL,
    [ServiceTypeId]       INT             CONSTRAINT [DF_PATIENT_PROCEDURE_ServiceTypeId] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_PROCEDURE] PRIMARY KEY CLUSTERED ([ProcedureId] ASC),
    CONSTRAINT [FK_PATIENT_PROCEDURE_PATIENT_ENCOUNTER] FOREIGN KEY ([PatientEncounterId]) REFERENCES [dbo].[PATIENT_ENCOUNTER] ([PatientEncounterId])
);


GO
CREATE NONCLUSTERED INDEX [IX_PROCEDURE_KEY]
    ON [dbo].[PATIENT_PROCEDURE]([ProcedureKey] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_PROCEDURE_CptId]
    ON [dbo].[PATIENT_PROCEDURE]([CptId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_PROCEDURE_PatientEncounterId]
    ON [dbo].[PATIENT_PROCEDURE]([PatientEncounterId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_PROCEDURE_DATETIME]
    ON [dbo].[PATIENT_PROCEDURE]([CptId] ASC, [ProcedureDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_PROCEDURE_SourceSystemId]
    ON [dbo].[PATIENT_PROCEDURE]([SourceSystemId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_PROCEDURE_CptId_PatientEncounterId_SourceSystemId]
    ON [dbo].[PATIENT_PROCEDURE]([CptId] ASC, [PatientEncounterId] ASC, [SourceSystemId] ASC);


GO
CREATE NONCLUSTERED INDEX [IS_PATIENT_PROCEDURE_PATIENTPROCEDUREID]
    ON [dbo].[PATIENT_PROCEDURE]([ProcedureId] ASC, [ProcedureDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_PROCEDURE_ProcedureDateTime]
    ON [dbo].[PATIENT_PROCEDURE]([ProcedureDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_PROCEDURE_CptId_ProcedureDateTime]
    ON [dbo].[PATIENT_PROCEDURE]([CptId] ASC, [ProcedureDateTime] ASC);


GO
-- =============================================
-- Author:		K. Sean Kern
-- Create date: 2010-05-12
-- Description:	Updates Encounter Provider 
-- =============================================
create TRIGGER [dbo].[trODS_PATIENT_PROCEDURE_UpdateSurgeon] ON [dbo].[PATIENT_PROCEDURE]
FOR INSERT,UPDATE
AS


DECLARE @enc bigint
DECLARE @pro bigint

DECLARE @encX bigint
DECLARE @proX bigint

Declare @exists int

IF UPDATE(PatientEncounterId) OR UPDATE(SurgeonId)
BEGIN
	
	SELECT 
		@enc = PatientEncounterId,
		@pro = ISNULL(SurgeonId,0)
	FROM inserted 
	
	IF @pro > 0
	BEGIN
	
		SELECT @proX = ProviderId,
			@encX = PatientEncounterId
		FROM ENCOUNTER_PROVIDER
		WHERE ProviderId = @pro
			AND PatientEncounterId = @enc
			AND ProviderRoleId = 10
		SET @exists = @@RowCount
		If @exists = 0
			BEGIN
				INSERT INTO ENCOUNTER_PROVIDER
				(
					PatientEncounterId,
					ProviderId,
					ProviderRoleId
				)
				VALUES
				(
					@enc,
					@pro,
					10
				)
			END	
		END
		
					
		--DECLARE @test varchar(50)
		--SET @test = @pfx + @strNum + @ext
		--EXEC dbo.procFORM_Activity_Log @pfx
		--EXEC dbo.procFORM_Activity_Log @strNum
		--EXEC dbo.procFORM_Activity_Log @ext
		--EXEC dbo.procFORM_Activity_Log @test


END

GO
-- =============================================
-- Author:		K. Sean Kern
-- Create date: 2010-05-12
-- Description:	Updates Encounter Provider 
-- =============================================
CREATE TRIGGER [dbo].[trODS_PATIENT_PROCEDURE_UpdateAnesthetist] ON [dbo].[PATIENT_PROCEDURE]
FOR INSERT,UPDATE
AS


DECLARE @enc bigint
DECLARE @pro bigint

DECLARE @encX bigint
DECLARE @proX bigint

Declare @exists int

IF UPDATE(PatientEncounterId) OR UPDATE(AnesthetistId)
BEGIN
	
	SELECT 
		@enc = PatientEncounterId,
		@pro = ISNULL(AnesthetistId,0)
	FROM inserted 
	
	IF @pro > 0
	BEGIN
	
		SELECT @proX = ProviderId,
			@encX = PatientEncounterId
		FROM ENCOUNTER_PROVIDER
		WHERE ProviderId = @pro
			AND PatientEncounterId = @enc
			AND ProviderRoleId = 11
		SET @exists = @@RowCount
		If @exists = 0
			BEGIN
				INSERT INTO ENCOUNTER_PROVIDER
				(
					PatientEncounterId,
					ProviderId,
					ProviderRoleId
				)
				VALUES
				(
					@enc,
					@pro,
					11
				)
			END	
		END
		
					
		--DECLARE @test varchar(50)
		--SET @test = @pfx + @strNum + @ext
		--EXEC dbo.procFORM_Activity_Log @pfx
		--EXEC dbo.procFORM_Activity_Log @strNum
		--EXEC dbo.procFORM_Activity_Log @ext
		--EXEC dbo.procFORM_Activity_Log @test


END
