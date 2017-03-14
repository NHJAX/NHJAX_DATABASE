CREATE TABLE [dbo].[BED] (
    [BedId]        BIGINT        IDENTITY (1, 1) NOT NULL,
    [BedKey]       VARCHAR (254) NULL,
    [PatientId]    BIGINT        NULL,
    [BedStatusId]  INT           CONSTRAINT [DF_BED_BedStatusId] DEFAULT ((0)) NULL,
    [BedNumber]    VARCHAR (2)   NULL,
    [DepartmentId] BIGINT        NULL,
    [BedDesc]      VARCHAR (30)  NULL,
    [CreatedDate]  DATETIME      CONSTRAINT [DF_BED_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]  DATETIME      CONSTRAINT [DF_BED_UpdatedDate] DEFAULT (getdate()) NULL,
    [Inactive]     BIT           CONSTRAINT [DF_BED_Inactive] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_BED] PRIMARY KEY CLUSTERED ([BedId] ASC)
);

