CREATE TABLE [dbo].[PCM_CODE] (
    [PCMCodeId]   INT           NOT NULL,
    [PCMCodeDesc] NVARCHAR (50) NULL,
    [CreatedDate] DATETIME      CONSTRAINT [DF_PCM_CODE_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_PCM_CODE] PRIMARY KEY CLUSTERED ([PCMCodeId] ASC)
);

