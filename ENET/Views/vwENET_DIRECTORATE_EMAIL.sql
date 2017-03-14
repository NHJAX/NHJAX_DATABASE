CREATE VIEW dbo.vwENET_DIRECTORATE_EMAIL
AS
SELECT     AUD.AudienceId AS DirectorateId, DIR.AudienceId, TECH.EMailAddress
FROM         dbo.AUDIENCE AS AUD INNER JOIN
                      dbo.vwENET_AUDIENCE_DIRECTORATE AS DIR ON AUD.AudienceId = DIR.DirectorateId INNER JOIN
                      dbo.AUDIENCE_MEMBER AS AMEM ON AUD.AudienceId = AMEM.AudienceId INNER JOIN
                      dbo.AUDIENCE_BILLET AS ABIL ON AMEM.BilletId = ABIL.BilletId INNER JOIN
                      dbo.TECHNICIAN AS TECH ON AMEM.TechnicianId = TECH.UserId INNER JOIN
                      dbo.BILLET ON AMEM.BilletId = dbo.BILLET.BilletId
WHERE     (AUD.AudienceCategoryId = 2) AND (AUD.Inactive = 0) AND (AMEM.BilletId > 0) AND (ABIL.AudienceId IN (76, 77)) AND (TECH.Inactive = 0) AND (TECH.Deployed = 0) AND
                       (TECH.UserId NOT IN
                          (SELECT     UserId
                            FROM          dbo.TECHNICIAN_EXTENDED
                            WHERE      (Deployed = 1) AND (ReturnDate > GETDATE())))

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
         Begin Table = "AUD"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 217
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DIR"
            Begin Extent = 
               Top = 6
               Left = 255
               Bottom = 84
               Right = 406
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AMEM"
            Begin Extent = 
               Top = 6
               Left = 444
               Bottom = 114
               Right = 616
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ABIL"
            Begin Extent = 
               Top = 84
               Left = 255
               Bottom = 192
               Right = 411
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TECH"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 216
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "BILLET"
            Begin Extent = 
               Top = 114
               Left = 449
               Bottom = 222
               Right = 604
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
    ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwENET_DIRECTORATE_EMAIL';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'     Width = 1500
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwENET_DIRECTORATE_EMAIL';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwENET_DIRECTORATE_EMAIL';

