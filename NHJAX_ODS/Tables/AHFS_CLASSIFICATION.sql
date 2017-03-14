CREATE TABLE [dbo].[AHFS_CLASSIFICATION] (
    [AHFSClassificationId]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [AHFSNumber]             VARCHAR (53)  NULL,
    [AHFSClassificationDesc] VARCHAR (110) NULL,
    [CreatedDate]            DATETIME      CONSTRAINT [DF_AHFS_CLASSIFICATION_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_AHFS_CLASSIFICATION] PRIMARY KEY CLUSTERED ([AHFSClassificationId] ASC)
);

