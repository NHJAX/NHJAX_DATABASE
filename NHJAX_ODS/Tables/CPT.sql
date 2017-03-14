CREATE TABLE [dbo].[CPT] (
    [CptId]          BIGINT          IDENTITY (1, 1) NOT NULL,
    [CptHcpcsKey]    NUMERIC (11, 3) NULL,
    [CptCode]        VARCHAR (30)    NULL,
    [CptDesc]        VARCHAR (100)   NULL,
    [CptTypeId]      BIGINT          NULL,
    [RVU]            MONEY           NULL,
    [CMACUnit]       MONEY           NULL,
    [CreatedDate]    DATETIME        CONSTRAINT [DF_CPT_HCPCS_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]    DATETIME        CONSTRAINT [DF_CPT_UpdatedDate] DEFAULT (getdate()) NULL,
    [IsNSQIP]        BIT             CONSTRAINT [DF_CPT_IsNSQIP] DEFAULT ((1)) NULL,
    [SourceSystemId] BIGINT          NULL,
    CONSTRAINT [PK_CPT_HCPCS] PRIMARY KEY CLUSTERED ([CptId] ASC),
    CONSTRAINT [FK_CPT_CPT_TYPE] FOREIGN KEY ([CptTypeId]) REFERENCES [dbo].[CPT_TYPE] ([CptTypeId])
);


GO
CREATE NONCLUSTERED INDEX [IX_CPT_HCPCS_KEY]
    ON [dbo].[CPT]([CptHcpcsKey] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_CPT_CPT_ID]
    ON [dbo].[CPT]([CptId] ASC, [RVU] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_CPT_CODE, DESC, RVU]
    ON [dbo].[CPT]([CptCode] ASC, [CptDesc] ASC, [RVU] ASC, [CptId] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);

