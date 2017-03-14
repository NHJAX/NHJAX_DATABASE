CREATE TABLE [dbo].[ASSET_FILE] (
    [AssetFileId]          BIGINT        IDENTITY (1, 1) NOT NULL,
    [AssetId]              INT           NULL,
    [AssetFileExtensionId] INT           NULL,
    [AssetFileName]        VARCHAR (100) NULL,
    [AssetFilePath]        VARCHAR (500) NULL,
    [FileCreated]          DATETIME      NULL,
    [FileWritten]          DATETIME      NULL,
    [FileAccessed]         DATETIME      NULL,
    [FileSize]             BIGINT        CONSTRAINT [DF_ASSET_FILE_FileSize] DEFAULT ((0)) NULL,
    [CreatedDate]          DATETIME      CONSTRAINT [DF_SOFTWARE_ASSET_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]            INT           CONSTRAINT [DF_ASSET_FILE_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]          DATETIME      CONSTRAINT [DF_ASSET_FILE_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]            INT           CONSTRAINT [DF_ASSET_FILE_UpdatedBy] DEFAULT ((0)) NULL,
    [Removed]              BIT           CONSTRAINT [DF_ASSET_FILE_Removed] DEFAULT ((0)) NULL,
    [SoftwareId]           INT           NULL,
    [AlertFlag]            BIT           CONSTRAINT [DF_ASSET_FILE_AlertFlag] DEFAULT ((0)) NULL,
    [FileVersion]          VARCHAR (50)  NULL,
    [FileComments]         VARCHAR (100) NULL,
    [SoftwareLicenseId]    INT           NULL,
    CONSTRAINT [PK_SOFTWARE_ASSET] PRIMARY KEY CLUSTERED ([AssetFileId] ASC),
    CONSTRAINT [FK_ASSET_FILE_ASSET] FOREIGN KEY ([AssetId]) REFERENCES [dbo].[ASSET] ([AssetId]),
    CONSTRAINT [FK_ASSET_FILE_ASSET_FILE_EXTENSION] FOREIGN KEY ([AssetFileExtensionId]) REFERENCES [dbo].[ASSET_FILE_EXTENSION] ([AssetFileExtensionId])
);


GO
CREATE NONCLUSTERED INDEX [IX_ASSET_FILE_AssetFileName]
    ON [dbo].[ASSET_FILE]([AssetFileName] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ASSET_FILE_AssetId_AssetFileExtensionId]
    ON [dbo].[ASSET_FILE]([AssetId] ASC, [AssetFileExtensionId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ASSET_FILE_AssetId_AssetFileName]
    ON [dbo].[ASSET_FILE]([AssetId] ASC, [AssetFileName] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ASSET_FILE_AssetId_AssetFilePath]
    ON [dbo].[ASSET_FILE]([AssetId] ASC, [AssetFilePath] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ASSET_FILE_FileComments]
    ON [dbo].[ASSET_FILE]([FileComments] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ASSET_FILE_FileVersion]
    ON [dbo].[ASSET_FILE]([FileVersion] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ASSET_FILE_SoftwareId_AssetFileName]
    ON [dbo].[ASSET_FILE]([SoftwareId] ASC, [AssetFileName] ASC);


GO

CREATE TRIGGER [dbo].[updateassetfilename] ON [dbo].[ASSET_FILE]
FOR INSERT
AS

DECLARE @sft int
DECLARE @ast int
DECLARE @afn varchar(100)

SELECT @afn = SFT.AssetFileName, @sft = AFL.SoftwareId, @ast = AFL.AssetId FROM inserted AFL
	INNER JOIN SOFTWARE_NAME SFT
	ON AFL.SoftwareId = SFT.SoftwareId

IF LEN(@afn) > 0
	BEGIN
		UPDATE ASSET_FILE
		SET AssetFileName = @afn
		WHERE AssetId = @ast
		AND SoftwareId = @sft
	END


