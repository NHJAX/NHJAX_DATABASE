﻿CREATE TABLE [dbo].[RADIOLOGY_PROCEDURES$PROCEDURES_IN_GROUP] (
    [KEY_SITE]                                     NUMERIC (5)     NULL,
    [KEY_RADIOLOGY_PROCEDURES]                     NUMERIC (10, 3) NULL,
    [KEY_RADIOLOGY_PROCEDURES$PROCEDURES_IN_GROUP] NUMERIC (8, 3)  NULL,
    [PROCEDURE_IEN]                                NUMERIC (21, 3) NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_RADIOLOGY_PROCEDURES$PROCEDURES_IN_GROUP]
    ON [dbo].[RADIOLOGY_PROCEDURES$PROCEDURES_IN_GROUP]([KEY_SITE] ASC, [KEY_RADIOLOGY_PROCEDURES] ASC, [KEY_RADIOLOGY_PROCEDURES$PROCEDURES_IN_GROUP] ASC);

