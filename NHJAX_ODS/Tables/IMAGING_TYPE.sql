CREATE TABLE [dbo].[IMAGING_TYPE] (
    [ImagingTypeId]        BIGINT         NOT NULL,
    [ImagingTypeKey]       NUMERIC (8, 3) NULL,
    [ImagingTypeDesc]      VARCHAR (30)   NULL,
    [ImagingTypeAbbrev]    VARCHAR (4)    NULL,
    [OperatingConditionId] INT            CONSTRAINT [DF_IMAGING_TYPE_OperatingConditionId] DEFAULT ((0)) NULL,
    [CreatedDate]          DATETIME       CONSTRAINT [DF_IMAGING_TYPE_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_IMAGING_TYPE] PRIMARY KEY CLUSTERED ([ImagingTypeId] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'0=NULL; 1=NORMAL', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'IMAGING_TYPE', @level2type = N'COLUMN', @level2name = N'OperatingConditionId';

