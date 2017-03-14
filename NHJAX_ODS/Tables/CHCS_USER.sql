CREATE TABLE [dbo].[CHCS_USER] (
    [CHCSUserId]      BIGINT          IDENTITY (1, 1) NOT NULL,
    [CHCSUserKey]     NUMERIC (12, 4) NULL,
    [CHCSUserName]    VARCHAR (30)    NULL,
    [AccessCode]      VARCHAR (255)   NULL,
    [VerifyCode]      VARCHAR (255)   NULL,
    [ProviderId]      BIGINT          NULL,
    [TerminationDate] DATETIME        NULL,
    [CreatedDate]     DATETIME        CONSTRAINT [DF_USER_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]     DATETIME        CONSTRAINT [DF_USER_UpdatedDate] DEFAULT (getdate()) NULL,
    [SSN]             VARCHAR (30)    NULL,
    [LastSignOn]      VARCHAR (17)    NULL,
    CONSTRAINT [PK_USER] PRIMARY KEY CLUSTERED ([CHCSUserId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CHCS_USER_CHCSUserKey]
    ON [dbo].[CHCS_USER]([CHCSUserKey] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_CHCS_USER_CHCSUsername]
    ON [dbo].[CHCS_USER]([CHCSUserName] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_CHCS_USER_SSN]
    ON [dbo].[CHCS_USER]([SSN] ASC);

