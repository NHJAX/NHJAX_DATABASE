CREATE TABLE [dbo].[DOMAIN] (
    [DomainId]    INT          IDENTITY (0, 1) NOT NULL,
    [DomainName]  VARCHAR (50) NULL,
    [CreatedDate] DATETIME     CONSTRAINT [DF_DOMAIN_CreatedDate] DEFAULT (getdate()) NULL,
    [Inactive]    BIT          CONSTRAINT [DF_DOMAIN_Inactive] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_DOMAIN] PRIMARY KEY CLUSTERED ([DomainId] ASC)
);

