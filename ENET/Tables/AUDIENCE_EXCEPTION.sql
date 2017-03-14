CREATE TABLE [dbo].[AUDIENCE_EXCEPTION] (
    [AudienceExceptionId]    BIGINT   IDENTITY (1, 1) NOT NULL,
    [AudienceId]             BIGINT   NULL,
    [ApplicationExceptionId] INT      NULL,
    [CreatedDate]            DATETIME CONSTRAINT [DF_AUDIENCE_EXCEPTION_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_AUDIENCE_EXCEPTION] PRIMARY KEY CLUSTERED ([AudienceExceptionId] ASC),
    CONSTRAINT [FK_AUDIENCE_EXCEPTION_APPLICATION_EXCEPTION] FOREIGN KEY ([ApplicationExceptionId]) REFERENCES [dbo].[APPLICATION_EXCEPTION] ([ApplicationExceptionId]),
    CONSTRAINT [FK_AUDIENCE_EXCEPTION_AUDIENCE] FOREIGN KEY ([AudienceId]) REFERENCES [dbo].[AUDIENCE] ([AudienceId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_AUDIENCE_EXCEPTION_AudienceId_ApplicationExceptionId]
    ON [dbo].[AUDIENCE_EXCEPTION]([AudienceId] ASC, [ApplicationExceptionId] ASC);

