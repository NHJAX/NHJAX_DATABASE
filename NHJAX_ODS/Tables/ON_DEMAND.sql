CREATE TABLE [dbo].[ON_DEMAND] (
    [OnDemandId]     BIGINT       IDENTITY (1, 1) NOT NULL,
    [DemandKey]      VARCHAR (50) NULL,
    [CreatedDate]    DATETIME     CONSTRAINT [DF_ON_DEMAND_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]      INT          CONSTRAINT [DF_ON_DEMAND_CreatedBy] DEFAULT ((0)) NULL,
    [OnDemandTypeId] INT          NULL,
    CONSTRAINT [PK_ON_DEMAND] PRIMARY KEY CLUSTERED ([OnDemandId] ASC)
);

