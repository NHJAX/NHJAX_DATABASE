CREATE TABLE [dbo].[MODEL] (
    [ModelId]        INT          IDENTITY (1, 1) NOT NULL,
    [ModelDesc]      VARCHAR (50) NULL,
    [ManufacturerId] INT          NULL,
    [CreatedDate]    DATETIME     CONSTRAINT [DF_MODEL_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]      INT          CONSTRAINT [DF_MODEL_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]    DATETIME     CONSTRAINT [DF_MODEL_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]      INT          CONSTRAINT [DF_MODEL_UpdatedBy] DEFAULT ((0)) NULL,
    [Inactive]       BIT          CONSTRAINT [DF_MODEL_Inactive] DEFAULT ((0)) NULL,
    [UnitCost]       MONEY        CONSTRAINT [DF_MODEL_UnitCost] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_MODEL] PRIMARY KEY CLUSTERED ([ModelId] ASC),
    CONSTRAINT [FK_MODEL_MANUFACTURER] FOREIGN KEY ([ManufacturerId]) REFERENCES [dbo].[MANUFACTURER] ([ManufacturerId])
);

