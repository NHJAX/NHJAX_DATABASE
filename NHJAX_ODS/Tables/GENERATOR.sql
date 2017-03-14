CREATE TABLE [dbo].[GENERATOR] (
    [LastNumber]      BIGINT NULL,
    [GeneratorTypeId] INT    CONSTRAINT [DF_GENERATOR_GeneratorTypeId] DEFAULT ((1)) NULL
);

