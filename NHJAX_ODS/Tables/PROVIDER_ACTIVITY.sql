﻿CREATE TABLE [dbo].[PROVIDER_ACTIVITY] (
    [ProviderId]  BIGINT   NOT NULL,
    [CreatedDate] DATETIME CONSTRAINT [DF_PROVIDER_ACTIVITY_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate] DATETIME CONSTRAINT [DF_PROVIDER_ACTIVITY_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_PROVIDER_ACTIVITY] PRIMARY KEY CLUSTERED ([ProviderId] ASC)
);

