CREATE TABLE [dbo].[APPLICATION_EXCEPTION] (
    [ApplicationExceptionId]   INT          NOT NULL,
    [ApplicationExceptionDesc] VARCHAR (50) NULL,
    [SecurityGroupId]          INT          NULL,
    [CreatedDate]              DATETIME     CONSTRAINT [DF_APPLICATION_EXCEPTION_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_APPLICATION_EXCEPTION] PRIMARY KEY CLUSTERED ([ApplicationExceptionId] ASC),
    CONSTRAINT [FK_APPLICATION_EXCEPTION_SECURITY_GROUP] FOREIGN KEY ([SecurityGroupId]) REFERENCES [dbo].[SECURITY_GROUP] ([SecurityGroupId])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Zero means ALL Applications', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'APPLICATION_EXCEPTION', @level2type = N'COLUMN', @level2name = N'SecurityGroupId';

