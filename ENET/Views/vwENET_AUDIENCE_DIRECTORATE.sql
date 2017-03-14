﻿CREATE VIEW dbo.vwENET_AUDIENCE_DIRECTORATE
AS
SELECT     AudienceId, 1 AS DirectorateId
FROM         dbo.AUDIENCE
WHERE     AudienceId IN (1, 11, 12)
UNION
SELECT     AudienceId, ReportsUnder AS DirectorateId
FROM         dbo.AUDIENCE
WHERE     (AudienceCategoryId = 2 AND Inactive = 0)
UNION
SELECT     AudienceId, ReportsUnder AS DirectorateId
FROM         dbo.AUDIENCE
WHERE     (AudienceCategoryId = 3) AND ReportsUnder NOT IN (16,92,127) AND AudienceId > 0 AND Inactive = 0 AND ReportsUnder > 0
UNION
SELECT     AudienceId, 1 AS DirectorateId
FROM         dbo.AUDIENCE
WHERE     (AudienceCategoryId = 3) AND ReportsUnder IN (16) AND AudienceId > 0 AND Inactive = 0
UNION
SELECT     DIV.AudienceId, DIV.ReportsUnder AS DirectorateId
FROM         dbo.AUDIENCE AS DIV INNER JOIN
                      dbo.AUDIENCE AS AUD ON DIV.ReportsUnder = AUD.AudienceId
WHERE     (DIV.AudienceCategoryId = 7) AND (AUD.AudienceCategoryId <= 2) AND (AUD.Inactive = 0)
UNION
SELECT     DIV.AudienceId, DIR.AudienceId AS DirectorateId
FROM         dbo.AUDIENCE AS DIV INNER JOIN
                      dbo.AUDIENCE AS AUD ON DIV.ReportsUnder = AUD.AudienceId INNER JOIN
                      dbo.AUDIENCE AS DIR ON AUD.ReportsUnder = DIR.AudienceId
WHERE     (DIV.AudienceCategoryId = 7) AND (AUD.AudienceCategoryId > 2) AND (DIR.AudienceCategoryId < 3) AND (AUD.Inactive = 0)
UNION
SELECT     TOP (100) PERCENT SUB.AudienceId, AUD.ReportsUnder AS DirectorateId
FROM         dbo.AUDIENCE AS DIV INNER JOIN
                      dbo.AUDIENCE AS AUD ON DIV.ReportsUnder = AUD.AudienceId INNER JOIN
                      dbo.AUDIENCE AS SUB ON DIV.AudienceId = SUB.ReportsUnder
WHERE     (DIV.AudienceCategoryId = 7) AND (DIV.AudienceCategoryId > 3) AND (AUD.Inactive = 0) AND (AUD.ReportsUnder > 0)

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwENET_AUDIENCE_DIRECTORATE';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[31] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 3
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwENET_AUDIENCE_DIRECTORATE';

