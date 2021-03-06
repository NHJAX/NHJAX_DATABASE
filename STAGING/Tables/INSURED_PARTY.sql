﻿CREATE TABLE [dbo].[INSURED_PARTY] (
    [KEY_SITE]           NUMERIC (5)     NULL,
    [KEY_INSURED_PARTY]  NUMERIC (13, 3) NULL,
    [PATIENT_IEN]        NUMERIC (21, 3) NULL,
    [PRIMARY_POLICY_IEN] NUMERIC (21, 3) NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_INSURED_PARTY]
    ON [dbo].[INSURED_PARTY]([KEY_SITE] ASC, [KEY_INSURED_PARTY] ASC);

