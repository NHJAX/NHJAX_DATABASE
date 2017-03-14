CREATE TABLE [dbo].[sessINV_MANUFACTURER] (
    [SessionKey]     INT      IDENTITY (1, 1) NOT NULL,
    [CreatedDate]    DATETIME CONSTRAINT [DF_sessINV_MANUFACTURER_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]      INT      NULL,
    [ManufacturerId] INT      NULL,
    CONSTRAINT [PK_sessINV_MANUFACTURER] PRIMARY KEY CLUSTERED ([SessionKey] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_sessINV_MANUFACTURER_CreatedBy]
    ON [dbo].[sessINV_MANUFACTURER]([CreatedBy] ASC);

