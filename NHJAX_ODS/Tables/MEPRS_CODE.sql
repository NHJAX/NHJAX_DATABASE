CREATE TABLE [dbo].[MEPRS_CODE] (
    [MeprsCodeId]   BIGINT          IDENTITY (0, 1) NOT NULL,
    [MeprsCodeKey]  NUMERIC (10, 3) NULL,
    [MeprsCode]     VARCHAR (4)     NULL,
    [MeprsCodeDesc] VARCHAR (50)    NULL,
    [DmisId]        BIGINT          NULL,
    [CreatedDate]   DATETIME        CONSTRAINT [DF_MEPRS_CODE_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]   DATETIME        CONSTRAINT [DF_MEPRS_CODE_UpdatedDate] DEFAULT (getdate()) NULL,
    [DoNotDisplay]  BIT             CONSTRAINT [DF_MEPRS_CODE_DoNotDisplay] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_MEPRS_CODE] PRIMARY KEY CLUSTERED ([MeprsCodeId] ASC),
    CONSTRAINT [FK_MEPRS_CODE_DMIS] FOREIGN KEY ([DmisId]) REFERENCES [dbo].[DMIS] ([DMISId])
);


GO
CREATE NONCLUSTERED INDEX [IX_MEPRS_CODE_KEY]
    ON [dbo].[MEPRS_CODE]([MeprsCodeKey] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_MEPRS_CODE_MeprsCode]
    ON [dbo].[MEPRS_CODE]([MeprsCode] ASC);

