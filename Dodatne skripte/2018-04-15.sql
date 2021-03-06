USE [InformacijskiSustav]
GO
SET IDENTITY_INSERT [dbo].[Camac] ON 

INSERT [dbo].[Camac] ([IdCamac], [Oznaka], [Ime], [BrojLjudi]) VALUES (1, N'1X', N'Samac', 1)
INSERT [dbo].[Camac] ([IdCamac], [Oznaka], [Ime], [BrojLjudi]) VALUES (2, N'2-', N'Dvojac bez kormilara', 2)
INSERT [dbo].[Camac] ([IdCamac], [Oznaka], [Ime], [BrojLjudi]) VALUES (3, N'2+', N'Dvojac s kormilarom', 3)
INSERT [dbo].[Camac] ([IdCamac], [Oznaka], [Ime], [BrojLjudi]) VALUES (4, N'2X', N'Dvojac na pariče', 2)
INSERT [dbo].[Camac] ([IdCamac], [Oznaka], [Ime], [BrojLjudi]) VALUES (5, N'4-', N'Četverac bez kormilara', 4)
INSERT [dbo].[Camac] ([IdCamac], [Oznaka], [Ime], [BrojLjudi]) VALUES (6, N'4+', N'Četverac s kormilarom', 5)
INSERT [dbo].[Camac] ([IdCamac], [Oznaka], [Ime], [BrojLjudi]) VALUES (7, N'4x', N'Četverac na pariče', 4)
INSERT [dbo].[Camac] ([IdCamac], [Oznaka], [Ime], [BrojLjudi]) VALUES (8, N'8+', N'Osmerac', 9)
SET IDENTITY_INSERT [dbo].[Camac] OFF
SET IDENTITY_INSERT [dbo].[Lokacija] ON 

INSERT [dbo].[Lokacija] ([IdLokacija], [Naziv], [Lokacija]) VALUES (1, N'Jarun', 0xE61000000210749B70AFCCD32F40AF0B3F389FE44640749B70AFCCD32F40AF0B3F389FE44640)
SET IDENTITY_INSERT [dbo].[Lokacija] OFF
SET IDENTITY_INSERT [dbo].[Regata] ON 

INSERT [dbo].[Regata] ([IdRegata], [Ime], [DatumPocetak], [DatumKraj], [IdLokacija]) VALUES (1, N'1. Regata VKMF', CAST(N'2016-09-17' AS Date), CAST(N'2016-09-17' AS Date), 1)
SET IDENTITY_INSERT [dbo].[Regata] OFF
SET IDENTITY_INSERT [dbo].[StarosnaKategorija] ON 

INSERT [dbo].[StarosnaKategorija] ([IdStarosnaKategorija], [Oznaka], [Ime], [StarostPocetak], [StarostKraj]) VALUES (3, N'KM', N'Kadeti', NULL, 14)
INSERT [dbo].[StarosnaKategorija] ([IdStarosnaKategorija], [Oznaka], [Ime], [StarostPocetak], [StarostKraj]) VALUES (4, N'JMB', N'Mlađi Juniori', 15, 16)
INSERT [dbo].[StarosnaKategorija] ([IdStarosnaKategorija], [Oznaka], [Ime], [StarostPocetak], [StarostKraj]) VALUES (5, N'JMA', N'Juniori', 17, 18)
INSERT [dbo].[StarosnaKategorija] ([IdStarosnaKategorija], [Oznaka], [Ime], [StarostPocetak], [StarostKraj]) VALUES (6, N'SM', N'Seniori', 19, NULL)
SET IDENTITY_INSERT [dbo].[StarosnaKategorija] OFF
SET IDENTITY_INSERT [dbo].[Kategorija] ON 

INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica]) VALUES (1, 1, 4, 2, N'2-JMB')
SET IDENTITY_INSERT [dbo].[Kategorija] OFF
SET IDENTITY_INSERT [dbo].[Posada] ON 

INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (1, 1, N'JAR                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (2, 1, N'ZAG                 ')
SET IDENTITY_INSERT [dbo].[Posada] OFF
SET IDENTITY_INSERT [dbo].[RangUtrke] ON 

INSERT [dbo].[RangUtrke] ([IdRangUtrke], [Kratica], [Naziv]) VALUES (1, N'FA', N'Finale A')
INSERT [dbo].[RangUtrke] ([IdRangUtrke], [Kratica], [Naziv]) VALUES (2, N'FB', N'Finale B')
INSERT [dbo].[RangUtrke] ([IdRangUtrke], [Kratica], [Naziv]) VALUES (3, N'KV', N'Kvalifikacije')
SET IDENTITY_INSERT [dbo].[RangUtrke] OFF
SET IDENTITY_INSERT [dbo].[Utrka] ON 

INSERT [dbo].[Utrka] ([IdUtrka], [IdKategorija], [IdRangUtrke], [RedniBroj], [StartnoVrijeme]) VALUES (1, 1, 1, 35, CAST(N'2018-04-15 15:38:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Utrka] OFF
SET IDENTITY_INSERT [dbo].[Klub] ON 

INSERT [dbo].[Klub] ([IdKlub], [Ime], [Kratica]) VALUES (1, N'Croatia', N'CRO')
INSERT [dbo].[Klub] ([IdKlub], [Ime], [Kratica]) VALUES (2, N'Istra', N'IST')
INSERT [dbo].[Klub] ([IdKlub], [Ime], [Kratica]) VALUES (3, N'Jarun', N'JAR')
INSERT [dbo].[Klub] ([IdKlub], [Ime], [Kratica]) VALUES (4, N'Mladost', N'MLA')
INSERT [dbo].[Klub] ([IdKlub], [Ime], [Kratica]) VALUES (5, N'Zagreb', N'ZAG')
SET IDENTITY_INSERT [dbo].[Klub] OFF
SET IDENTITY_INSERT [dbo].[Veslac] ON 

INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1, N'Dominik', N'Vukmanić', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (2, N'Lukas', N'Jovakarić', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (3, N'Domagoj', N'Alber', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (4, N'Paulo', N'Possi', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (5, N'Drago', N'Tolić', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (6, N'Antoni', N'Dovođa', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (7, N'Zvonimir', N'Bandov', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (8, N'Lovro', N'Šurina', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (9, N'Benedikt Petar', N'Barun', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (10, N'Vinko', N'Brezić', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Veslac] OFF
SET IDENTITY_INSERT [dbo].[PripadnostKlubu] ON 

INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (2, 1, 1, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (3, 2, 1, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (4, 3, 2, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (5, 4, 2, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (6, 5, 3, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (7, 6, 3, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (8, 7, 4, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (9, 8, 4, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (10, 9, 5, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (11, 10, 5, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[PripadnostKlubu] OFF
SET IDENTITY_INSERT [dbo].[KontrolnaTocka] ON 

INSERT [dbo].[KontrolnaTocka] ([IdKontrolnaTocka], [Udaljenost]) VALUES (1, 500)
INSERT [dbo].[KontrolnaTocka] ([IdKontrolnaTocka], [Udaljenost]) VALUES (2, 1000)
INSERT [dbo].[KontrolnaTocka] ([IdKontrolnaTocka], [Udaljenost]) VALUES (3, 1500)
INSERT [dbo].[KontrolnaTocka] ([IdKontrolnaTocka], [Udaljenost]) VALUES (4, 2000)
SET IDENTITY_INSERT [dbo].[KontrolnaTocka] OFF
SET IDENTITY_INSERT [dbo].[Rezultat] ON 

INSERT [dbo].[Rezultat] ([IdRezultat], [IdUtrka], [IdPosada], [Staza]) VALUES (1, 1, 1, 1)
INSERT [dbo].[Rezultat] ([IdRezultat], [IdUtrka], [IdPosada], [Staza]) VALUES (2, 1, 2, 2)
SET IDENTITY_INSERT [dbo].[Rezultat] OFF
SET IDENTITY_INSERT [dbo].[ProlaznoVrijeme] ON 

INSERT [dbo].[ProlaznoVrijeme] ([IdProlaznoVrijeme], [IdKontrolnaTocka], [IdRezultat], [Vrijeme]) VALUES (1, 4, 1, CAST(N'00:08:21.5300000' AS Time))
INSERT [dbo].[ProlaznoVrijeme] ([IdProlaznoVrijeme], [IdKontrolnaTocka], [IdRezultat], [Vrijeme]) VALUES (2, 4, 2, CAST(N'00:08:25.9000000' AS Time))
SET IDENTITY_INSERT [dbo].[ProlaznoVrijeme] OFF
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (1, 5, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (1, 6, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (2, 9, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (2, 10, 2)
