CREATE TABLE [dbo].[HOSPITAL_LOCATION] (
    [HospitalLocationId]      BIGINT          IDENTITY (0, 1) NOT NULL,
    [HospitalLocationKey]     NUMERIC (12, 4) NULL,
    [HospitalLocationName]    VARCHAR (36)    NULL,
    [HospitalLocationDesc]    VARCHAR (31)    NULL,
    [MeprsCodeId]             BIGINT          NULL,
    [CreatedDate]             DATETIME        CONSTRAINT [DF_HOSPITAL_LOCATION_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]             DATETIME        CONSTRAINT [DF_HOSPITAL_LOCATION_UpdatedDate] DEFAULT (getdate()) NULL,
    [SourceSystemId]          BIGINT          CONSTRAINT [DF_HOSPITAL_LOCATION_SourceSystemId] DEFAULT ((2)) NULL,
    [GroupPhone]              VARCHAR (15)    NULL,
    [MedicalCenterDivisionId] BIGINT          NULL,
    CONSTRAINT [PK_HOSPITAL_LOCATION] PRIMARY KEY CLUSTERED ([HospitalLocationId] ASC),
    CONSTRAINT [FK_HOSPITAL_LOCATION_MEPRS_CODE] FOREIGN KEY ([MeprsCodeId]) REFERENCES [dbo].[MEPRS_CODE] ([MeprsCodeId])
);


GO
CREATE NONCLUSTERED INDEX [IX_HOSPITAL_LOCATION_KEY]
    ON [dbo].[HOSPITAL_LOCATION]([HospitalLocationKey] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_HOSPITAL_LOCATION_HospitalLocationName]
    ON [dbo].[HOSPITAL_LOCATION]([HospitalLocationName] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_HOSPITAL_LOCATION_DESC]
    ON [dbo].[HOSPITAL_LOCATION]([HospitalLocationDesc] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);

