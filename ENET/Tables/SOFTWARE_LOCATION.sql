CREATE TABLE [dbo].[SOFTWARE_LOCATION] (
    [SoftwareLocationId]   INT          IDENTITY (1, 1) NOT NULL,
    [SoftwareLocationDesc] VARCHAR (50) NULL,
    [CreatedDate]          DATETIME     CONSTRAINT [DF_SOFTWARE_LOCATION_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]            INT          CONSTRAINT [DF_SOFTWARE_LOCATION_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]          DATETIME     CONSTRAINT [DF_SOFTWARE_LOCATION_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]            INT          CONSTRAINT [DF_SOFTWARE_LOCATION_UpdatedBy] DEFAULT ((0)) NULL,
    [Inactive]             BIT          CONSTRAINT [DF_SOFTWARE_LOCATION_Inactive] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_SOFTWARE_LOCATION] PRIMARY KEY CLUSTERED ([SoftwareLocationId] ASC)
);

