﻿CREATE VIEW [dbo].[vwENET_SoftwareLoaded]
AS
SELECT     dbo.SOFTWARE_NAME.SoftwareId, dbo.ASSET_FILE.CreatedDate, dbo.ASSET.NetworkName, dbo.TECHNICIAN.ULName, dbo.TECHNICIAN.UFName, 
                      dbo.TECHNICIAN.UMName
FROM         dbo.SOFTWARE_NAME INNER JOIN
                      dbo.ASSET_FILE ON dbo.SOFTWARE_NAME.SoftwareId = dbo.ASSET_FILE.SoftwareId INNER JOIN
                      dbo.ASSET ON dbo.ASSET_FILE.AssetId = dbo.ASSET.AssetId INNER JOIN
                      dbo.vwPointOfContact ON dbo.ASSET.AssetId = dbo.vwPointOfContact.AssetId INNER JOIN
                      dbo.TECHNICIAN ON dbo.vwPointOfContact.POCid = dbo.TECHNICIAN.UserId
WHERE     (dbo.SOFTWARE_NAME.Inactive = 0)
GROUP BY dbo.SOFTWARE_NAME.SoftwareId, dbo.ASSET_FILE.CreatedDate, dbo.ASSET.NetworkName, dbo.TECHNICIAN.ULName, dbo.TECHNICIAN.UFName, 
                      dbo.TECHNICIAN.UMName


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
         Configuration = "(H (4 [30] 2 [40] 3))"
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
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "SOFTWARE_NAME"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 253
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ASSET_FILE"
            Begin Extent = 
               Top = 6
               Left = 291
               Bottom = 114
               Right = 487
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ASSET"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwPointOfContact"
            Begin Extent = 
               Top = 6
               Left = 525
               Bottom = 84
               Right = 692
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TECHNICIAN"
            Begin Extent = 
               Top = 114
               Left = 285
               Bottom = 222
               Right = 479
            End
            DisplayFlags = 280
            TopColumn = 0
         End
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
      Begin ColumnWidths = 12
         Column = 1440
         Alias', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwENET_SoftwareLoaded';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' = 900
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwENET_SoftwareLoaded';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwENET_SoftwareLoaded';

