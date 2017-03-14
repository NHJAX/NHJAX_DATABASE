CREATE TABLE [dbo].[ASSET_MOVEMENT] (
    [AssetMovementId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [AssetId]         INT      NULL,
    [FromAudienceId]  BIGINT   CONSTRAINT [DF_ASSET_MOVEMENT_FromAudienceId] DEFAULT ((0)) NULL,
    [ToAudienceId]    BIGINT   CONSTRAINT [DF_ASSET_MOVEMENT_ToAudienceId] DEFAULT ((0)) NULL,
    [CreatedDate]     DATETIME CONSTRAINT [DF_ASSET_MOVEMENT_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]       INT      CONSTRAINT [DF_ASSET_MOVEMENT_CreatedBy] DEFAULT ((0)) NULL,
    [Reported]        BIT      CONSTRAINT [DF_ASSET_MOVEMENT_Reported] DEFAULT ((0)) NULL,
    [UpdatedDate]     DATETIME CONSTRAINT [DF_ASSET_MOVEMENT_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]       INT      CONSTRAINT [DF_ASSET_MOVEMENT_UpdatedBy] DEFAULT ((0)) NULL,
    [SourceSystemId]  INT      CONSTRAINT [DF_ASSET_MOVEMENT_SourceSystemId] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ASSET_MOVEMENT] PRIMARY KEY CLUSTERED ([AssetMovementId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ASSET_MOVEMENT_CreatedDate]
    ON [dbo].[ASSET_MOVEMENT]([CreatedDate] ASC);

