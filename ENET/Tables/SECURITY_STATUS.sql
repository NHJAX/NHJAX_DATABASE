CREATE TABLE [dbo].[SECURITY_STATUS] (
    [SecurityStatusId]   INT          NOT NULL,
    [SecurityStatusDesc] VARCHAR (50) NULL,
    [CreatedDate]        DATETIME     CONSTRAINT [DF_SECURITY_STATUS_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_SECURITY_STATUS] PRIMARY KEY CLUSTERED ([SecurityStatusId] ASC)
);

