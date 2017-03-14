﻿CREATE TABLE [dbo].[AUDIENCE_BILLET] (
    [AudienceBilletId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [AudienceId]       BIGINT   NULL,
    [BilletId]         INT      NULL,
    [CreatedDate]      DATETIME CONSTRAINT [DF_AUDIENCE_BILLET_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_AUDIENCE_BILLET] PRIMARY KEY CLUSTERED ([AudienceBilletId] ASC),
    CONSTRAINT [FK_AUDIENCE_BILLET_AUDIENCE] FOREIGN KEY ([AudienceId]) REFERENCES [dbo].[AUDIENCE] ([AudienceId]),
    CONSTRAINT [FK_AUDIENCE_BILLET_BILLET] FOREIGN KEY ([BilletId]) REFERENCES [dbo].[BILLET] ([BilletId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_AUDIENCE_BILLET_AudienceId_BilletId]
    ON [dbo].[AUDIENCE_BILLET]([AudienceId] ASC, [BilletId] ASC);

