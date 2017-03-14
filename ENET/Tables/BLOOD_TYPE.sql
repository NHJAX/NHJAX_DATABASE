CREATE TABLE [dbo].[BLOOD_TYPE] (
    [BloodTypeId]   INT           NOT NULL,
    [BloodTypeDesc] NVARCHAR (50) NULL,
    [BloodTypeCode] NVARCHAR (3)  NULL,
    CONSTRAINT [PK_BLOOD_TYPE] PRIMARY KEY CLUSTERED ([BloodTypeId] ASC)
);

