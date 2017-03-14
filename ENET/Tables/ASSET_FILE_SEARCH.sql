CREATE TABLE [dbo].[ASSET_FILE_SEARCH] (
    [AssetId]         INT      NOT NULL,
    [SearchAll]       BIT      CONSTRAINT [DF_ASSET_FILE_SEARCH_SearchAll] DEFAULT ((0)) NULL,
    [IncludeDefaults] BIT      CONSTRAINT [DF_ASSET_FILE_SEARCH_IncludeDefaults] DEFAULT ((0)) NULL,
    [RunAudit]        INT      CONSTRAINT [DF_ASSET_FILE_SEARCH_RunAudit] DEFAULT ((0)) NULL,
    [CreatedDate]     DATETIME CONSTRAINT [DF_ASSET_FILE_SEARCH_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]       INT      CONSTRAINT [DF_ASSET_FILE_SEARCH_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]     DATETIME CONSTRAINT [DF_ASSET_FILE_SEARCH_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]       INT      CONSTRAINT [DF_ASSET_FILE_SEARCH_UpdatedBy] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ASSET_FILE_SEARCH] PRIMARY KEY CLUSTERED ([AssetId] ASC)
);

