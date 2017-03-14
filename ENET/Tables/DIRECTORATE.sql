CREATE TABLE [dbo].[DIRECTORATE] (
    [DirectorateId]     INT          IDENTITY (1, 1) NOT NULL,
    [DirectorateDesc]   VARCHAR (50) NULL,
    [DirectorateCode]   VARCHAR (50) NULL,
    [DirectorateHeadId] INT          NULL,
    [DirPhone]          VARCHAR (50) NULL,
    [DirFax]            VARCHAR (50) NULL,
    [DirPager]          VARCHAR (50) NULL,
    [CreatedDate]       DATETIME     CONSTRAINT [DF_DIRECTORATE_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]         INT          NULL,
    [UpdatedDate]       DATETIME     CONSTRAINT [DF_DIRECTORATE_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]         INT          NULL,
    [Inactive]          BIT          CONSTRAINT [DF_DIRECTORATE_Inactive] DEFAULT ((0)) NULL,
    [ShortName]         VARCHAR (5)  NULL,
    [SortOrder]         TINYINT      NULL,
    CONSTRAINT [PK_DIRECTORATE] PRIMARY KEY CLUSTERED ([DirectorateId] ASC)
);

