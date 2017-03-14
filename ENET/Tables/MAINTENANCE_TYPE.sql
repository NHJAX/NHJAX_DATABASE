CREATE TABLE [dbo].[MAINTENANCE_TYPE] (
    [MaintenanceTypeId]   INT          NULL,
    [MaintenanceTypeDesc] VARCHAR (50) NULL,
    [CreatedDate]         DATETIME     CONSTRAINT [DF_MAINTENANCE_TYPE_CreatedDate] DEFAULT (getdate()) NULL
);

