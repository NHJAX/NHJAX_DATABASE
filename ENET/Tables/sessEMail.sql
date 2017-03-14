CREATE TABLE [dbo].[sessEMail] (
    [SessionKey]  INT            IDENTITY (1, 1) NOT NULL,
    [CreatedBy]   INT            NULL,
    [CreatedDate] DATETIME       CONSTRAINT [DF_sessEMail_CreatedDate] DEFAULT (getdate()) NULL,
    [ToList]      VARCHAR (4000) NULL,
    [CcList]      VARCHAR (4000) NULL,
    [BccList]     VARCHAR (4000) NULL,
    CONSTRAINT [PK_sessEMail] PRIMARY KEY CLUSTERED ([SessionKey] ASC)
);

