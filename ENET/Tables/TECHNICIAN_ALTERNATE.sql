CREATE TABLE [dbo].[TECHNICIAN_ALTERNATE] (
    [TechnicianAlternateId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [TechnicianId]          INT      NULL,
    [AlternateId]           INT      NULL,
    [AliasId]               BIGINT   NULL,
    [AliasTypeId]           INT      NULL,
    [ExpireDate]            DATETIME CONSTRAINT [DF_TECHNICIAN_ALTERNATE_ExpireDate] DEFAULT ('1/1/1776') NULL,
    [SendEmail]             BIT      CONSTRAINT [DF_TECHNICIAN_ALTERNATE_SendEmail] DEFAULT ((0)) NULL,
    [CreatedDate]           DATETIME CONSTRAINT [DF_TECHNICIAN_ALTERNATE_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_TECHNICIAN_ALTERNATE] PRIMARY KEY CLUSTERED ([TechnicianAlternateId] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_TECHNICIAN_ALTERNATE_MulitKey]
    ON [dbo].[TECHNICIAN_ALTERNATE]([TechnicianId] ASC, [AlternateId] ASC, [AliasId] ASC);

