CREATE TABLE [dbo].[MATERNITY_PATIENT] (
    [MaternityPatientId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [PatientId]          BIGINT         NULL,
    [EDC]                DATE           NULL,
    [MaternityStatusId]  INT            CONSTRAINT [DF_MATERNITY_PATIENT_MaternityStatusId] DEFAULT ((0)) NULL,
    [Notes]              VARCHAR (8000) NULL,
    [MaternityTeamId]    INT            CONSTRAINT [DF_MATERNITY_PATIENT_MaternityTeamId] DEFAULT ((0)) NULL,
    [CreatedDate]        DATETIME       CONSTRAINT [DF_MATERNITY_PATIENT_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]        DATETIME       CONSTRAINT [DF_MATERNITY_PATIENT_UpdatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]          INT            CONSTRAINT [DF_MATERNITY_PATIENT_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedBy]          INT            CONSTRAINT [DF_MATERNITY_PATIENT_UpdatedBy] DEFAULT ((0)) NULL,
    [FPProviderId]       INT            CONSTRAINT [DF_MATERNITY_PATIENT_FPProviderId] DEFAULT ((0)) NULL,
    [GestDiabetic]       BIT            CONSTRAINT [DF_MATERNITY_PATIENT_GestDiabetic] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_MATERNITY_PATIENT] PRIMARY KEY CLUSTERED ([MaternityPatientId] ASC),
    CONSTRAINT [FK_MATERNITY_PATIENT_MATERNITY_STATUS] FOREIGN KEY ([MaternityStatusId]) REFERENCES [dbo].[MATERNITY_STATUS] ([MaternityStatusId]),
    CONSTRAINT [FK_MATERNITY_PATIENT_MATERNITY_TEAM] FOREIGN KEY ([MaternityTeamId]) REFERENCES [dbo].[MATERNITY_TEAM] ([MaternityTeamId]),
    CONSTRAINT [FK_MATERNITY_PATIENT_PATIENT] FOREIGN KEY ([PatientId]) REFERENCES [dbo].[PATIENT] ([PatientId])
);


GO
create TRIGGER [dbo].[trODS_Maternity_Patient_Update] ON [dbo].[MATERNITY_PATIENT]
FOR UPDATE
AS


DECLARE @mpat	bigint
DECLARE @pat	bigint
DECLARE @edc	date
DECLARE @stat	int
DECLARE @notes	varchar(8000)
DECLARE @tm		int
DECLARE @cdate	datetime
DECLARE @udate	datetime
DECLARE @cby	int
DECLARE @uby	int
DECLARE @fpro	int

	SELECT 
		@mpat = MaternityPatientId,
		@pat = PatientId, 
		@edc = EDC, 
		@stat = MaternityStatusId, 
		@notes = Notes, 
		@tm = MaternityTeamId, 
		@cdate = CreatedDate, 
		@udate = UpdatedDate, 
		@cby = CreatedBy, 
		@uby = UpdatedBy, 
		@fpro = FPProviderId

	FROM deleted 

		INSERT INTO MATERNITY_PATIENT_HISTORY
		(
			MaternityPatientId, 
			PatientId, 
			EDC, 
			MaternityStatusId, 
			Notes, 
			MaternityTeamId, 
			CreatedDate, 
			UpdatedDate, 
			CreatedBy, 
			UpdatedBy, 
			FPProviderId
		)
		VALUES     
		(
			@mpat,
			@pat,
			@edc,
			@stat,
			@notes,
			@tm,
			@cdate,
			@udate,
			@cby,
			@uby,
			@fpro
		)


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Uses ENet Id and Peer Review functionality for selection list', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MATERNITY_PATIENT', @level2type = N'COLUMN', @level2name = N'FPProviderId';

