CREATE TABLE [dbo].[SERVICE_TYPE] (
    [ServiceTypeId]   INT           NOT NULL,
    [ServiceTypeDesc] NVARCHAR (50) NULL,
    [CreatedDate]     DATETIME      CONSTRAINT [DF_SERVICE_TYPE_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_SERVICE_TYPE] PRIMARY KEY CLUSTERED ([ServiceTypeId] ASC)
);

