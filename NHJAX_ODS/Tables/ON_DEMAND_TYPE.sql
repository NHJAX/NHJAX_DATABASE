CREATE TABLE [dbo].[ON_DEMAND_TYPE] (
    [OnDemandTypeId]   INT          NOT NULL,
    [OnDemandTypeDesc] VARCHAR (50) NULL,
    [CreatedDate]      DATETIME     CONSTRAINT [DF_ON_DEMAND_TYPE_CreatedDate] DEFAULT (getdate()) NULL,
    [Inactive]         BIT          CONSTRAINT [DF_ON_DEMAND_TYPE_Inactive] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ON_DEMAND_TYPE] PRIMARY KEY CLUSTERED ([OnDemandTypeId] ASC)
);

