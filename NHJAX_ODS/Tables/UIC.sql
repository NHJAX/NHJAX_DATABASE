CREATE TABLE [dbo].[UIC] (
    [UICId]                BIGINT          IDENTITY (1, 1) NOT NULL,
    [UICKey]               NUMERIC (12, 3) NULL,
    [UICDesc]              VARCHAR (30)    NULL,
    [UICCode]              VARCHAR (30)    NULL,
    [BranchofServiceId]    BIGINT          CONSTRAINT [DF_UIC_BranchofServiceId] DEFAULT ((15)) NULL,
    [GeographicLocationId] BIGINT          CONSTRAINT [DF_UIC_GeographicLocationId] DEFAULT ((345)) NULL,
    [CreatedDate]          DATETIME        CONSTRAINT [DF_UIC_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]          DATETIME        CONSTRAINT [DF_UIC_UpdatedDate] DEFAULT (getdate()) NULL,
    [Inactive]             BIT             CONSTRAINT [DF_UIC_Inactive] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_UIC] PRIMARY KEY CLUSTERED ([UICId] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_UIC_UICKey]
    ON [dbo].[UIC]([UICKey] ASC);

