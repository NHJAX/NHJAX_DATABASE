﻿CREATE TABLE [dbo].[LAB_TEST_IN_PANEL] (
    [LabTestId]        BIGINT   NOT NULL,
    [LabTestInPanelId] BIGINT   NOT NULL,
    [CreatedDate]      DATETIME CONSTRAINT [DF_LAB_TEST_IN_PANEL_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_LAB_TEST_IN_PANEL] PRIMARY KEY CLUSTERED ([LabTestId] ASC, [LabTestInPanelId] ASC),
    CONSTRAINT [FK_LAB_TEST_IN_PANEL_LAB_TEST] FOREIGN KEY ([LabTestId]) REFERENCES [dbo].[LAB_TEST] ([LabTestid]),
    CONSTRAINT [FK_LAB_TEST_IN_PANEL_LAB_TEST1] FOREIGN KEY ([LabTestInPanelId]) REFERENCES [dbo].[LAB_TEST] ([LabTestid])
);

