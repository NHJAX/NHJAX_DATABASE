CREATE TABLE [dbo].[SOFTWARE_NAME] (
    [SoftwareId]             INT           IDENTITY (1, 1) NOT NULL,
    [SoftwareDesc]           VARCHAR (50)  NULL,
    [Inactive]               BIT           CONSTRAINT [DF_SOFTWARE_NAME_Inactive] DEFAULT ((0)) NULL,
    [CreatedDate]            DATETIME      CONSTRAINT [DF_SOFTWARE_NAME_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]              INT           CONSTRAINT [DF_SOFTWARE_NAME_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]            DATETIME      CONSTRAINT [DF_SOFTWARE_NAME_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]              INT           CONSTRAINT [DF_SOFTWARE_NAME_UpdatedBy] DEFAULT ((0)) NULL,
    [AssetFileName]          VARCHAR (100) NULL,
    [SoftwareManufacturerId] INT           NULL,
    CONSTRAINT [PK_SOFTWARE_NAME] PRIMARY KEY CLUSTERED ([SoftwareId] ASC)
);


GO

CREATE TRIGGER [dbo].[trENet_SoftwareName_InsertAssetFileSoftwareId] ON [dbo].[SOFTWARE_NAME]
FOR INSERT, UPDATE
AS

DECLARE @sft int
DECLARE @afn varchar(100)

SELECT @sft = SFT.SoftwareId,@afn = SFT.AssetFileName
	FROM inserted SFT
	INNER JOIN ASSET_FILE AFL
	ON SFT.AssetFileName = AFL.AssetFileName

IF LEN(@sft) > 0
	BEGIN
		UPDATE ASSET_FILE
		SET SoftwareId = @sft
		WHERE AssetFileName = @afn
		AND SoftwareId IS NULL
	END


