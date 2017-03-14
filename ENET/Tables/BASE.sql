CREATE TABLE [dbo].[BASE] (
    [BaseId]         INT            IDENTITY (1, 1) NOT NULL,
    [BaseName]       VARCHAR (50)   NULL,
    [SortOrder]      INT            NULL,
    [CreatedDate]    DATETIME       CONSTRAINT [DF_BASE_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]      INT            CONSTRAINT [DF_BASE_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]    DATETIME       CONSTRAINT [DF_BASE_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]      INT            CONSTRAINT [DF_BASE_UpdatedBy] DEFAULT ((0)) NULL,
    [Inactive]       BIT            CONSTRAINT [DF_BASE_Inactive] DEFAULT ((0)) NULL,
    [BaseCode]       VARCHAR (5)    NOT NULL,
    [LeadTechId]     INT            CONSTRAINT [DF_BASE_LeadTechId] DEFAULT ((38)) NULL,
    [ADCompany]      VARCHAR (100)  NULL,
    [ADAddress1]     VARCHAR (100)  NULL,
    [ADAddress2]     VARCHAR (100)  NULL,
    [ADCity]         VARCHAR (100)  NULL,
    [ADState]        VARCHAR (2)    NULL,
    [ADZip]          VARCHAR (10)   NULL,
    [ADCountry]      VARCHAR (50)   NULL,
    [DirectoryEntry] VARCHAR (100)  NULL,
    [ADDisplay]      VARCHAR (50)   NULL,
    [HomeDrive]      VARCHAR (3)    NULL,
    [DMISCode]       VARCHAR (30)   NULL,
    [HomeDirectory]  NVARCHAR (150) NULL,
    [UIC]            NVARCHAR (50)  NULL,
    [MIDBuildingId]  INT            NULL,
    [MIDRoom]        VARCHAR (50)   NULL,
    [MIDDeckId]      INT            NULL,
    CONSTRAINT [PK_BASE] PRIMARY KEY CLUSTERED ([BaseId] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_BASE_BaseCode]
    ON [dbo].[BASE]([BaseCode] ASC);

