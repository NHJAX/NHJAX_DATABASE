CREATE TABLE [dbo].[DM_DIABETES_KEY_LAB_RESULTS] (
    [KeyLabResultId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [ProviderId]     BIGINT        NOT NULL,
    [PatientId]      BIGINT        NOT NULL,
    [A1C]            NVARCHAR (50) NULL,
    [LDL]            NVARCHAR (50) NULL,
    [GFR]            NVARCHAR (50) NULL,
    [A1cDate]        DATETIME      NULL,
    [LDLDate]        DATETIME      NULL,
    [GFRDate]        DATETIME      NULL,
    [CreatedDate]    SMALLDATETIME CONSTRAINT [DF_DM_DIABETES_KEY_LAB_RESULTS_CreatedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_DM_DIABETES_KEY_LAB_RESULTS] PRIMARY KEY CLUSTERED ([KeyLabResultId] ASC)
);

